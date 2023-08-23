Program FinalProg1;

Const
    MaxDim: 12;
    Disc: -1;

type
    TMatrizInt= array[1..MaxDim, 1..MaxDim] of Integer;



var
    Mat: TMatrizInt;

begin
    CargarMatriz();
    ImprimirMatriz();
end.