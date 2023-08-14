program ModuPara1;

{Programa para el punto 1 A del trabajo practico de Modularización y Parametros.}
{$INCLUDE /IntroProg/Estructu}

//////////////////////////////////// Procedimientos

procedure PasarPila(var Inicial: pila; var Final: pila);
begin
    apilar(Final, desapilar(Inicial));    
end;

procedure EliminarTope(var Origen: pila; MODELO: pila);

    var
      DESCARTE: pila;

begin
        if Tope(Origen) = Tope(MODELO)then
            PasarPila(Origen, DESCARTE);
end;

////////////////////////////////////

var
DADA, AUX, MODELO: pila;

begin
writeln('Ingresa numeros: ');
ReadPila(DADA);
InicPila(MODELO, '3');
InicPila(AUX, '');
while not PilaVacia(DADA)do
  begin
    PasarPila(DADA, AUX);
    EliminarTope(AUX, MODELO);
  end;
while not PilaVacia(AUX)do
    PasarPila(AUX, DADA);

writePila(DADA);
end.