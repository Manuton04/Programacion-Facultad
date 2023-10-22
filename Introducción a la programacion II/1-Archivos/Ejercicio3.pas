Program Ejercicio3;

const
    Max= 100;

type
    TArchivoChar= File of Char;
    TArregloChar= array[1..Max] of Char;

procedure AbrirArc(var arch: TArchivoChar; var error: boolean; nombre: String);
begin
    error:= false;
    Assign(arch, '/work/MTorres_'+nombre+'.dat');
    {$I-} {desactiva la verificación de errores de entrada/salida (en tiempo de ejecución)}
    reset(arch); {al no estar activada la detección de errores, se puede intentar abrir archivos inexistentes y no se recibirán mensajes de error}
    {$I+} {activa la verificación de errores entrada/salida}
    if ioresult <> 0 then {ioresult devuelve un 0 si la última operación de entrada/salida se realizó con éxito y <> 0 si hubo algún error}
        error:= true;
end;

procedure Intercambiar(var a, b: char);
var
    temp: char;
begin
    temp:= a;
    a:= b;
    b:= temp;
end;

var 
    Arch: TArchivoChar;
    Arreglo: TArregloChar;
    Error, Sigue: Boolean;
    Nombre: String;
<<<<<<< HEAD
    carac: Char;
    i: Integer;
=======
    carac, SigueC: Char;
>>>>>>> 286631bde4b7f06be9ac54c506f1b5e8aa05a9ff

begin
    Sigue:= true;
    write('Escribe el nombre del archivo(Solo, sin puntos, Ej:Caract): ');
    ReadLn(Nombre);
    AbrirArc(Arch, Error, Nombre);
    if Error then begin
<<<<<<< HEAD
        rewrite(Arch);
=======
        while sigue do begin
            write('Introduce un Caracter Vocal: ');
            readln(carac);
            carac:= UpCase(carac);
            if (carac = 'A') or (carac = 'E') or (carac = 'I') or (carac = 'O') or (carac = 'U') then begin
                write(Arch, carac)
            end else begin
                writeln('El caracter entregado no es vocal, intente de nuevo.');
            end;
            write('Desea seguir ingresando caracteres? S/N: ');
            readln(SigueC);
            SigueC:= UpCase(SigueC);
            if SigueC= 'N' then
                Sigue:= false;

        end;
        close(Arch);
        writeln('Caracteres vocales guardados en "', Nombre,'.dat".')
    end else begin
        // Crea ARREGLO CON VOCALES DEL ARCHIVO
        
        // Ordena el arreglo de vocales
        for i:= 1 to n - 1 do
            for j:= 1 to n - i do
                if Arreglo[j] > Arreglo[j + 1] then
                    Intercambiar(Arreglo[j], Arreglo[j + 1]);

        // MUESTRA EN PANTALLA
>>>>>>> 286631bde4b7f06be9ac54c506f1b5e8aa05a9ff
    end;
end.