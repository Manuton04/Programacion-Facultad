Program Arboles1;

type
    TArchivoEnteros= File of integer;
    TPuntArbol= ^TNodoArbol;
    TNodoArbol= record
        num: integer;
        mayores, menores: TPuntArbol;
    end;

procedure AbrirArc(var arch: TArchivoEnteros; var error: boolean);
begin
    error:= false;
    Assign(arch, '/work/MTorres_AEnteros.dat');
    {$I-} {desactiva la verificación de errores de entrada/salida (en tiempo de ejecución)}
    reset(arch); {al no estar activada la detección de errores, se puede intentar abrir archivos inexistentes y no se recibirán mensajes de error}
    {$I+} {activa la verificación de errores entrada/salida}
    if ioresult <> 0 then {ioresult devuelve un 0 si la última operación de entrada/salida se realizó con éxito y <> 0 si hubo algún error}
        error:= true;
end;

procedure AgregarValorArbol(var pos: TPuntArbol; Valor: integer);
begin
    if pos = NIL then begin
        new(pos);
        pos^.num:= valor;
        pos^.menores:= NIL;
        pos^.mayores:= NIL;
    end
    else if pos^.num < valor then
        AgregarValorArbol(pos^.mayores, valor)
    else
        AgregarValorArbol(pos^.menores, valor);
end;

Procedure Mostrardatos(arbol: TPuntArbol);
Begin
If (arbol <> nil) then
    begin
        Mostrardatos(arbol^.menores);
        writeln (arbol^.num);
        Mostrardatos(arbol^.mayores);
    End; 
End;

procedure PasarValoresArchivo(var arch: TArchivoEnteros; var arbol: TPuntArbol);
var n: integer;
begin
    Seek(arch, 0);
    while not (eof(arch)) do begin
        Read(arch, n);
        AgregarValorArbol(arbol, n);
    end;
end;

var
    Arc_Enteros: TArchivoEnteros;
    Error: boolean;
    Arbol: TPuntArbol;
    n: integer;

begin

    AbrirArc(Arc_Enteros, Error);
    if Error then begin //NO EXISTE
        rewrite(Arc_Enteros);
        write(Arc_Enteros, 77);
        write(Arc_Enteros, 4);
        write(Arc_Enteros, 194);
        write(Arc_Enteros, 34);
        write(Arc_Enteros, 1);
        write(Arc_Enteros, 9);
        write(Arc_Enteros, 18);
        write(Arc_Enteros, 37);
        write(Arc_Enteros, 9);
        close(Arc_Enteros);
    end;

    PasarValoresArchivo(Arc_Enteros, Arbol);
    Mostrardatos(Arbol);

    //TEST
    writeln();
    Seek(Arc_Enteros, 0);
    while (not eof(Arc_Enteros)) do begin
            Read(Arc_Enteros, n);
            writeln('El valor en la posición ', Filepos(Arc_Enteros), ' es: ', n);
    end;
    

    close(Arc_Enteros);
end.