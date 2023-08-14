program Filas5;

{Programa para el punto 5 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
ORIGEN, DESTINO: fila;

begin
InicFila(ORIGEN, '3 4 5 7 0 6 8');
InicFila(DESTINO, '');

while not FilaVacia(ORIGEN) and (Primero(ORIGEN)<> 0) do
    Agregar(DESTINO, Extraer(ORIGEN));

writeFila(DESTINO);
end.