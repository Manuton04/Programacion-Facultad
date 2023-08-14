program Filas4;

{Programa para el punto 4 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
DATOS: fila;
AUX1, AUX2: pila;

//En AUX1 se guarda los números al inverso, se le retira el tope y lo envia a la pila AUX2, guardando el que era originalmente el ultimo número de la fila DATOS.

begin
ReadFila(DATOS);
InicPila(AUX1, '');
InicPila(AUX2, '');

while not FilaVacia(DATOS) do
    apilar(AUX1, Extraer(DATOS));

if not PilaVacia(AUX1) then
    apilar(AUX2, Desapilar(AUX1));

if not PilaVacia(AUX2) then
    Agregar(DATOS, Desapilar(AUX2));

while not PilaVacia(AUX1) do
    apilar(AUX2, Desapilar(AUX1));

while not PilaVacia(AUX2) do
    Agregar(DATOS, Desapilar(AUX2));

writeFila(DATOS);
end.