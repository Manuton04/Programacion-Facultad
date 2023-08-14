Program Car50;

Const
    Min= 1;
    Max= 50;
    Disc= '*';

Type
    TArregloCar= array[Min..Max] of char;


procedure LlenarVacios(var Arreglo: TArregloCar; Fin: integer);
var indice: integer;
begin
    For indice:= Fin to Max do Arreglo[indice]:= Disc;
end;

procedure CargarArr(var Arreglo: TArregloCar);
var indice: integer;
begin
     For indice:= Min to Max do begin
        write('Ingrese el valor del arreglo(* para terminar de ingresar datos ): ');
        readln(Arreglo[indice]);
        if Arreglo[indice] = Disc then begin
            LlenarVacios(Arreglo, indice);
            break;
        end;
    end;


end;

procedure MostrarArr(Arreglo: TArregloCar);
var indice: integer;
begin
    For indice:= Min to Max do
        if Arreglo[indice] <> Disc then
            writeln('El valor del arreglo en la posición ', indice, 'es: ', Arreglo[indice]);
end;

var
    Arreglo1: TArregloCar;
begin
    CargarArr(Arreglo1);
    writeln('El arreglo terminado es: ');
    MostrarArr(Arreglo1);

end.