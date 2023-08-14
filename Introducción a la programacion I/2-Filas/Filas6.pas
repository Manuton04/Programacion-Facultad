program Filas6;

{Programa para el punto 6 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
A, B, AUX: fila;
RESULTADO, VERDADERO, FALSO: pila;

begin
InicFila(A, '1 2 3 4 5');
InicFila(B, '1 2 3 4 5 6 7');
InicFila(AUX, '');
InicPila(RESULTADO, '13');
InicPila(VERDADERO, '');
InicPila(FALSO, '');

while not FilaVacia(A) and not FilaVacia(B) do
    begin
        Agregar(AUX, Extraer(A));
        Agregar(AUX, Extraer(B));
    end;

if (FilaVacia(A) and FilaVacia(B)) then
    apilar(VERDADERO, Desapilar(RESULTADO))
else
    Apilar(FALSO, Desapilar(RESULTADO));

Write('Verdadero: ');
writePila(VERDADERO);
Write('Falso: ');
writePila(FALSO);
end.