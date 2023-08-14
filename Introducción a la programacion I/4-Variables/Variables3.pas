program Posicion;

{Programa para el punto 3 del practico de VARIABLES.}
{$INCLUDE/IntroProg/Estructu}

procedure Cantidad(AnalizarFila: fila; Elemento: integer; var Pos: integer);
var 
    AUX: fila;
    TieneEle: Boolean;
begin
    InicFila(AUX, '');
    TieneEle:= false;

    while not FilaVacia(AnalizarFila)do
        begin
            if Primero(AnalizarFila) = Elemento then
                    TieneEle:= True;
            if TieneEle = false then
                Pos:= Pos + 1;
            Agregar(AUX, Extraer(AnalizarFila));
        end;
            
    if TieneEle = false then
        Pos:= -1;

end;

var
    Original: fila;
    Elemento, Pos: integer;

begin
    ReadFila(Original);
    writeln('Ingrese el elemento al cual buscar su posición en la fila anterior: ');
    read(Elemento);
    Pos:= 1;
    Cantidad(Original, Elemento, Pos);
    writeln('Posición del elemento en la fila: ', Pos);
end.