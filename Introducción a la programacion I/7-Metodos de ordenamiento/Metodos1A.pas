Program Metodos1a; 

{Ordenar por Selección}

Const
    Min= 1;
    Max= 10;

type
    TArregloInt= array[Min..Max] of integer;

procedure LlenarArray(var Arreglo:TArregloInt);
var n: integer;
begin
    For n:= Min to Max do begin
        write('Escribe el elemento ', n, ':');
        readln(Arreglo[n]);
    end;
end;

{Devuelve la posición del mínino ente los arr[i].. arr[max] }
function PosMenor(Arreglo: TArregloInt; pos: integer ):integer;
var j, p: integer;
begin
    p:=pos;
    for j:= pos+1 to max do if Arreglo[j]< Arreglo[p] then p:=j;
    PosMenor:=p;
end;

{Intercambia dos elementos}
procedure Intercambiar(var Arreglo: TArregloInt; pos, posmenor:integer);
var dato: integer;
begin
    dato:= Arreglo[pos];
    Arreglo[pos]:= Arreglo[posmenor];
    Arreglo[posmenor]:= dato;
end;

{Va seleccionando en cada pasada el menor y lo lleva adelante}
procedure OrdenarPorSeleccion(var Arreglo: TArregloInt);
var pos: integer;
begin
    For pos:= Min to Max-1 do
        Intercambiar(Arreglo, pos, PosMenor(Arreglo, pos))
end;

procedure Escribrir(Arreglo: TArregloInt);
var i: integer;
begin
    for i:= Min to Max do
        Writeln('El valor del arreglo en la posicion ', i, ' es: ', Arreglo[i]);
end;

var Arreglo: TArregloInt;

begin
    LlenarArray(Arreglo);
    OrdenarPorSeleccion(Arreglo);
    Escribrir(Arreglo);
end.