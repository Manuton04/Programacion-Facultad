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

var 
    Arch: TArchivoChar;
    Arreglo: TArregloChar;
    Error: Boolean;
    Nombre: String;
    carac: Char;
    i: Integer;

begin
    write('Escribe el nombre del archivo(Solo, sin puntos, Ej:Caract): ');
    ReadLn(Nombre);
    AbrirArc(Arch, Error, Nombre);
    if Error then begin
        rewrite(Arch);
    end;
end.