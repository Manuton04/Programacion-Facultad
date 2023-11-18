Program Registro3;

const
    Disc= -1;
    MaxF= 12;
    MaxC= 31;

Type
    Lluvia= record
        mes: 1..MaxF;
        dia: 1..MaxC;
        contenido: real;
    end;
    TMatrizReal= array[1..MaxC, 1..MaxF] of real; //Dia x MES//
    TArregloRala= Array[1..50] of Lluvia; //Dias con lluvia//

procedure LlenarMatrizDisc(var mat: TMatrizReal);
var i, j: integer;
begin
    for i:=1 to MaxC do
    begin
        for j:= 1 to MaxF do
        begin
            mat[i,j]:= Disc;
        end;
    end;
end;

procedure AgregarDia(var mat: TMatrizReal);
var
    dia, mes: integer;
    lluvia: real;

begin
    Write('Ingrese el dia(1 a 31): ');
    readln(dia);
    Write('Ingrese el mes(1 a 12): ');
    readln(mes);
    Write('Ingrese la precipitación diaria en milimetros: ');
    readln(lluvia);

    mat[dia, mes]:= lluvia;
end;

procedure ImprimirDiasConLluvia(arr: TArregloRala, cantidadDias: integer);
var
    i: Integer;
begin

    writeln('Lista de precipitaciones: ');
    for i:= 1 to cantidadDias do
    begin
        writeln('<------------------------------------->');
        writeln('Fecha: ', arr[i].dia, '/', arr[i].mes);
        writeln('- Cantidad: ', arr[i].contenido:0:2, ' mm');
    end;
end;

var
    matriz: TMatrizReal;
    arreglo: TArregloRala;
    terminar: boolean;
    SN: Char;
    CantidadDias: Integer;

begin
    CantidadDias:= 0;
    LlenarMatrizDisc(matriz);
    terminar:= false;

    write('Desea agregar la precipitacion de una fecha? S/N: ');
    readln(SN);
    SN:= UpCase(SN);
    if SN = 'S' then
        terminar:= false
    else if SN = 'N' then
        terminar:= true;

    while not terminar do 
    begin
        AgregarDia(matriz);
    end;
end.