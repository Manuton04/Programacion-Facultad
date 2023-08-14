Program InviertirPalabras;

Const
    Min= 1;
    MaxTexto= 50;

Type 
    TArregloCar = array [Min..Max] of char;

function SeInvierte(posinicial, posfinal, cantlet: integer):boolean;
var i, n: integer;
begin
    n:= 0;
    for i:= posinicial to posfinal do
        n:= n + 1;
    if n > cantlet then
        SeInvierte:= False;
    else
        SeInvierte:= true;

procedure Inviertir(var arr: TArregloCar; posinicial);
begin
    
end; 