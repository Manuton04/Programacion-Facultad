function sumarArbol(arbol: TpuntArbol; fechaMin, fechaMax: integer): integer;
var
    igualFecha: boolean;
begin
    igualFecha:= false;
    if (ordenFechas(fechaMin, fechaMax)= 2) then
        igualFecha:= true;

    if arbol = NIL then
        sumarArbol:= 0
    else if (ordenFechas(arbol^.fecha, fechaMin) = 1) AND (ordenFechas(arbol^.fecha, fechaMax) = 0) then
        sumarArbol:= arbol^.dato + sumarArbol(arbol^.menores, fechaMin, fechaMax) + sumarArbol(arbol^.mayores, fechaMin, fechaMax)
    else if (ordenFechas(arbol^.fecha, fechaMin) = 0) OR ((ordenFechas(arbol^.fecha, fechaMin) = 2) AND (igualFecha)) then
        sumarArbol:= arbol^.dato + sumarArbol(arbol^.mayores, fechaMin, fechaMax)
    else
        sumarArbol:= sumarArbol(arbol^.menores, fechaMin, fechaMax);
end;