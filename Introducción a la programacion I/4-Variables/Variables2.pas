program SumaNaturales;

{Programa para el punto 2 del practico de VARIABLES.}

procedure Suma(n: integer; var sum: integer);

var num: integer;
begin

    num:= 0;
    while n > 0 do
        begin
            num:= num + 1;
            sum:= sum + num;
            n:= n - 1;
        end;

end;

var n, sum: integer;

begin
    
    sum:= 0;
    writeln('Ingresa la cantidad de numeros naturales a sumar: ');
    Readln(n);
    Suma(n, sum);

    writeln('Resultado: ', sum);
end.