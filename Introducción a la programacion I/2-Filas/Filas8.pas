program Filas8;

{Programa para el punto 8 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
DADA: fila;
ELEMENTO, AUX1, AUX2: pila;

begin
InicFila(DADA, '1 4 8 12 17 28');
InicPila(AUX1, '');
InicPila(AUX2, '');
InicPila(ELEMENTO, '9 3 15');

while not FilaVacia(DADA) do
    begin
        Apilar(AUX1, Extraer(DADA));
        if (Tope(AUX1) <= Tope(ELEMENTO)) and (Tope(ELEMENTO) <= Primero(DADA)) then
          Apilar(AUX1, Desapilar(ELEMENTO));
    end;

while not PilaVacia(AUX1) do
    Apilar(AUX2, Desapilar(AUX1));

while not PilaVacia(AUX2) do
    Agregar(DADA, Desapilar(AUX2));

writeFila(DADA);
end.