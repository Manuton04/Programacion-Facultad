program Filas2;

{Programa para el punto 2 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
DADA: fila;
AUX: pila;

begin
ReadFila(DADA);
InicPila(AUX, '');

while not FilaVacia(DADA) do
    apilar(AUX, Extraer(DADA));

while not PilaVacia(AUX) do
    Agregar(DADA, Desapilar(AUX));

writeFila(DADA);
end.