program damas;
uses Crt;

const
  FILAS = 8;
  COLUMNAS = 8;
  BLANCA = 'x';
  NEGRA = 'o';
  CANT_FICHAS = 12;
  C: array[1..9] of string = ('┐', '┌', '┘', '└', '─', '│', ' ', '┼', '░');

type
  matriz= array[1..FILAS, 1..COLUMNAS] of char;
  
var
  mat: matriz;

function FondoNegro(fila,col:integer):boolean;
// Retorna verdadero/falso dependiendo del fondo que tiene la celda (damero).
begin
    FondoNegro := (((fila+col) mod 2) = 1);
end;

function CantFichasEnTablero(mat:matriz; color:char):integer;
var cant, fila, columna:integer;
begin
    cant := 0;
    for fila := 1 to FILAS do
        for columna := 1 to COLUMNAS do
            if mat[fila,columna] = color then
                cant := cant + 1;
    CantFichasEnTablero := cant;
end;

procedure InicMatriz(var mat:matriz);
// Inicializa la matriz con las 64 celdas en blanco.
var
  i, j: integer;
begin
for i:=1 to FILAS do 
    for j:=1 to COLUMNAS do
        mat[i,j] := ' ';
end;

procedure CargarFichas(var mat:matriz; color:char; cantidad:integer);
// Carga la matriz con las 16 fichas en su posicion inicial.
var fila_inicial: integer;
    incremento:integer;
    fila, columna:integer;
    fichas: integer;
begin
    if color=NEGRA then begin
        fila_inicial := 1;
        incremento := 1;
        columna := 2;
    end else begin
        fila_inicial := FILAS;
        incremento := -1;
        columna := 1;
    end;
    fila := fila_inicial;
    for fichas:= 1 to CANT_FICHAS do begin
        if not(FondoNegro(fila, columna)) then
            columna := columna + 1;
        mat[fila, columna] := color;
        columna := columna + 2;
        if columna > COLUMNAS then begin
            columna := 1;
            fila := fila + incremento;
        end;
    end;
end;

procedure DibujarMatriz(mat:matriz);
// Muestra la matriz por pantalla.
var
  i, j: integer;
begin
    ClrScr;  // Blanquea la pantalla.
    write(' ',C[2]);
    for j:=1 to COLUMNAS do write(C[5],C[5],C[5]);
    writeln(C[1]);
    for i:=1 to FILAS do begin
        write(' ',C[6]);
        for j:=1 to COLUMNAS do begin
            if not(FondoNegro(i,j)) then
                write(C[9],C[9],C[9])
            else
                write(' ',mat[i,j],' ');
        end;
        writeln(C[6]);
    end;
    write(' ',C[4]);
    for j:=1 to COLUMNAS do write(C[5],C[5],C[5]);
    writeln(C[3]);
    for i := 1 to CANT_FICHAS - CantFichasEnTablero(mat,NEGRA) do write(NEGRA); writeln();
    for i := 1 to CANT_FICHAS - CantFichasEnTablero(mat,BLANCA) do write(BLANCA); writeln();
end;

procedure Inicializar(var mat: matriz);
begin
    InicMatriz(mat);
    CargarFichas(mat, BLANCA, CANT_FICHAS);
    CargarFichas(mat, NEGRA, CANT_FICHAS);
    DibujarMatriz(mat);
end;

begin
  Inicializar(mat);
end.  