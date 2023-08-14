program Filas1;

{Programa para el punto 1 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
ORIGEN: fila;
DESTINO: pila;

begin
ReadFila(ORIGEN);
InicPila(DESTINO, '');

while not FilaVacia(ORIGEN) do
    apilar(DESTINO, Extraer(ORIGEN));

writeFila(ORIGEN);
writePila(DESTINO);
end.