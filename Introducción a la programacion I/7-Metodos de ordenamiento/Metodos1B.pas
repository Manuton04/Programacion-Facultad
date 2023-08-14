Program Metodos1b; 

{Ordenar por Burbuja}

Const
    Min= 1;
    Max= 10;

type
    TArregloInt= array[Min..Max] of integer;

procedure LlenarArray(var Arreglo:TArregloInt);
var n: integer;
begin
    For n:= Min to Max do begin
        write('Escribe el elemento ', n, ': ');
        readln(Arreglo[n]);
    end;
end;

{Intercambia dos elementos}
procedure Intercambiar(var Arreglo: TArregloInt; pos, pos2:integer);
var aux: integer;
begin
    aux:= Arreglo[pos];
    Arreglo[pos]:= Arreglo[pos2];
    Arreglo[pos2]:= aux;
end;

procedure Burbuja(var Arreglo: TArregloInt);
var a, j: integer;
begin
    For a := Min to Max - 1 do begin
        For j := Min to Max-a do if Arreglo[j] > Arreglo[j + 1] then
            Intercambiar(Arreglo, j, j + 1);  
    end;
end;


var    
    Arreglo: TArregloInt;
    i: integer;

begin
    LlenarArray(Arreglo);
    Burbuja(Arreglo);
    for i:= Min to Max do
        Writeln('El valor del arreglo en la posicion ', i, ' es: ', Arreglo[i]);
end.