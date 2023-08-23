Program Ejercicio1;

type
    ArchivoEnteros= File of Integer;

procedure AbrirArc(var arch: ArchivoEnteros; var error: boolean);
begin
    error:= false;
    Assign(arch, '/work/MTorres_Enteros.dat');
    {$I-} {desactiva la verificación de errores de entrada/salida (en tiempo de ejecución)}
    reset(arch); {al no estar activada la detección de errores, se puede intentar abrir archivos inexistentes y no se recibirán mensajes de error}
    {$I+} {activa la verificación de errores entrada/salida}
    if ioresult <> 0 then {ioresult devuelve un 0 si la última operación de entrada/salida se realizó con éxito y <> 0 si hubo algún error}
        error:= true;
end;

var
    Arc_Enteros: ArchivoEnteros;
    Num, i: Integer;
    Error: boolean;

begin
    AbrirArc(Arc_Enteros, Error);
        if not Error then begin
            for i:= 1 to 3 do begin
                Write('Agregue el valor número '+ i+ ': ');
                ReadLn(Num);
                write(Arc_Enteros, Num);
            end;
            while (not eof(Arc_Enteros)) do begin
                read(Arc_Enteros, Num);
                writeln('El valor número '+ (Filepos(Arc_Enteros)+1)+ ' es: '+ Num);
            end;
            close(Arc_Enteros);
        end;

    

end.