Program Punteros3;

Type
    TPuntNodo= ^TNodoLista;
    TNodoLista= record
        num: integer;
        sig: TPuntNodo;
    end;

procedure IngresarNumeros(var lista, cursor: TPuntNodo);
var valor: integer;
begin
    Lista:= nil; 
    write('Ingrese un entero(-1 para finalizar): ');
    readln(valor);
    if valor <> -1 then begin
        new(Lista);
        Lista^.num:= valor;
        Lista^.sig:= nil;
        Cursor:= Lista;
        write('Ingrese un entero(-1 para finalizar): ');
        readln(valor);
        while valor <> -1 do begin
            new(Cursor^.sig);
            Cursor:= Cursor^.sig;
            Cursor^.num:= valor;
            Cursor^.sig:= nil;
            write('Ingrese un entero(-1 para finalizar): ');
            readln(valor);
        end;
    end;
end;

procedure ImprimirListaOrd(L: TPuntNodo);
begin
    if (L <> nil) then begin
        writeLn(L^.num);
        ImprimirListaOrd(L^.sig);
    end;
end;

procedure InsertarEntero(var lista: TPuntNodo);
var
    valor: integer;
    nodo, actual, anterior: TPuntNodo;
begin
    write('Ingrese un entero para ingresar a la lista: ');
    readln(valor);
    New(nodo);
    nodo^.num:= valor;
    nodo^.sig= NIL;

    if (lista = NIL) or (valor < lista^.num) then 
        lista:= nodo //Cuando la lista esta vacia
    else
    begin
        actual:= lista;
        anterior:= NIL;

        while (actual <> NIL) and (actual^.num <= valor) do begin
            anterior:= actual;
            actual:= actual^.sig;
        end;

        nodo^.sig:= actual;
        anterior^.sig:= nodo;
    end;
end;

var
    Lista, Cursor: TPuntNodo;

begin
    writeln('Ingrese valores enteros ordenados de menor a mayor.');
    IngresarNumeros(Lista, Cursor);
    ImprimirListaOrd(Lista);
    writeln('');
    InsertarEntero(Lista);
end.