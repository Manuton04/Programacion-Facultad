program Filas9;

{Programa para el punto 9 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
DADA, MODELO, AUX1, AUX2: fila;

begin
ReadFila(DADA);
InicFila(MODELO, '3');
InicFila(AUX1, '');
InicFila(AUX2, '');

while not FilaVacia(DADA) do
    if (Primero(DADA) = Primero(MODELO)) then
        Agregar(AUX2, Extraer(DADA))
    Else
    Agregar(AUX1, Extraer(DADA));

while not FilaVacia(AUX1) do
    Agregar(AUX2, Extraer(AUX1));

while not FilaVacia(AUX2) do
    Agregar(DADA, Extraer(AUX2));

writeFila(DADA);
end.