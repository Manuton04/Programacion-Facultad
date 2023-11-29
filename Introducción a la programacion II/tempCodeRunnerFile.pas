// Hecho por Manuel Torres //
Program InstaPas;

uses
    Crt, sysutils;

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

procedure GuardarArcUsuarios();
begin
    
end;

procedure GuardarArcHistorias();
begin
    
end;

procedure GuardarArcSeguidos();
begin
    
end;

// Cierra el programa completamente con halt, no solo el procedimiento //
procedure Salir(iniciado: boolean);
begin
    if not iniciado then begin
        ClrScr;
        writeln('');
        EscribirCentrado('Saliste con exito.');
        EscribirCentrado('¡Gracias por usar InstaPas!');
        EscribirCentrado('Hecho por Manuel Torres.');
        writeln('');
        halt;
    end;
end;

procedure AbrirArcUsuarios(var arch: TArchivoUsuarios; var error: boolean);
begin
    error:= false;
    Assign(arch, '/work/MTorres_Instapas_Usuarios.dat');
    {$I-} {desactiva la verificación de errores de entrada/salida (en tiempo de ejecución)}
    reset(arch); {al no estar activada la detección de errores, se puede intentar abrir archivos inexistentes y no se recibirán mensajes de error}
    {$I+} {activa la verificación de errores entrada/salida}
    if ioresult <> 0 then {ioresult devuelve un 0 si la última operación de entrada/salida se realizó con éxito y <> 0 si hubo algún error}
        error:= true;
end;

procedure AbrirArcHistorias(var arch: TArchivoHistorias; var error: boolean);
begin
    error:= false;
    Assign(arch, '/work/MTorres_Instapas_Historias.dat');
    {$I-} {desactiva la verificación de errores de entrada/salida (en tiempo de ejecución)}
    reset(arch); {al no estar activada la detección de errores, se puede intentar abrir archivos inexistentes y no se recibirán mensajes de error}
    {$I+} {activa la verificación de errores entrada/salida}
    if ioresult <> 0 then {ioresult devuelve un 0 si la última operación de entrada/salida se realizó con éxito y <> 0 si hubo algún error}
        error:= true;
end;

procedure AbrirArcSeguidos(var arch: TArchivoSeguidos; var error: boolean);
begin
    error:= false;
    Assign(arch, '/work/MTorres_Instapas_Historias.dat');
    {$I-} {desactiva la verificación de errores de entrada/salida (en tiempo de ejecución)}
    reset(arch); {al no estar activada la detección de errores, se puede intentar abrir archivos inexistentes y no se recibirán mensajes de error}
    {$I+} {activa la verificación de errores entrada/salida}
    if ioresult <> 0 then {ioresult devuelve un 0 si la última operación de entrada/salida se realizó con éxito y <> 0 si hubo algún error}
        error:= true;
end;

// Abre los 3 archivos juntos //
procedure AbrirArchivos(var archUsu: TArchivoUsuarios; var archHis: TArchivoHistorias; var archSeg: TArchivoSeguidos);
var errorUsu, errorHis, errorSeg: boolean;
begin
    AbrirArcUsuarios(archUsu, errorUsu);
    AbrirArcHistorias(archHis, errorHis);
    AbrirArcSeguidos(archSeg, errorSeg);

    // Si no existen los crea //
    if errorUsu then
        rewrite(archUsu);
    if errorHis then
        rewrite(archHis);
    if errorSeg then
        rewrite(archSeg);
end;

// Pasar el usuario desde el archivo al lugar correcto en el arbol, en orden ascendiente //
// Tambien sirve para crear un usuario nuevo sin que este en el archivo //
procedure PasarUsuario(var pos: TPuntArbol; usuario: Usuarios);
begin
    if pos = NIL then begin
        new(pos);
        pos^.nombre:= usuario.nombre;
        pos^.password:= usuario.password;
        pos^.email:= usuario.email;
        pos^.seguidos:= NIL;
        pos^.historias:= NIL;
        pos^.menores:= NIL;
        pos^.mayores:= NIL;
    end
    else if pos^.nombre < usuario.nombre then
        PasarUsuario(pos^.mayores, usuario)
    else
        PasarUsuario(pos^.menores, usuario);
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
    cursor: TPuntArbol;
    usuario: Usuarios;
    historia: Historias;
    seguido: Seguidos;
begin
    cursor:= arbol;
    // Si no hay usuarios en el archivo, no añade nodo al arbol y lo señala como nil, despues termina el procedimiento //
    if FileSize(archUsu) = 0 then begin
        cursor:= NIL;
        exit;
    end;

    // Agrega los nombres, passwords y emails de todos los usuarios en el archivo //
    Seek(archUsu, 0);
    while not (eof(archUsu)) do begin
        Read(archUsu, usuario);
        PasarUsuario(cursor, usuario);

        // Pasa las historias pertenecientes al usuario desde el archivo //
        Seek(archHis, 0);
        while not (eof(archHis)) do begin
            Read(archHis, historia);
            if (historia.nombre) = (usuario.nombre) then
                PasarHistorias(cursor^.historias, historia);
        end;

        // Pasa los seguidos pertenecientes al usuario desde el archivo //
        Seek(archSeg, 0);
        while not (eof(archSeg)) do begin
            Read(archSeg, seguido);
            if (seguido.seguidor) = (usuario.nombre) then
                PasarSeguidos(cursor^.seguidos, seguido);
        end;

    end;

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
    cursor: TPuntArbol;
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
    PasarUsuario(cursor, usuario);
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

function PromedioSeguidos(arbol, cursor: TPuntArbol; cantidad: integer): real;
var n: real;
begin
    cursor:= arbol;
    n:= 0;
    PromedioSeguidos:= n;
end;

// Pantalla que se muestra al empezar el programa //
procedure MenuUno(var arbol: TPuntArbol; var usuario: Usuarios; var iniciado: boolean);
var 
    cursor: TPuntArbol;
    terminado: boolean;
    valor: integer;
begin
    terminado:= false;
    while not terminado do begin
        cursor:= arbol;
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        writeln('- Cantidad total de usuarios: ', CantidadDeUsuarios(cursor));
        writeln('- Promedio de usuarios seguidos por usuario: ', PromedioSeguidos(arbol, cursor, CantidadDeUsuarios(cursor)):0:1);
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
            3: ;
            4: Salir(iniciado);
        end;
        if iniciado then 
            terminado:= true;
    end;
end;

// Pantalla que se muestra al iniciar sesion o registrarse //
procedure MenuDos(var arbol: TPuntArbol; var usuario:  Usuarios; var iniciado: boolean);
var
    cursor: TPuntArbol;
    valor: integer;
    terminado: boolean;
begin
    terminado:= false;
    while not terminado do begin
        cursor:= arbol;
        ClrScr;
        writeln('');
        EscribirCentrado('InstaPas');
        writeln('');
        cursor:= EncontrarUsuario(usuario.nombre, cursor); // TEST
        writeln('Nombre: ', cursor^.nombre); // TEST
        writeln('- Cantidad total de usuarios: ', CantidadDeUsuarios(cursor)); // TEST
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
            1: ;
            2: ;
            3: ;
            4: ;
            5: ;
            6: ;
            7: ;
        end;
    end;
    iniciado:= false;
end;

// Se ejecuta junto antes de terminar el programa //
procedure TerminarPrograma(var archUsu: TArchivoUsuarios; var archHis: TArchivoHistorias; var archSeg: TArchivoSeguidos; var arbol, cursor, usuario: TPuntArbol);
begin
    
end;

var
    ArcUsuarios: TArchivoUsuarios;
    ArcHistorias: TArchivoHistorias;
    ArcSeguidos: TArchivoSeguidos;
    ArbolUsuarios: TPuntArbol; // Usuario solo apunta al usuario actual, NO MOVER // // Mover solo Cursor, mantener los otros como estan //
    iniciado, terminado: boolean; // Indica si la sesion fue iniciada con exito //
    Usuario: Usuarios;

begin
    iniciado:= false;
    terminado:= false;
    AbrirArchivos(ArcUsuarios, ArcHistorias, ArcSeguidos);
    CrearArbolUsuarios(ArcUsuarios, ArcHistorias, ArcSeguidos, ArbolUsuarios);
    while not terminado do begin
        MenuUno(ArbolUsuarios, Usuario, iniciado);
        if iniciado then begin
            MenuDos(ArbolUsuarios, Usuario, iniciado);
        end;
    end;
    
    
    
end.