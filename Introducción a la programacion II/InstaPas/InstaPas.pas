// Hecho por Manuel Torres //
Program InstaPas;

uses
    Crt, sysutils, DateUtils;

const
    LongitudContrasenia= 8;

Type
    USERNAME= String;
    PASSWORD= String[LongitudContrasenia]; // Facilita a la hora de cambiar el programa ya que cambiara toda las ocurrencias //
    EMAIL= String;
    Usuarios= record
        nombre: USERNAME;
        password: PASSWORD;
        email: EMAIL;
    end;
    Historias= record
        fechahora: TDateTime;
        texto: string;
        nombre: USERNAME;
    end;
    Seguidos= record
        seguidor: USERNAME;
        seguido: USERNAME;
    end;
    TArchivoUsuarios= File of Usuarios;
    TArchivoHistorias= File of Historias;
    TArchivoSeguidos= File of Seguidos;
    TPuntArbol= ^NodoUsuarioArbol;
    TPuntSeguidos= ^NodoSeguidos;
    TPuntHistoria= ^NodoListaHistorias;
    NodoUsuarioArbol= record
        nombre: USERNAME;
        password: PASSWORD;
        email: EMAIL;
        Seguidos: TPuntSeguidos;
        Historias: TPuntHistoria;
        Menores, Mayores: TPuntArbol;
    end;
    NodoListaHistorias= record
        fechaHora: TDateTime;
        texto: string;
        Sig: TPuntHistoria;
    end;
    NodoSeguidos= record
        nombre: string;
        Sig: TPuntSeguidos;
    end;

// Escribe un texto de forma centrada en una linea // eje x
procedure EscribirCentrado(texto: string);
var
    anchoConsola, espaciosAntes: integer;
begin
    anchoConsola:= WindMaxX + 1; 
    espaciosAntes:= (anchoConsola - Length(texto)) div 2;

    // Mueve el cursor a la posición //
    GotoXY(espaciosAntes + 1, WhereY); 
    writeln(texto);
end;

// Recorre el arbol en PreOrder y guarda sus datos en archivoUsuarios //
procedure RecorrerPreOrder(arbol: TPuntArbol; var arch: TArchivoUsuarios);
var 
    usuario: Usuarios;
begin
    if arbol <> nil then begin
        usuario.nombre:= arbol^.nombre;
        usuario.email:= arbol^.email;
        usuario.password:= arbol^.password;
        write(arch, usuario);
        RecorrerPreOrder(arbol^.Menores, arch);
        RecorrerPreOrder(arbol^.Mayores, arch);
    end;
end;

// Recorre todos los usuarios y guarda sus historias en un archivo //
procedure RecorrerHistorias(arbol: TPuntArbol; var arch: TArchivoHistorias);
var 
    cursor: TPuntHistoria;
    historia: Historias;
begin
    if arbol <> nil then begin
        RecorrerHistorias(arbol^.Menores, arch);
        cursor:= arbol^.Historias;
        while (cursor <> nil) do begin
            historia.nombre:= arbol^.nombre;
            historia.texto:= cursor^.texto;
            historia.fechahora:= cursor^.fechaHora;
            write(arch, historia);
            cursor:= cursor^.sig;
        end;
        RecorrerHistorias(arbol^.Mayores, arch);
    end;
end;

// Recorre todos los usuarios y guarda sus seguidos en un archivo //
procedure RecorrerSeguidos(arbol: TPuntArbol; var arch: TArchivoSeguidos);
var 
    cursor: TPuntSeguidos;
    seguido1: Seguidos;
begin
    if arbol <> nil then begin
        RecorrerSeguidos(arbol^.Menores, arch);
        cursor:= arbol^.Seguidos;
        while (cursor <> nil) do begin
            seguido1.seguidor:= arbol^.nombre;
            seguido1.seguido:= cursor^.nombre;
            write(arch, seguido1);
            cursor:= cursor^.sig;
        end;
        RecorrerSeguidos(arbol^.Mayores, arch);
    end;
end;

procedure GuardarArcUsuarios(var arch: TArchivoUsuarios; arbol: TPuntArbol);
begin
    Assign(arch, '/work/MTorres_Instapas_Usuarios.dat');
    rewrite(arch);
    RecorrerPreOrder(arbol, arch);
    close(arch);
end;

procedure GuardarArcHistorias(var arch: TArchivoHistorias; arbol: TPuntArbol);
begin
    Assign(arch, '/work/MTorres_Instapas_Historias.dat');
    rewrite(arch);
    RecorrerHistorias(arbol, arch);
    close(arch);
end;

procedure GuardarArcSeguidos(var arch: TArchivoSeguidos; arbol: TPuntArbol);
begin
    Assign(arch, '/work/MTorres_Instapas_Seguidos.dat');
    rewrite(arch);
    RecorrerSeguidos(arbol, arch);
    close(arch);
end;

procedure GuardarArchivos(var archUsu: TArchivoUsuarios; var archHis: TArchivoHistorias; var archSeg: TArchivoSeguidos; arbol: TPuntArbol);
begin
    GuardarArcUsuarios(archUsu, arbol);
    GuardarArcHistorias(archHis, arbol);
    GuardarArcSeguidos(archSeg, arbol);
end;

// Cierra el programa completamente guardando los archivos //
procedure Salir(var archUsu: TArchivoUsuarios; var archHis: TArchivoHistorias; var archSeg: TArchivoSeguidos; arbol: TPuntArbol);
begin
    GuardarArchivos(archUsu, archHis, archSeg, arbol);
    ClrScr;
    writeln('');
    EscribirCentrado('Saliste con exito.');
    EscribirCentrado('¡Gracias por usar InstaPas!');
    EscribirCentrado('Hecho por Manuel Torres.');
    writeln('');
end;

procedure AbrirArcUsuarios(var arch: TArchivoUsuarios);
var 
    usuario: Usuarios;
begin
    Assign(arch, '/work/MTorres_Instapas_Usuarios.dat');
    {$I-} 
    reset(arch); 
    {$I+} 
    if ioresult <> 0 then begin // SI NO EXISTE
        rewrite(arch);
        usuario.nombre:= 'admin';
        usuario.email:= 'admin@gmail.com';
        usuario.password:= 'admin';
        write(arch, usuario);
    end;
    close(arch);
end;

procedure AbrirArcHistorias(var arch: TArchivoHistorias);
begin
    Assign(arch, '/work/MTorres_Instapas_Historias.dat');
    {$I-} 
    reset(arch); 
    {$I+} 
    if ioresult <> 0 then begin
        rewrite(arch);
    end;
    close(arch);
end;

procedure AbrirArcSeguidos(var arch: TArchivoSeguidos);
begin
    Assign(arch, '/work/MTorres_Instapas_Seguidos.dat');
    {$I-} 
    reset(arch); 
    {$I+} 
    if ioresult <> 0 then begin
        rewrite(arch);
    end;
    close(arch);
end;

// Abre los 3 archivos juntos //
procedure AbrirArchivos(var archUsu: TArchivoUsuarios; var archHis: TArchivoHistorias; var archSeg: TArchivoSeguidos);
begin
    AbrirArcUsuarios(archUsu);
    AbrirArcHistorias(archHis);
    AbrirArcSeguidos(archSeg);
end;

// Pasar el usuario desde el archivo al lugar correcto en el arbol, en orden ascendiente //
// Tambien sirve para crear un usuario nuevo sin que este en el archivo //
procedure PasarUsuario(var pos: TPuntArbol; nodo: TPuntArbol);
begin
    if pos = NIL then
        pos:= nodo
    else if pos^.nombre < nodo^.nombre then
        PasarUsuario(pos^.mayores, nodo)
    else
        PasarUsuario(pos^.menores, nodo);
end;

// Pasar la historia desde el archivo al lugar correcto en el arbol, en orden descendente //
procedure PasarHistorias(var pos: TPuntHistoria; historia: Historias);
var
    nodo: TPuntHistoria;
begin
    if (pos = NIL) or (pos^.fechahora <= historia.fechahora) then begin
        new(nodo);
        nodo^.fechahora:= historia.fechahora;
        nodo^.texto:= historia.texto;
        nodo^.sig:= pos;
        pos:= nodo;
    end
    else
        PasarHistorias(pos^.sig, historia);
end;

// Pasar el seguido desde el archivo al lugar correcto en el arbol, en orden ascendente //
procedure PasarSeguidos(var pos: TPuntSeguidos; seguidos: Seguidos);
var
    nodo: TPuntSeguidos;
begin
    if (pos = NIL) or (pos^.nombre >= seguidos.seguido) then begin
        new(nodo);
        nodo^.nombre:= seguidos.seguido;
        nodo^.sig:= pos;
        pos:= nodo;
    end
    else
        PasarSeguidos(pos^.sig, seguidos);
end;

// Al iniciar el programa crea un arbol binario de usuarios con informacion proveniente de archivos //
procedure CrearArbolUsuarios(var archUsu: TArchivoUsuarios; var archHis: TArchivoHistorias; var archSeg: TArchivoSeguidos; var arbol: TPuntArbol);
var
    nodo: TPuntArbol;
    usuario: Usuarios;
    historia: Historias;
    seguido: Seguidos;
begin
    reset(archUsu);
    reset(archHis);
    reset(archSeg);
    arbol:= nil;
    // Si no hay usuarios en el archivo, no añade nodo al arbol y lo señala como nil, despues termina el procedimiento //
    if FileSize(archUsu) = 0 then begin
        arbol:= NIL;
        exit;
    end;

    // Agrega los nombres, passwords y emails de todos los usuarios en el archivo //
    seek(archUsu, 0);
    while not (eof(archUsu)) do begin
        Read(archUsu, usuario);
        new(nodo);
        nodo^.nombre:= usuario.nombre;
        nodo^.password:= usuario.password;
        nodo^.email:= usuario.email;
        nodo^.seguidos:= NIL;
        nodo^.historias:= NIL;
        nodo^.menores:= NIL;
        nodo^.mayores:= NIL;
        PasarUsuario(arbol, nodo);

        // Pasa las historias pertenecientes al usuario desde el archivo //
        Seek(archHis, 0);
        while not (eof(archHis)) do begin
            Read(archHis, historia);
            if (historia.nombre) = (usuario.nombre) then
                PasarHistorias(arbol^.historias, historia);
        end;

        // Pasa los seguidos pertenecientes al usuario desde el archivo //
        Seek(archSeg, 0);
        while not (eof(archSeg)) do begin
            Read(archSeg, seguido);
            if (seguido.seguidor) = (usuario.nombre) then
                PasarSeguidos(arbol^.seguidos, seguido);
        end;
    end;
    close(archUsu);
    close(archHis);
    close(archSeg);
end;

// Devuelve NIL si NO encuentra el usuario. Si lo encuentra devuelve le puntero hacia el //
function EncontrarUsuario(nombre: USERNAME; arbol: TPuntArbol): TPuntArbol;
begin
    if arbol = NIL then
        EncontrarUsuario:= NIL
    else if arbol^.nombre = nombre then
        EncontrarUsuario:= arbol
    else if arbol^.nombre < nombre then
        EncontrarUsuario:= EncontrarUsuario(nombre, arbol^.mayores)
    else 
        EncontrarUsuario:= EncontrarUsuario(nombre, arbol^.menores);
end;

// Devuelve true si el usuario existe //
function ExisteUsuario(nombre: USERNAME; arbol: TPuntArbol): boolean;
begin
    if (EncontrarUsuario(nombre, arbol) = NIL) then
        ExisteUsuario:= false
    else
        ExisteUsuario:= true;
end;

// Al seleccionar la opcion de iniciar sesion en la pantalla de inicio ejecuta este modulo //
procedure IniciarSesion(var arbol: TPuntArbol; var usuario:  Usuarios; var iniciado: boolean);
var 
    cursor: TPuntArbol;
begin
    cursor:= arbol;
    ClrScr;
    writeln('');
    EscribirCentrado('InstaPas');
    writeln('');
    writeln('Iniciar sesión: ');
    write('Nombre de usuario: ');
    readln(usuario.nombre);
    while not ExisteUsuario(usuario.nombre, cursor) do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('¡Ese nombre de usuario no existe! Intentelo de nuevo.');
        writeln('Intento previo: "', usuario.nombre,'"');
        writeln('');
        writeln('Iniciar sesión: ');
        write('Nombre de usuario: ');
        readln(usuario.nombre);
    end;
    cursor:= EncontrarUsuario(usuario.nombre, cursor);
    write('Contraseña: ');
    readln(usuario.password);
    while not (usuario.password = cursor^.password) do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('¡La contraseña no es correcta! Intentelo de nuevo.');
        writeln('');
        writeln('Nombre de usuario: ', usuario.nombre);
        write('Contraseña: ');
        readln(usuario.password);
    end;
    iniciado:= true;
end;

// Al seleccionar la opcion de registrarse en la pantalla de inicio ejecuta este modulo //
procedure Registrarse(var arbol: TPuntArbol; var usuario:  Usuarios; var iniciado: boolean);
var
    cursor, nodo: TPuntArbol;
    password2: PASSWORD;
    eleccion: boolean;
    SN: char;
begin
    cursor:= arbol;
    eleccion:= false;
    while not eleccion do begin // Repite si el usuario no esta conforme con su elección de cuenta //
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Registrarse: ');
        write('Nombre de usuario: ');
        readln(usuario.nombre);
        while ExisteUsuario(usuario.nombre, cursor) do begin
            ClrScr;
            writeln('');
            EscribirCentrado('InstaPas');
            writeln('');
            writeln('¡Ese nombre de usuario ya esta en uso! Intentelo de nuevo.');
            writeln('');
            writeln('Registrarse: ');
            write('Nombre de usuario: ');
            readln(usuario.nombre);
        end;
        write('Email: ');
        readln(usuario.email);
        write('Contraseña(maximo ', LongitudContrasenia, ' caracteres): ');
        readln(usuario.password);
        write('Confirma contraseña: ');
        readln(password2);
        while not (usuario.password = password2) do begin
            ClrScr;
            writeln('');
            EscribirCentrado('InstaPas');
            writeln('');
            writeln('¡La contraseñas no coinciden! Intentelo de nuevo. ');
            writeln('');
            writeln('Registrarse: ');
            writeln('Nombre de usuario: ', usuario.nombre);
            writeln('Email: ', usuario.email);
            write('Contraseña(maximo ', LongitudContrasenia, ' caracteres): ');
            readln(usuario.password);
            write('Confirma contraseña: ');
            readln(password2);
        end;
    
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Registrarse: ');
        writeln('Nombre de usuario: ', usuario.nombre);
        writeln('Email: ', usuario.email);
        writeln('Contraseña: ', usuario.password);
        writeln('');
        write('¿Desea crear una cuenta con estos datos? S/N: ');
        readln(SN);
        if (UpperCase(SN) = 'S') then begin
            eleccion:= true;
        end;
    
    end;
    new(nodo);
    nodo^.nombre:= usuario.nombre;
    nodo^.password:= usuario.password;
    nodo^.email:= usuario.email;
    nodo^.seguidos:= NIL;
    nodo^.historias:= NIL;
    nodo^.menores:= NIL;
    nodo^.mayores:= NIL;
    PasarUsuario(arbol, nodo);
    iniciado:= true;
    ClrScr;
    writeln('');
    EscribirCentrado('InstaPas');
    writeln('');
    writeln('Registrarse: ');
    writeln('Nombre de usuario: ', usuario.nombre);
    writeln('Email: ', usuario.email);
    writeln('Contraseña: ', usuario.password);
    writeln('');
    write('¡Cuenta registrada con exito! Enter para continuar: ');
    readln();

end;

// Contar la cantidad de usuarios //
function CantidadDeUsuarios(cursor: TPuntArbol): integer;
var n: Integer;
begin
    n:= 0;
    if (cursor <> NIL) then begin
        n:= 1;
        n:= n + CantidadDeUsuarios(cursor^.menores);
        n:= n + CantidadDeUsuarios(cursor^.mayores);
    end;
    CantidadDeUsuarios:= n;
end;

// Devuelve la cantidad total de seguidos //
function CantidadSeguidos(arbol: TPuntArbol): integer;
var
    cursor: TPuntSeguidos;
    n: integer;
begin
    n:= 0;
    if arbol <> nil then begin
        cursor:= arbol^.Seguidos;
        while (cursor <> nil) do begin
            n:= n + 1;
            cursor:= cursor^.sig;
        end;
        n:= n + CantidadSeguidos(arbol^.Menores);
        n:= n + CantidadSeguidos(arbol^.Mayores);
    end;
    CantidadSeguidos:= n;
end;

function PromedioSeguidos(arbol: TPuntArbol; cantidad: integer): real;
var n: real;
begin
    if CantidadSeguidos(arbol) = 0 then
        n:= 0
    else
        n:= CantidadSeguidos(arbol) / cantidad;
    PromedioSeguidos:= n;
end;

// Imprime los usuarios que publicaron una historia los ultimos x dias //
procedure ImprimirHistoriasDias(arbol: TPuntArbol; dias: Integer);
var
    tiempo1, tiempo2: TDateTime;
    cursorusuario: TPuntArbol;
    cursorhistoria: TPuntHistoria;
    nombreImpreso: boolean;
begin
    tiempo1:= Now;
    tiempo2:= IncDay(tiempo1, -dias);

    if arbol <> nil then begin
        ImprimirHistoriasDias(arbol^.Menores, dias);
        cursorusuario:= arbol;

        while cursorusuario <> nil do begin
            cursorhistoria:= cursorusuario^.Historias;
            nombreImpreso:= False;

            while cursorhistoria <> nil do begin
                if cursorhistoria^.fechahora >= tiempo2 then begin
                    if not nombreImpreso then begin
                        writeln('- ', cursorusuario^.nombre);
                        nombreImpreso:= True;
                    end;
                end;
                cursorhistoria:= cursorhistoria^.sig;
            end;
            cursorusuario:= cursorusuario^.Mayores;
        end;

        ImprimirHistoriasDias(arbol^.Mayores, dias);
    end;
end;

procedure RecorrerSeguidosHis(seguidos: TPuntSeguidos; arbol: TPuntArbol; tiempo: TDateTime);
var
    cursorHistorias: TPuntHistoria;
    cursorArbol: TPuntArbol;
begin
    while seguidos <> nil do begin
        cursorArbol:= EncontrarUsuario(seguidos^.nombre, arbol);

        if cursorArbol <> nil then begin
            writeln('Historias de: ', seguidos^.nombre);
            cursorHistorias:= cursorArbol^.Historias;

            while cursorHistorias <> nil do begin
                if cursorHistorias^.fechahora >= tiempo then begin
                    writeln('Fecha: ', DateTimeToStr(cursorHistorias^.fechahora));
                    writeln('Texto: ', cursorHistorias^.texto);
                end;
                cursorHistorias:= cursorHistorias^.Sig;
            end;
        end;

        seguidos := seguidos^.Sig;
    end;
end;

procedure ImprimirHistoriasSeguidos(arbol, usuario: TPuntArbol; dias: Integer);
var
    tiempo1, tiempo2: TDateTime;
begin
    tiempo1:= Now;
    tiempo2:= IncDay(tiempo1, -dias);
    
    if usuario <> nil then begin
        RecorrerSeguidosHis(usuario^.Seguidos, arbol, tiempo2);
    end;
end;

procedure ImprimirHistoriasSeg(arbol: TPuntArbol; username: USERNAME);
var 
    usuario: TPuntArbol;
    valor: integer;
    terminado: boolean;
    SN: char;
begin
    usuario:= EncontrarUsuario(username, arbol);
    terminado:= false;
    while not terminado do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Ingrese un número para ver ');
        write('historias subidas en esos ultimos dias: ');
        readln(valor);
        
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        ImprimirHistoriasSeguidos(arbol, usuario, valor);
        writeln('');
        write('¿Desea volver al menu? S/N: ');
        readln(SN);
        if (UpperCase(SN) = 'S') then
            terminado:= true;
    end;
end;

procedure ImprimirHistorias(arbol: TPuntArbol);
var 
    valor: integer;
    terminado: boolean;
    SN: char;
begin
    terminado:= false;
    while not terminado do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Ingrese un número para ver la cantidad de');
        write('usuarios que subieron historias en esos ultimos dias: ');
        readln(valor);
        
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Usuarios que subieron historias en los ultimos ', valor, ' dias: ');
        writeln('');
        ImprimirHistoriasDias(arbol, valor);
        writeln('');
        write('¿Desea volver al menu? S/N: ');
        readln(SN);
        if (UpperCase(SN) = 'S') then
            terminado:= true;
    end;
end;

procedure EscribirHistoria(var arbol: TPuntArbol; usuario: USERNAME);
var
    historia: Historias;
    cursor: TPuntArbol;
    terminado: boolean;
    SN: char;
begin
    terminado:= false;
    while not terminado do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Crear historia: ');
        write('Ingrese el texto de la historia: ');
        readln(historia.texto);
        historia.fechaHora:= Now;
        historia.nombre:= usuario;
        cursor:= EncontrarUsuario(usuario, arbol);
        
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Crear historia: ');
        writeln('Texto de la historia: ', historia.texto);
        write('¿Desea subir esta historia? S/N: ');
        writeln('');
        readln(SN);
        if (UpperCase(SN) = 'S') then begin
            terminado:= true;
            PasarHistorias(cursor^.Historias, historia);
            ClrScr;
            writeln('');
            EscribirCentrado('InstaPas');
            writeln('');
            writeln('¡Historia creada con exito!');
            writeln('Texto de la historia: ', historia.texto);
            write('Enter para continuar: ');
            readln();
        end;
    end;
end;

// Imprime una lista de seguidos //
procedure ImprimirSeguidos(arbol: TPuntArbol; username: USERNAME);
var
    cursorseguidos: TPuntSeguidos;
begin
    arbol:= EncontrarUsuario(username, arbol);
    cursorseguidos:= arbol^.Seguidos;
    while (cursorseguidos <> NIL) do begin
        writeln('- ', cursorseguidos^.nombre);
        cursorseguidos:= cursorseguidos^.sig;
    end;
end;

procedure ListarSeguidos(arbol: TPuntArbol; username: USERNAME);
var
    terminado: boolean;
    SN: char;
begin
    terminado:= false;
    while not terminado do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('Lista de gente que sigues: ');
        ImprimirSeguidos(arbol, username);
        writeln('');
        write('¿Desea volver al menu? S/N: ');
        readln(SN);
        if (UpperCase(SN) = 'S') then
            terminado:= true;
    end;
end;

// Verifica si el usuario ya es seguido //
function ExisteSeguido(seguidos: TPuntSeguidos; nombreUsuario: USERNAME): boolean;
var
    cursor: TPuntSeguidos;
begin
    cursor:= seguidos;
    while cursor <> nil do
    begin
        if cursor^.nombre = nombreUsuario then
        begin
            ExisteSeguido:= true;
            Exit;
        end;
        cursor:= cursor^.sig;
    end;
    ExisteSeguido := false;
end;


procedure AgregarSeguido(var seguidos: TPuntSeguidos; nombreUsuario: USERNAME);
var
    nuevoSeguido, cursor: TPuntSeguidos;
begin
    if not ExisteSeguido(seguidos, nombreUsuario) then
    begin
        new(nuevoSeguido);
        nuevoSeguido^.nombre:= nombreUsuario;
        nuevoSeguido^.sig:= nil;

        if seguidos = nil then
        begin
            seguidos:= nuevoSeguido;
        end
        else
        begin
            cursor:= seguidos;
            while cursor^.sig <> nil do
            begin
                cursor:= cursor^.sig;
            end;
            cursor^.sig:= nuevoSeguido;
        end;
    end;
end;


procedure SeguirUsuario(var usuarioActual: TPuntArbol; arbol: TPuntArbol);
var
    usuarioSeguir: USERNAME;
    terminado: boolean;
    SN: char;
begin
    terminado:= false;
    while not terminado do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        write('Escriba al persona que quieres seguir: ');
        readln(usuarioSeguir);
        writeln('');
        while not (ExisteUsuario(usuarioSeguir, arbol)) do begin
            ClrScr;
            writeln('');
            EscribirCentrado('InstaPas');
            writeln('');
            writeln('Esa persona no existe. Intentalo de nuevo');
            write('Escriba al persona que quieres seguir: ');
            readln(usuarioSeguir);
            writeln('');
        end;
        write('¿Desea seguir a ', usuarioSeguir, '? S/N: ');
        readln(SN);
        if (UpperCase(SN) = 'S') then begin
            terminado:= true;
            if not ExisteSeguido(usuarioActual^.Seguidos, usuarioSeguir) then begin
                AgregarSeguido(usuarioActual^.Seguidos, usuarioSeguir);
                writeln('Ahora seguis a ', usuarioSeguir);
            end
            else begin
                writeln('Ya seguis a ', usuarioSeguir);
            end;
        end;     
    end;
        
end;

procedure DejarDeSeguir(var seguidos: TPuntSeguidos; nombreUsuario: USERNAME);
var
    cursor, anterior: TPuntSeguidos;
begin
    if seguidos <> nil then
    begin
        cursor:= seguidos;
        anterior:= nil;

        if cursor^.nombre = nombreUsuario then
        begin
            seguidos:= cursor^.sig;
            Dispose(cursor);
        end
        else
        begin
            while (cursor <> nil) and (cursor^.nombre <> nombreUsuario) do
            begin
                anterior:= cursor;
                cursor:= cursor^.sig;
            end;

            if cursor <> nil then
            begin
                anterior^.sig:= cursor^.sig;
                Dispose(cursor);
            end;
        end;
    end;
end;

procedure DejarSeguirUsuario(var usuarioActual: TPuntArbol; arbol: TPuntArbol);
var
    usuario: USERNAME;
    terminado: boolean;
    SN: char;
begin
    terminado:= false;
    while not terminado do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        write('Escriba al persona que quieres dejar de seguir: ');
        readln(usuario);
        writeln('');
        while not (ExisteUsuario(usuario, arbol)) and (ExisteSeguido(usuarioActual^.Seguidos, usuario)) do begin
            ClrScr;
            writeln('');
            EscribirCentrado('InstaPas');
            writeln('');
            writeln('Esa persona no existe o no la sigues. Intentalo de nuevo');
            write('Escriba al persona que quieres dejar de seguir: ');
            readln(usuario);
            writeln('');
        end;
        write('¿Desea dejar de seguir a ', usuario, '? S/N: ');
        readln(SN);
        if (UpperCase(SN) = 'S') then begin
            terminado:= true;
            DejarDeSeguir(usuarioActual^.Seguidos, usuario);
            writeln('Dejaste de seguir a ', usuario);
        end;     
    end;    
end;

procedure EliminarDeSeguidos(arbol: TPuntArbol; nombreUsuario: USERNAME);
var
    cursor: TPuntArbol;
    seguidosActual, seguidoAnterior, seguidoActual: TPuntSeguidos;
begin
    cursor:= EncontrarUsuario(nombreUsuario, arbol);

    if cursor <> nil then begin
        seguidosActual:= cursor^.Seguidos;
        seguidoAnterior:= nil;

        while seguidosActual <> nil do begin
            if seguidosActual^.nombre = nombreUsuario then begin
                if seguidoAnterior = nil then
                    cursor^.Seguidos:= seguidosActual^.Sig
                else
                    seguidoAnterior^.Sig:= seguidosActual^.Sig;

                seguidoActual:= seguidosActual;
                seguidosActual:= seguidosActual^.Sig;
                Dispose(seguidoActual);
        end
        else begin
            seguidoAnterior:= seguidosActual;
            seguidosActual:= seguidosActual^.Sig;
        end;
        end;
    end;
end;

procedure EliminarHistorias(var historias: TPuntHistoria);
var
  aux: TPuntHistoria;
begin
    while historias <> nil do begin
        aux:= historias;
        historias:= historias^.sig;
        Dispose(aux);
    end;
end;

procedure EliminarNodoArbol(var arbol: TPuntArbol; nombreUsuario: USERNAME);
var
  aux: TPuntArbol;
begin
    if arbol = nil then
    Exit;

    if nombreUsuario < arbol^.nombre then
        EliminarNodoArbol(arbol^.menores, nombreUsuario)
    else if nombreUsuario > arbol^.nombre then
        EliminarNodoArbol(arbol^.mayores, nombreUsuario)
    else
    begin
        if (arbol^.menores = nil) or (arbol^.mayores = nil) then begin
            if arbol^.menores = nil then
                aux := arbol^.mayores
            else
                aux := arbol^.menores;
        
            Dispose(arbol);
            arbol:= aux;
        end
        else begin
            aux:= arbol^.mayores;
            while aux^.menores <> nil do
                aux:= aux^.menores;
                arbol^.nombre:= aux^.nombre;
                arbol^.password:= aux^.password;
                arbol^.email:= aux^.email;
                EliminarNodoArbol(arbol^.mayores, aux^.nombre);
        end;
    end;
end;

procedure BorrarUsuario(var arbol: TPuntArbol; username: USERNAME);
var
    usuarioAEliminar: TPuntArbol;
begin
    usuarioAEliminar:= EncontrarUsuario(username, arbol);

    if usuarioAEliminar <> nil then
    begin
        EliminarDeSeguidos(arbol, username);
        EliminarHistorias(usuarioAEliminar^.Historias);
        EliminarNodoArbol(arbol, usuarioAEliminar^.nombre);
        Dispose(usuarioAEliminar);
    end;
end;

procedure DejarSeguirUsuarioMenu(var arbol: TPuntArbol; usuario: USERNAME);
var
    terminado: boolean;
    SN: char;
begin
    terminado:= false;
    while not terminado do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        write('¿Desea ELIMINAR tu cuenta? S/N: ');
        readln(SN);
        if (UpperCase(SN) = 'S') then begin
            terminado:= true;
            BorrarUsuario(arbol, usuario);
            ClrScr;
            writeln('');
            EscribirCentrado('InstaPas');
            writeln('');
            writeln('BORRASTE TU CUENTA.');
            write('Enter para volver al menu');
            readln();
        end;     
    end;    
end;


// Pantalla que se muestra al empezar el programa //
procedure MenuUno(var arbol: TPuntArbol; var usuario: Usuarios; var iniciado, terminado: boolean; var archUsu: TArchivoUsuarios; var archHis: TArchivoHistorias; var archSeg: TArchivoSeguidos);
var 
    valor: integer;
begin
    while not (iniciado) and not (terminado) do begin
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('- Cantidad total de usuarios: ', CantidadDeUsuarios(arbol));
        writeln('- Promedio de usuarios seguidos por usuario: ', PromedioSeguidos(arbol, CantidadDeUsuarios(arbol)):0:1);
        writeln('');
        writeln('Opciones:');
        writeln('1- Iniciar Sesión.');
        writeln('2- Registrarse.');
        writeln('3- Mostrar usuarios que han realizado historias en los ultimos x dias.');
        writeln('4- Salir');
        writeln('');
        write('- Ingrese el número de la acción a ejecutar: ');
        readln(valor);
        while not (valor >= 1) or not ( valor <= 4) do begin
            writeln('El numero ingresado no es valido, intentelo de nuevo.');
            write('- Ingrese el número de la acción a ejecutar: ');
            readln(valor);
        end;
        
        case valor of
            1: IniciarSesion(arbol, usuario, iniciado);
            2: Registrarse(arbol, usuario, iniciado);
            3: ImprimirHistorias(arbol);
            4: 
            begin
                Salir(archUsu, archHis, archSeg, arbol);
                terminado:= true;
            end;
        end;
    end;
end;

// Pantalla que se muestra al iniciar sesion o registrarse //
procedure MenuDos(var arbol: TPuntArbol; var usuario:  Usuarios; var iniciado: boolean);
var
    cursor: TPuntArbol;
    valor: integer;
begin
    while iniciado do begin
        cursor:= arbol;
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        //RecorridoInorden(arbol); // TEST
        //cursor:= EncontrarUsuario(usuario.nombre, cursor); // TEST
        //if cursor = NIL then writeln('ES NIL'); // TEST
        //writeln('Nombre: ', cursor^.nombre); // TEST
        //writeln('- Cantidad total de usuarios: ', CantidadDeUsuarios(cursor)); // TEST
        writeln('Iniciado como: ', usuario.nombre); 
        writeln('');
        writeln('Opciones: ');
        writeln('1- Ver historias de los usuarios que sigo.');
        writeln('2- Escribir una historia.');
        writeln('3- Ver lista de usuarios seguidos.');
        writeln('4- Seguir a un usuario.');
        writeln('5- Dejar de seguir a un usuario.');
        writeln('6- Borrar cuenta.');
        writeln('7- Terminar sesión.');
        writeln('');
        write('- Ingrese el número de la acción a ejecutar: ');
        readln(valor);
        while not (valor >= 1) or not ( valor <= 7) do begin
            writeln('El numero ingresado no es valido, intentelo de nuevo.');
            write('- Ingrese el número de la acción a ejecutar: ');
            readln(valor);
        end;
        case valor of
            1: ImprimirHistoriasSeg(arbol, usuario.nombre);
            2: EscribirHistoria(arbol, usuario.nombre);
            3: ListarSeguidos(arbol, usuario.nombre);
            4: 
            begin
                cursor:= EncontrarUsuario(usuario.nombre, arbol);
                SeguirUsuario(cursor, arbol);
            end; 
            5: 
            begin
                cursor:= EncontrarUsuario(usuario.nombre, arbol);
                DejarSeguirUsuario(cursor, arbol);
            end;
            6: DejarSeguirUsuarioMenu(arbol, usuario.nombre);
            7: iniciado:= false;
        end;
    end;
end;

var
    ArcUsuarios: TArchivoUsuarios;
    ArcHistorias: TArchivoHistorias;
    ArcSeguidos: TArchivoSeguidos;
    ArbolUsuarios: TPuntArbol;
    iniciado, terminado: boolean; // Indica si la sesion fue iniciada con exito //
    Usuario: Usuarios;

begin
    iniciado:= false;
    terminado:= false;
    ArbolUsuarios:= NIL;
    AbrirArchivos(ArcUsuarios, ArcHistorias, ArcSeguidos);
    CrearArbolUsuarios(ArcUsuarios, ArcHistorias, ArcSeguidos, ArbolUsuarios);
    while not terminado do begin
        MenuUno(ArbolUsuarios, Usuario, iniciado, terminado, ArcUsuarios, ArcHistorias, ArcSeguidos);
        if iniciado then begin
            MenuDos(ArbolUsuarios, Usuario, iniciado);
        end;
    end;
    
    
    
end.