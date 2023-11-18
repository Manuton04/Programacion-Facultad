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
            LlenarVacios(arreglo, indice);
            longitud:= i-1;
            break;
        end;
end;

procedure PasarArregloLista(arreglo: TArregloEnteros; var Lista, Cursor: TPuntNodo; longitud: integer);
var i: integer;
begin
    new(Lista);
    Lista^.num:= arreglo[Min];
    Lista^.sig:= nil;
    Cursor:= Lista;
    for i:= Min to longitud do begin
        new(Cursor^.sig);
        Cursor:= Cursor^.sig;
        Cursor^.num:= arreglo[i];
        Cursor^.sig:= nil;
    end;
end;

fuction Sumar(Lista, Cursor): Integer;
sum, valor: Integer;
begin
    Cursor:= Lista;
    while (Cursor^.sig <> nil) do begin
        
    end;
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
    suma:= Sumar(Lista, Cursor);

end.