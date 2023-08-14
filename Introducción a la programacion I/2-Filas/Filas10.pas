program Filas10;

{Programa para el punto 10 del trabajo practico de FILAS.}
{$INCLUDE /IntroProg/Estructu}

var
DADA, AUX1, AUX2: fila;

begin
InicFila(DADA, '5 9 0 12 12 4 7'); //En este programa se debe proporcionar obligatoriamente un número 12 dentro de los elementos dados.
InicFila(AUX1, '');
InicFila(AUX2, '');

if (not FilaVacia(DADA)) and (not Primero(DADA) = 12) then
    Agregar(AUX2, Extraer(DADA));

while not FilaVacia(DADA) do
    if Primero(DADA) = 12 then
      begin
        Agregar(AUX1, Extraer(DADA));
        if not FilaVacia(AUX2) then
            Agregar(AUX1, Extraer(AUX2))
      end
    else
        Agregar(AUX1, Extraer(DADA));

while not FilaVacia(AUX1)do
    Agregar(DADA, Extraer(AUX1));


writeFila(DADA);
end.