Program Ejercicio1;

type
    TArchivoEnteros= File of Integer;

procedure AbrirArc(var arch: TArchivoEnteros; var error: boolean);
begin
    error:= false;
    Assign(arch, '/work/MTorres_Enteros.dat');
    {$I-} {desactiva la verificación de errores de entrada/salida (en tiempo de ejecución)}
    reset(arch); {al no estar activada la detección de errores, se puede intentar abrir archivos inexistentes y no se recibirán mensajes de error}
    {$I+} {activa la verificación de errores entrada/salida}
    if ioresult <> 0 then {ioresult devuelve un 0 si la última operación de entrada/salida se realizó con éxito y <> 0 si hubo algún error}
        error:= true;
end;

procedure EscribirArc(var arch: TArchivoEnteros);
var n: Integer;
begin
    Seek(arch, 0);
    while (not eof(arch)) do begin
        Read(arch, n);
        writeln('El valor en la posición ', Filepos(arch), ' es: ', n);
    end;
end;

function Promediar(var arch: TArchivoEnteros): Real;
var sum, val, n: Integer;
begin
    sum:= 0;
    n:= 0;
    Seek(arch, 0);
    while not eof(arch) do begin
        read(arch, val);
        sum:= sum + val;
        n:= n + 1;
    end;
    Promediar:= sum / n;
end;

function Sumar(var arch: TArchivoEnteros): Integer;
var sum, val: Integer;
begin
    sum:= 0;
    Seek(arch, 0);
    while not eof(arch) do begin
        read(arch, val);
        sum:= sum + val;
    end;
    Sumar:= sum;
end;

var
    Arc_Enteros: TArchivoEnteros;
    Num, i: Integer;
    Error: boolean;

begin
    AbrirArc(Arc_Enteros, Error);
    if not Error then begin // EXISTE
            Seek(Arc_Enteros, FileSize(Arc_Enteros));
            Write('Agregue el valor del elemento ', (FileSize(Arc_Enteros)+1),': ');
            ReadLn(Num);
            write(Arc_Enteros, Num);
        EscribirArc(Arc_Enteros);
        WriteLn('');
        writeLn('El promedio de los valores es: ', Promediar(Arc_Enteros):0:2);
        writeLn('La suma de los valores es: ', Sumar(Arc_Enteros));
        close(Arc_Enteros);
    end
    else begin // NO EXISTE
        rewrite(Arc_Enteros);
        for i:= 1 to 3 do begin
            Write('Agregue el valor del elemento ', i, ': ');
            ReadLn(Num);
            write(Arc_Enteros, Num);
        end;
        EscribirArc(Arc_Enteros);
        close(Arc_Enteros);
    end;
end.