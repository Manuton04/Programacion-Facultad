program IntercambioInt;

{Programa para el punto 1 del practico de VARIABLES.}

procedure PasarInt(var Int1, Int2: integer);
    var AUX: integer;
begin

    AUX:= Int2;
    Int2:= Int1;
    Int1:= AUX;

end;

var A, B: integer;

begin

writeln('Introduce valor entero A: ');
Readln(A);
writeln('Introduce valor entero B: ');
Readln(B);
PasarInt(A, B);

writeln('Valores intercambiados: ');
writeln('A: ', A);
writeln('B: ', B);

end.