program Filas3;

{Programa para el punto 3 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
DATOS: fila;
AUX: pila;

begin
ReadFila(DATOS);
InicPila(AUX, '');

if not FilaVacia(DATOS) then
    apilar(AUX, Extraer(DATOS));

if not PilaVacia(AUX) then
    Agregar(DATOS, Desapilar(AUX));

writeFila(DATOS);
end.