Program Registro1;

type
    Fecha = record
        dia: Integer;
        mes: Integer;
        anio: Integer;
    End;

procedure CargarFecha(var fecha: Fecha);
var n: Integer;
begin
    write('Ingrese el dia: ');
    readln(n);
    fecha.dia:= n;
    write('Ingrese el mes: ');
    readln(n);
    fecha.mes:= n;
    write('Ingrese el año(de 1900 a 2100): ');
    readln(n);
    fecha.anio:= n;
end;

procedure SumarDias(var fecha: Fecha);
var n: Integer;
begin
    write('Ingrese la cantidad de dias a sumar a la fecha: ');
    readln(n);
    fecha.dia:= fecha.dia + n;
    while fecha.dia > 31 do
    begin
        fecha.dia:= fecha.dia - 31;
        fecha.mes:= fecha.mes + 1;
        if fecha.mes > 12 then
        begin
            fecha.mes:= fecha.mes - 12;
            fecha.anio:= fecha.anio + 1;
        end;
    end;
end;

//Se simplifica suponiendo que todos los meses tienen 31 dias//
function CalcularDiasEntreFechas(fecha1, fecha2: Fecha): Integer;
begin
    CalcularDiasEntreFechas:= (fecha2.anio - fecha1.anio) * 372 + (fecha2.mes - fecha1.mes) * 31 + (fecha2.dia - fecha1.dia);
end;

procedure ImprimirFecha(fecha: Fecha);
begin
    writeln('Fecha: ', fecha.dia, '/', fecha.mes, '/', fecha.anio);
end;

var
    Fecha1, Fecha2: Fecha;
    diasEntreFechas: Integer;

begin
    writeln('Ingrese la Fecha 1: ');
    CargarFecha(Fecha1);
    writeln('Ingrese la Fecha 2: ');
    CargarFecha(Fecha2);

    write('Fecha 1: ');
    ImprimirFecha(Fecha1);
    write('Fecha 2: ');
    ImprimirFecha(Fecha2);

    diasEntreFechas:= CalcularDiasEntreFechas(Fecha1, Fecha2);
    Writeln('Días entre Fecha 1 y Fecha 2: ', diasEntreFechas);
    
    SumarDias(Fecha1);
    Write('Fecha 1 después de sumar días: ');
    ImprimirFecha(fecha1);

    write('Fecha 1: ');
    ImprimirFecha(Fecha1);
    write('Fecha 2: ');
    ImprimirFecha(Fecha2);
    
    diasEntreFechas:= CalcularDiasEntreFechas(Fecha1, Fecha2);
    Writeln('Días entre Fecha 1 y Fecha 2: ', diasEntreFechas);
end.