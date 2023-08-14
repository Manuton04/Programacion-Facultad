program Filas11;

{Programa para el punto 11 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
PILA1, PILA2, DESCARTE: pila;

begin

ReadPila(PILA1);
ReadPila(PILA2);
InicPila(DESCARTE, '');

while not PilaVacia(PILA1) and not PilaVacia(PILA2)do
  begin
    apilar()
  end;

writeFila(DADA);
end.