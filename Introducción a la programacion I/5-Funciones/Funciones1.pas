Program ParImpar;

function EsPar(num: integer):boolean;
var aux: integer;
begin
    aux:= num MOD 2;
    if (aux = 0)then
        EsPar:= true
    else
        EsPar:= false;
end;

var num: integer;
begin
    Writeln('Ingrese un número entero: ');
    Read(num);
    if EsPar(num) then
        Writeln('El número ', num, ' es par.')
    else
        Writeln('El número ', num, ' es impar.')
end.
