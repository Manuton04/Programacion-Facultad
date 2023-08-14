program Cheques;

{Programa para el punto 4 del practico de VARIABLES.}
{$INCLUDE/IntroProg/Estructu}

procedure Contar(FilaContada: fila; var cantidad: integer);
var AUX: fila;
begin
    while not FilaVacia(FilaContada)do
        begin
            Agregar(AUX, Extraer(FilaContada));
            cantidad:= cantidad + 1;
        end;
end;

procedure Suma(FilaSumar: fila; var Total: real);
var AUX: fila;
begin
    while not FilaVacia(FilaSumar)do 
        begin
            Total:= Total + Primero(FilaSumar);
            Agregar(AUX, Extraer(FilaSumar));
        end;
end;

var
    Socios, importes: fila;
    Total, Pago: real;
    Cantidad: integer;

begin
    writeln('Escribe los números de carnet de los socios: ');
    ReadFila(Socios);
    writeln('Escriba los importes de los cheques: ');
    ReadFila(importes);
    Contar(Socios, Cantidad);
    Suma(importes, Total);
    Pago:= Total/Cantidad;
    writeln('La cantidad que se le pagara a cada socio es: ', Pago);
end.