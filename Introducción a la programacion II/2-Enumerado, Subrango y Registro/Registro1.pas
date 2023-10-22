Program Fecha;

type
    Fecha = record
        dia: 1..31;
        mes: 1..12;
        anio: 1900..2100;
    End;

procedure CargarFecha(var fecha: Fecha);
var n: Integer;
begin
    writeln('Ingrese la Fecha: ');
    write('Ingrese el dia: ');
    readln(n);
    fecha.dia:= n;
    write('Ingrese el mes: ');
    readln(n);
    fecha.mes:= n;
    write('Ingrese el año(1900 a 2100): ');
    readln(n);
    fecha.anio:= n;
end;

procedure SumarDias(var fecha: Fecha);
var d, m, a, n, sum: Integer;
begin
    d:= fecha.dia;
    m:= fecha.mes;
    a:= fecha.anio;
    write('Ingrese la cantidad de dias a sumar a la fecha: ')
    readln(n);
    sum:= d + n;
    if sum <= 31 then
        fecha.dia:= sum
    else if sum > 32 then 
        begin
            sum= (m * 31) + sum;
            if sum < 372 then
                begin
                    
                end
            else begin

            end;
        end;    
end;

var
    Fecha1: Fecha;

begin
    
end.