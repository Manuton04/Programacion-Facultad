// Hecho por Manuel Torres, Comision 2
program MiniDamas;
uses Crt;

const
  FILAS = 8;
  COLUMNAS = 8;
  BLANCA = 'x';
  NEGRA = 'o';
  CANT_FICHAS = 12;
  C: array[1..9] of string = ('┐', '┌', '┘', '└', '─', '│', ' ', '┼', '█');  {Posibilidades:  ▒ ▓ ░ ▩ ■ █ ▮}
  ASCII: array[1..8] of string = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H');

type
  matriz= array[1..FILAS, 1..COLUMNAS] of char;
  
var
  mat: matriz;
  seguirJugando: Boolean;
  input: char;

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
// Carga la matriz con las 24 fichas en su posicion inicial.
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
    writeln('    1  2  3  4  5  6  7  8       Equipo blanco: x   Equipo negro: o');
    write('  ',C[2]);
    for j:=1 to COLUMNAS do write(C[5],C[5],C[5]);
    write(C[1]);
    for i:=1 to FILAS do begin
        write(ASCII[i], ' ', C[6]);
        for j:=1 to COLUMNAS do begin
            if not(FondoNegro(i,j)) then
                write(C[9],C[9],C[9])
            else
                write(' ',mat[i,j],' ');
        end;
        writeln(C[6]);
    end;
    write('  ',C[4]);
    for j:=1 to COLUMNAS do write(C[5],C[5],C[5]);
    write(C[3]);
    writeLn('Fichas capturadas: ');
    for i := 1 to CANT_FICHAS - CantFichasEnTablero(mat,NEGRA) do write(NEGRA); writeln();
    for i := 1 to CANT_FICHAS - CantFichasEnTablero(mat,BLANCA) do write(BLANCA); writeln();
    WriteLn(' ');
end;

//Traduce los valores de ASCII a integer. Los cuenta a partir de A.//
//A=1, B=2, C=3, D=4, E=5, F=6, G=7, H=8//
//A en ASCII es 65, H es 72//
function TraducirAH(caracter: char): integer;
begin
    TraducirAH:= Ord(UpCase(caracter)) - Ord('A') + 1;
end;

//Esto no traduce nada, lo unico que asegura es que no salte un error al responder un char donde deberia ir un Integer//
//1 es ASCII es 49, 8 es 56//
function Traducir18(caracter: char): integer;
begin
    Traducir18:= Ord(caracter) - Ord('1') + 1;
end;

 //Verifica si la posición es parte del tablero//
function EstaEnTablero(a, b: Integer): Boolean;
begin
    if ((a >= 1) and (a <= 8)) and ((b >= 1) and (b <= 8)) then
        EstaEnTablero:= True
    else 
        EstaEnTablero:= False;
end;

//Pide las posiciones de Origen y Destino, si estan mal escritas pide de nuevo//
procedure PedirPosiciones(var origenA, origenB, destinoA, destinoB: Integer);
var 
    origen, destino: string;
    rehacer: Boolean;
begin
    rehacer:= true;

    while rehacer do begin
        rehacer:= false;
        write('Ingresa la posición de la ficha a mover (EJ: F1): ');
        readln(origen);
        write('Ingresa la posición a la quieres mover la ficha (EJ: E2): ');
        readln(destino);

        //Chequea si la longitud es 2 y los traduce a numeros entre 1 y 8//
        //Si la longitud no es 2 no lo traduce, por lo que al verificar si esta en tablero salta como falso//
        if (Length(origen) = 2) and (Length(destino) = 2) then begin
            origenA:= TraducirAH(origen[1]);
            origenB:= Traducir18(origen[2]);
            destinoA:= TraducirAH(destino[1]);
            destinoB:= Traducir18(destino[2]);

            //Chequea si están bien escritas//
            if (not EstaEnTablero(origenA, origenB)) or (not EstaEnTablero(destinoA, destinoB)) then
                rehacer:= true;

            //Lo use para ver un error que me salia//
            //writeln('origen:', origen);
            //writeln('destino:', destino);
            //WriteLn('Origen Mod: ', origenA, ' ', origenB);
            //WriteLn('Destino Mod: ', destinoA, ' ', destinoB);
        end
        else
            rehacer:= true;

        if rehacer then begin
            writeln('');
            writeln('Una posición entregada no es correcta, inténtelo de nuevo.');
            writeln('(Recuerda que la posición debe estar en el rango A-H y 1-8');
            writeln(' y se debe escribir la letra delante del número. EJ: F1)');
            writeln('');
        end;
    end;
end;

//Lo uso para pedir posición despues de comer una ficha//
procedure PedirDestino(var destinoFil, destinoCol: Integer);
var
    destino: string;
    rehacer: Boolean;
begin
    rehacer:= true;

    while rehacer do begin
        rehacer:= false;
        write('Ingresa la posición a la quieres mover la ficha (EJ: E2): ');
        readln(destino);

        //Chequea si la longitud es 2 y los traduce a numeros entre 1 y 8//
        //Si la longitud no es 2 no lo traduce, por lo que al verificar si esta en tablero salta como falso//
        if (Length(destino) = 2) then begin
            destinoFil:= TraducirAH(destino[1]);
            destinoCol:= Traducir18(destino[2]);

            //Chequea si está bien escrito//
            if (not EstaEnTablero(destinoFil, destinoCol)) then
                rehacer:= true;

        end
        else
            rehacer:= true;

        if rehacer then begin
            writeln('');
            writeln('Una posición entregada no es correcta, inténtelo de nuevo.');
            writeln('(Recuerda que la posición debe estar en el rango A-H y 1-8');
            writeln(' y se debe escribir la letra delante del número. EJ: F1)');
            writeln('');
        end;
    end;
end;

//Indica si hay movimientos en los que puedes capturar una ficha enemiga//
//Por reglamento, si es posible, es obligatorio capturar//
// i+1, j+1 // i+1, j-1 // i-1, j+1 // i-1, j-1 ////// i+2, j+2 // i+2, j-2 // i-2, j+2 // i-2, j-2 ////// 
function HayCapturables(mat: matriz; equipo, enemigo: char): Boolean;
var i, j: integer;
begin
    HayCapturables:= false;
    for i:= 1 to FILAS do begin
        for j:= 1 to COLUMNAS do begin

            if mat[i, j] <> equipo then
                Continue;

            if i <= 2 then begin
                if j <= 2 then begin
                    if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) then
                        HayCapturables:= true;
                end
                else if (j > 2) and (j < 7) then begin
                    if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) or 
                        ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) then
                        HayCapturables:= true;
                end
                else if j >= 7 then begin
                    if ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) then
                        HayCapturables:= true;
                end;
            end
            else if (i > 2) and (i < 7) then begin
                if j <= 2 then begin
                    if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) or 
                        ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) then
                        HayCapturables:= true;
                end
                else if (j > 2) and (j < 7) then begin
                    if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) or 
                        ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) or
                        ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) or
                        ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                        HayCapturables:= true;
                end
                else if j >= 7 then begin
                    if ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) or
                        ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                        HayCapturables:= true;
                end;
            end
            else if i >= 7 then begin
                if j <= 2 then begin
                    if ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) then
                        HayCapturables:= true;
                end
                else if (j > 2) and (j < 7) then begin
                    if ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) or
                        ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                        HayCapturables:= true;
                end
                else if j >= 7 then begin
                    if ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                        HayCapturables:= true;
                end;
            end;
        end;
    end;
end;

//Indica si la ficha ubicada en cierta posicion puede capturar una ficha//
//Usar para verificar si una ficha puede seguir capturando fichas//
function PuedeCapturar(mat: matriz; equipo, enemigo:char; origenFila, origenCol: integer): Boolean;
var i,j: Integer;
begin
    PuedeCapturar:= False;
    i:= origenFila;
    j:= origenCol;
    if mat[i, j] <> equipo then
        Exit;

    if i <= 2 then begin
        if j <= 2 then begin
            if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) then
                PuedeCapturar:= true;
        end
        else if (j > 2) and (j < 7) then begin
            if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) or 
                ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) then
                PuedeCapturar:= true;
        end
        else if j >= 7 then begin
            if ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) then
                PuedeCapturar:= true;
        end;
    end
    else if (i > 2) and (i < 7) then begin
        if j <= 2 then begin
            if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) or 
                ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) then
                PuedeCapturar:= true;
        end
        else if (j > 2) and (j < 7) then begin
            if ((mat[i+1, j+1] = enemigo) and (mat[i+2, j+2] = ' ')) or 
                ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) or
                ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) or
                ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                PuedeCapturar:= true;
        end
        else if j >= 7 then begin
            if ((mat[i+1, j-1] = enemigo) and (mat[i+2, j-2] = ' ')) or
                ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                PuedeCapturar:= true;
        end;
    end
    else if i >= 7 then begin
        if j <= 2 then begin
            if ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) then
                PuedeCapturar:= true;
        end
        else if (j > 2) and (j < 7) then begin
            if ((mat[i-1, j+1] = enemigo) and (mat[i-2, j+2] = ' ')) or
                ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                PuedeCapturar:= true;
        end
        else if j >= 7 then begin
            if ((mat[i-1, j-1] = enemigo) and (mat[i-2, j-2] = ' ')) then
                PuedeCapturar:= true;
        end;
    end;
end;

//Indica si el movimiento es valido//
//Tambien indica si se realizo un movimiento con captura, de ser así dara opcion a capturar de nuevo//
//El Exit; hace que no siga la función//
//N/N = Movimiento no valido/No captura, S/N = Movimiento valido/No captura, S/S = Movimiento valido/Captura//
function MovimientoValido(mat: matriz; origenFil, origenCol, destinoFil, destinoCol: Integer; equipo, enemigo: char): String;
var
    distanciaFil, distanciaCol, intermedioCol, intermedioFil: Integer;
begin
    if not EstaEnTablero(origenFil, origenCol) or not EstaEnTablero(destinoFil, destinoCol) then begin
        MovimientoValido:= 'N/N';
        Exit;
    end;

    if mat[origenFil, origenCol] <> equipo then begin
        MovimientoValido:= 'N/N';
        Exit;
    end;

    if mat[destinoFil, destinoCol] <> ' ' then begin
        MovimientoValido:= 'N/N';
        Exit;
    end;

    //Calcula la distancia en filas y columnas entre origen y destino//
    distanciaFil:= Abs(destinoFil - origenFil);
    distanciaCol:= Abs(destinoCol - origenCol);

    // Movimiento normal
    if (distanciaFil = 1) and (distanciaCol = 1) then begin
        //Verifica si el movimiento es hacia adelante o hacia atrás según el equipo//
        if (equipo = BLANCA) and ((destinoFil - origenFil) = 1) then
            MovimientoValido:= 'N/N'
        else if (equipo = NEGRA) and ((destinoFil - origenFil) = -1) then
            MovimientoValido:= 'N/N'
        else
            MovimientoValido:= 'S/N';
    end
    else if (distanciaFil = 2) and (distanciaCol = 2) then begin
        //Movimiento con captura//
        //Calcula las coordenadas de la casilla intermedia entre el origen y destino//
        intermedioFil:= (origenFil + destinoFil) div 2;
        intermedioCol:= (origenCol + destinoCol) div 2;

        if mat[intermedioFil, intermedioCol] = enemigo then
            MovimientoValido:= 'S/S'
        else
            MovimientoValido:= 'N/N';
    end
    else
        MovimientoValido:= 'N/N';
end;

//Realiza un movimiento normal//
procedure MovimientoNormal(var mat: matriz; origenFil, origenCol, destinoFil, destinoCol: integer; equipo: char);
begin
    mat[destinoFil, destinoCol]:= equipo;
    mat[origenFil, origenCol]:= ' ';
end;

//Realiza un movimiento con captura//
procedure MovimientoConCaptura(var mat: matriz; origenFil, origenCol, destinoFil, destinoCol: integer; equipo: char);
var intermedioFil, intermedioCol: Integer;
begin
    intermedioFil:= (origenFil + destinoFil) div 2;
    intermedioCol:= (origenCol + destinoCol) div 2;

    mat[destinoFil, destinoCol]:= equipo;
    mat[intermedioFil, intermedioCol]:= ' ';
    mat[origenFil, origenCol]:= ' ';
end;

//MovimientoValido(mat: matriz; origenFil, origenCol, destinoFil, destinoCol: Integer; equipo, enemigo: char)//
//Indica si se pueden realizar movimientos por parte de un equipo//
// i+1, j+1 // i+1, j-1 // i-1, j+1 // i-1, j-1 ////// i+2, j+2 // i+2, j-2 // i-2, j+2 // i-2, j-2 ////// 
function HayMovimientosDisp(mat: matriz; equipo, enemigo:char): Boolean;
var i,j: Integer;
begin
    HayMovimientosDisp:= false;
    for i:= 1 to FILAS do begin
        for j:= 1 to COLUMNAS do begin
            if (MovimientoValido(mat, i, j, i+1, j+1, equipo, enemigo)[1] = 'S') or 
               (MovimientoValido(mat, i, j, i+1, j-1, equipo, enemigo)[1] = 'S') or 
               (MovimientoValido(mat, i, j, i-1, j+1, equipo, enemigo)[1] = 'S') or 
               (MovimientoValido(mat, i, j, i-1, j-1, equipo, enemigo)[1] = 'S') then begin
                    HayMovimientosDisp:= true;
                    Exit;
                end;
            if (MovimientoValido(mat, i, j, i+2, j+2, equipo, enemigo)[1] = 'S/N') or 
               (MovimientoValido(mat, i, j, i+2, j-2, equipo, enemigo)[1] = 'S/N') or 
               (MovimientoValido(mat, i, j, i-2, j+2, equipo, enemigo)[1] = 'S/N') or 
               (MovimientoValido(mat, i, j, i-2, j-2, equipo, enemigo)[1] = 'S/N') then begin
                    HayMovimientosDisp:= true;
                    Exit;
                end;
        end;
    end;
end;

//Indica si el juego tiene que terminar//
//Puede ser por no tener mas fichas o porque no tienen movimientos disponibles//
function Terminado(mat: matriz): Boolean;
begin
    Terminado:= false;
    
    if (CantFichasEnTablero(mat, BLANCA) = 0) or (CantFichasEnTablero(mat, NEGRA) = 0) then
        Terminado:= true
    else if not (HayMovimientosDisp(mat, BLANCA, NEGRA)) or not (HayMovimientosDisp(mat, NEGRA, BLANCA)) then
        Terminado:= true
end;

//Pantalla de Inicio//
procedure Inicio();
begin
    WriteLn('Bienvenido al juego de MINIDAMAS');    
    WriteLn('');
    WriteLn('Aclaraciones importantes:');
    WriteLn('- Siempre se debe jugar con el fondo negro de la consola.');
    WriteLn('- El equipo BLANCO se identifica con "x" y el equipo NEGRO con "o".');
    WriteLn('- En este juego no se utiliza el concepto de Reina.');
    WriteLn('- Si despues de capturar una ficha rival podes capturar otra en el');
    WriteLn('  mismo turno con la misma ficha, primero escribir el destino de la');
    WriteLn('  posición 1, luego automaticamente te pedira la siguiente posicion.');
    WriteLn('- Puedes capturar para delante y para atras.');
    WriteLn('');
    WriteLn('');
    
    WriteLn('Final de partida: ');
    WriteLn('La partida termina cuando un jugador se queda sin fichas o estas no tienen');
    WriteLn('posibilidad de movimiento.');
    WriteLn('');

    WriteLn('Hecho por Manuel Torres.');
    WriteLn('');

    Write('Presiona ENTER para empezar: ');
    ReadLn();
end;

//Inicia el tablero//
procedure InicializarTablero(var mat: matriz);
begin
    InicMatriz(mat);
    CargarFichas(mat, BLANCA, CANT_FICHAS);
    CargarFichas(mat, NEGRA, CANT_FICHAS);
end;

//Se ejecuta mientras nadie haya perdido//
procedure Jugando(var mat:matriz);
var 
    origenA, origenB, destinoA, destinoB, turno, ronda: Integer;
    equipo, adversario: char;
    ganador: string;
begin
    turno:= 1;
    while Terminado(mat) = false do begin
        DibujarMatriz(mat);
        if (turno MOD 2) = 1 then
            ronda:= (turno+1) DIV 2
        else
            ronda:= turno DIV 2;
        if (turno MOD 2) = 1 then begin
            WriteLn('Ronda ', ronda, ': ');
            writeln('Turno del jugador BLANCO: ');
            equipo:= BLANCA;
            adversario:= NEGRA;
        end
        else begin
            WriteLn('Ronda ', ronda, ': ');
            writeln('Turno del jugador NEGRO: ');
            equipo:= NEGRA;
            adversario:= BLANCA;
        end;

        PedirPosiciones(origenA, origenB, destinoA, destinoB);
        //Si el movimiento no es valido se piden valores de nuevo//
        while MovimientoValido(mat, origenA, origenB, destinoA, destinoB, equipo, adversario)[1] = 'N' do begin
            WriteLn(' ');
            writeln('El movimiento ingresado es incorrecto, intentelo de nuevo: ');
            PedirPosiciones(origenA, origenB, destinoA, destinoB);
        end;

        while (HayCapturables(mat, equipo, adversario)) and not (MovimientoValido(mat, origenA, origenB, destinoA, destinoB, equipo, adversario)[3] = 'S') do begin
            WriteLn(' ');
            writeln('El movimiento ingresado es incorrecto, intentelo de nuevo: ');
            WriteLn('De tener la posibilidad de capturar una ficha debes hacerlo.');
            PedirPosiciones(origenA, origenB, destinoA, destinoB);
        end;

        //Hacer si es movimiento normal//
        if (MovimientoValido(mat, origenA, origenB, destinoA, destinoB, equipo, adversario) = 'S/N') then
            MovimientoNormal(mat, origenA, origenB, destinoA, destinoB, equipo);

        //Hacer movimiento con capturar//
        //Hacer que si comes una ficha tenes la opcion de seguir comiendo, desde esa posicion//
        if (MovimientoValido(mat, origenA, origenB, destinoA, destinoB, equipo, adversario)[3] = 'S') then begin
            MovimientoConCaptura(mat, origenA, origenB, destinoA, destinoB, equipo);
            origenA:= destinoA;
            origenB:= destinoB;
            while PuedeCapturar(mat, equipo, adversario, origenA, origenB) do begin
                DibujarMatriz(mat);
                WriteLn('Puedes seguir capturando con la misma ficha.');
                PedirDestino(destinoA, destinoB);
                while MovimientoValido(mat, origenA, origenB, destinoA, destinoB, equipo, adversario)[1] = 'N' do begin
                    WriteLn(' ');
                    writeln('El movimiento ingresado es incorrecto, intentelo de nuevo: ');
                    PedirDestino(destinoA, destinoB);
                end;
                MovimientoConCaptura(mat, origenA, origenB, destinoA, destinoB, equipo);
                origenA:= destinoA;
                origenB:= destinoB;
            end;
        end;
        turno:= turno +1;
    end;
    //Determina el resultado//
    if (CantFichasEnTablero(mat, BLANCA) = 0) or (HayMovimientosDisp(mat, BLANCA, NEGRA)) then
        ganador:= 'Negro'
    else if (CantFichasEnTablero(mat, NEGRA) = 0) or (HayMovimientosDisp(mat, NEGRA, BLANCA)) then
        ganador:= 'Blanco';

    if (CantFichasEnTablero(mat, BLANCA) = 0) and (CantFichasEnTablero(mat, NEGRA) = 0) then
        ganador:= 'Empate'
    else if (not HayMovimientosDisp(mat, BLANCA, NEGRA)) and (not HayMovimientosDisp(mat, NEGRA, BLANCA)) then
        ganador:= 'Empate';

    //Pantalla de resultados//
    ClrScr;
    WriteLn('Partida finalizada: ');
    WriteLn('');
    if ganador <> 'Empate' then
        WriteLn('- Ganador: Equipo ', ganador)
    else
        WriteLn('- Resultado: Empate');
    WriteLn('');
    WriteLn('- Número de rondas: ', ronda);
    WriteLn('');
    Write('- Razón de victoria: ');
    if (CantFichasEnTablero(mat, BLANCA) = 0) or (CantFichasEnTablero(mat, NEGRA) = 0) then
        WriteLn('El equipo perdedor no tiene más fichas.')
    else if (not HayMovimientosDisp(mat, BLANCA, NEGRA)) or (not HayMovimientosDisp(mat, NEGRA, BLANCA)) then
        WriteLn('El equipo perdedor no puede realizar mas movimientos');
    WriteLn('');
    WriteLn('');
    WriteLn('');
    Write('Presiona ENTER para salir: ');
    ReadLn();

end;

procedure PantallaFin();
begin
    WriteLn('');
    WriteLn('');
    WriteLn('');
    WriteLn('');
    WriteLn('');
    WriteLn('¡Gracias por jugar!');
    WriteLn('Hecho por Manuel Torres.');


end;

begin
    Inicio();
    InicializarTablero(mat);
    Jugando(mat);
    PantallaFin();
end.  