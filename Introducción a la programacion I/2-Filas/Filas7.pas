program Filas7;

{Programa para el punto 7 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
A, B, AUX: fila;
RESULTADO, IGUALES, DISTINTAS: pila;

begin
InicFila(A, '1 2 3 4 5');
InicFila(B, '1 2 3 4 5');
InicFila(AUX, '');
InicPila(RESULTADO, '27');
InicPila(IGUALES, '');
InicPila(DISTINTAS, '');

while (not FilaVacia(A) and not FilaVacia(B)) and (Primero(A) = Primero(B)) do
    begin
        Agregar(AUX, Extraer(A));
        Agregar(AUX, Extraer(B));
    end;

if (FilaVacia(A) and FilaVacia(B)) then
    apilar(IGUALES, Desapilar(RESULTADO))
else
    Apilar(DISTINTAS, Desapilar(RESULTADO));

Write('Iguales: ');
writePila(IGUALES);
Write('Distintas: ');
writePila(DISTINTAS);
end.