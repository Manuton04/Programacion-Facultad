Program FinalPrueba;

const
    dias= [1..31];
    meses= [1..12];
    anios= [1990..2023];

type
    fecha= record
        dia: dias;
        mes: meses;
        anio: anios;
    end;
    TPuntLista= ^TNodoLista;
    TpuntArbol= ^TNodoArbol;
    TNodoLista= record
        nombre: String;
        produccion: TpuntArbol;
        sig: TPuntLista;
        sigCant: TPuntLista;
    end;
    TNodoArbol= record
        fecha: fecha;
        unidades: Integer;
        menores, mayores: TpuntArbol;
    end;

function ordenFechas(fecha1, fecha2: fecha): integer;
begin
    
end;

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
    else if (ordenFechas(arbol^.fecha, fechaMax) = 1) then
        sumarArbol:= sumarArbol(arbol^.menores, fechaMin, fechaMax)
    else if (ordenFechas(arbol^.fecha, fechaMin) = 0) OR ((ordenFechas(arbol^.fecha, fechaMin) = 2) AND (igualFecha)) then
        sumarArbol:= arbol^.dato + sumarArbol(arbol^.mayores, fechaMin, fechaMax)
    else
        sumarArbol:= sumarArbol(arbol^.mayores, fechaMin, fechaMax);
end;

procedure actualizarPorCant(var lista, primerPuntCant: TPuntLista;  fechaMax, fechaMin: fecha);
var
    actual, menorCant, aux: TPuntLista;
    CantProd: Integer;
begin
    
end;




var
    TiposQueso: TPuntLista;

begin  
    
end;