Program Punteros1;

Type
    PuntNodo= ^NodoLista;
    NodoLista= record
        Car: char;
        sig: PuntNodo;
    end;
    
var
    Lista, Cursor: PuntNodo;
    carac: char;
begin
    Lista:= nil; 
    write('Ingrese un caracter(* para finalizar): ');
    readln(carac);
    if carac <> '*' then begin
        new(Lista);
        Lista^.Car:= carac;
        Lista^.Sig:= nil;
        Cursor:= Lista;
        write('Ingrese un caracter(* para finalizar): ');
        readln(carac);
        while carac <> '*' do begin
            new(Cursor^.sig);
            Cursor:= Cursor^.sig;
            Cursor^.Car:= carac;
            Cursor^.sig:= nil;
            write('Ingrese un caracter(* para finalizar): ');
            readln(carac);
        end;
    end;
end.