Program Arreglos2a;

Const
    Min= 1;
    Max= 100;
    Disc= -1;

Type
    TArregloReal= array[Min..Max] of Real;

procedure ValDisc(var Arreglo: TArregloReal);
var n: integer;
begin
    For n:= Min to Max do Arreglo[n]:= Disc;
end;

procedure LlenarArray(var Arreglo:TArregloReal);
var n: integer;
begin
    For n:= Min to Max do begin
        writeln('Escribe el elemento ', n, ':');
        read(Arreglo[n]);
        if not (Arreglo[n] <> -1)then
            break;
    end;
end;

function SumaArray(Arreglo: TArregloReal):real;
var
    n: integer;
    sum: real;
begin
    sum:= 0;
    For n:= Min to Max do begin
        if Arreglo[n] <> Disc then
            sum:= sum + Arreglo[n];
    end;
    SumaArray:= sum;
end;

procedure Escribir(Sumatoria: real);
begin
    Writeln('La suma de todos los numeros proporcionados es: ', Sumatoria:0:2);
end;

var
    Arreglo: TArregloReal;

begin
    ValDisc(Arreglo);
    LlenarArray(Arreglo);
    Escribir(SumaArray(Arreglo));
end.