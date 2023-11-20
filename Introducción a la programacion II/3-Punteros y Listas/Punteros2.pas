Program Punteros2;

Const
    Min= 1;
    Max= 100;
    Disc= -1;

Type
    TPuntNodo= ^TNodoLista;
    TNodoLista= record
        num: Integer;
        sig: TPuntNodo;
    end;
    TArregloEnteros = Array[Min..Max] of Integer;

procedure LlenarVacios(var arreglo: TArregloEnteros; fin: integer);
var i: integer;
begin
    For i:= fin to Max do arreglo[i]:= Disc;
end;

procedure IngresarNumerosArr(var arreglo: TArregloEnteros; var longitud: Integer);
var i: integer;
begin
    For i:= Min to Max do begin
        write('Ingrese un valor entero(-1 para finalizar): ');
        readln(arreglo[i]);
        if arreglo[i] = Disc then begin
            LlenarVacios(arreglo, i);
            longitud:= i-1;
            break;
        end;
    end;
end;

procedure PasarArregloLista(arreglo: TArregloEnteros; var Lista, Cursor: TPuntNodo; longitud: integer);
var i: integer;
begin
    new(Lista);
    Lista^.num:= arreglo[Min];
    Lista^.sig:= nil;
    Cursor:= Lista;
    for i:= Min+1 to longitud do begin
        new(Cursor^.sig);
        Cursor:= Cursor^.sig;
        Cursor^.num:= arreglo[i];
        Cursor^.sig:= nil;
    end;
end;

function Sumar(L: TPuntNodo): Integer;
var sum: Integer;
begin
    sum:= 0;
    if (L <> nil) then begin
        sum:= sum + L^.num;
        sum := sum + Sumar(L^.sig);
    end;
    Sumar:= sum;
end;

procedure ImprimirListaOrd(L: TPuntNodo);
begin
    if (L <> nil) then begin
        writeLn(L^.num);
        ImprimirListaOrd(L^.sig);
    end;
end;

function MaximoLista(L: TPuntNodo; primer: integer): integer;
var n: integer;
begin
    n:= primer;
    if (L <> nil) then begin
        if (n < L^.num) then
            n:= L^.num;
        n:= MaximoLista(L^.sig, n);
    end;
    MaximoLista:= n;
end;

function Promediar(total, cantidad: integer): real;
begin
    Promediar:= total / cantidad;
end;

var
    suma, maximo, longitud, valor: integer;
    promedio: real;
    Lista, Cursor: TPuntNodo;
    arregloInt: TArregloEnteros;

begin
    Lista:=nil; 
    IngresarNumerosArr(arregloInt, longitud);
    PasarArregloLista(arregloInt, Lista, Cursor, longitud);
    suma:= Sumar(Lista);
    promedio:= Promediar(suma, longitud);
    maximo:= MaximoLista(Lista, Lista^.num);
    writeln('');
    writeln('Lista de enteros: ');
    ImprimirListaOrd(Lista);
    writeln('');
    writeln('- Suma: ', suma);
    writeln('- Cantidad de elementos: ', longitud);
    writeln('- Promedio: ', promedio:0:2);
    writeln('- Elemento maximo: ', maximo);


end.