Program Registro2;
uses Crt;

Const
    Min= 1;
    MaxAlumnos= 100;

type
    Alumno = record
        nroDNI: LongInt;
        nombre: String;
        apellido: String;
        nomYapellido: String;
        facultad: 1..9;
        codCarrera: 10..99;
        anio: Integer;
    end;
    TArregloAlumnos= array[Min..MaxAlumnos] of Alumno;

procedure DatosAlumno(var alumno: Alumno);
begin
    write('Ingrese el Nombre del alumno: ');
    readln(alumno.nombre);
    write('Ingrese el Apellido del alumno: ');
    readln(alumno.apellido);
    alumno.nomYapellido:= alumno.apellido + ', ' + alumno.nombre;
    write('Ingrese el número de DNI del alumno: ');
    readln(alumno.nroDNI);
    write('Ingrese la facultad del alumno(1 a 9): ');
    readln(alumno.facultad);
    write('Ingrese el codigo de la carrera del alumno(10 a 99): ');
    readln(alumno.codCarrera);
    write('Ingrese el año que esta cursando el alumno: ');
    readln(alumno.anio);
end;

procedure InsertarAlumnoOrdenado(var arreglo: TArregloAlumnos; var cantidadAlumnos: Integer; nuevoAlumno: Alumno);
var
    i, j: Integer;
begin
    if cantidadAlumnos >= MaxAlumnos then
    begin
        writeln('El arreglo está lleno. No se puede insertar más alumnos.');
        exit;
    end;

    i:= cantidadAlumnos + 1;
    arreglo[i]:= nuevoAlumno;
    cantidadAlumnos:= cantidadAlumnos + 1;

    //Ordenar el arreglo alfabéticamente por apellido//
    j := i - 1;
    while (j > 0) and (arreglo[j].apellido > nuevoAlumno.apellido) do
    begin
        arreglo[j + 1] := arreglo[j];                        //Mover el elemento actual hacia la derecha//
        j := j - 1;
    end;

    arreglo[j + 1]:= nuevoAlumno;                        //Insertar el nuevo alumno en la posición correcta//
end;

procedure ImprimirAlumnos(arreglo: TArregloAlumnos; cantidadAlumnos: Integer);
var
    i: Integer;
begin

    if cantidadAlumnos = 0 then
    begin
        writeln('La lista de alumnos esta vacia.');
        exit;
    end;

    writeln('Lista de Alumnos: ');
    for i:= 1 to cantidadAlumnos do
    begin
        writeln('<------------------------------------->');
        writeln('Nombre: ', arreglo[i].nomYapellido);
        writeln('- Nro. de DNI: ', arreglo[i].nroDNI);
        writeln('- Nro. de Facultad: ', arreglo[i].facultad);
        writeln('- Codigo de Carrera: ', arreglo[i].codCarrera);
        writeln('- Año que cursa: ', arreglo[i].anio);
    end;
end;

var
    nuevoAlumno: Alumno;
    alumnos: TArregloAlumnos;
    cantidadAlumnos: Integer;
    terminar: boolean;
    SN: char;

begin
    cantidadAlumnos:= 0;
    terminar:= false;
    write('Desea agregar un alumno? S/N: ');
    readln(SN);
    SN:= UpCase(SN);
    if SN = 'S' then
        terminar:= false
    else if SN = 'N' then
        terminar:= true;
    while not terminar do
    begin
        DatosAlumno(nuevoAlumno);
        InsertarAlumnoOrdenado(alumnos, cantidadAlumnos, nuevoAlumno);
        ClrScr;
        ImprimirAlumnos(alumnos, cantidadAlumnos);
        writeln('<------------------------------------->');
        writeln(' ');
        write('Desea seguir agregando alumnos? S/N: ');
        readln(SN);
        SN:= UpCase(SN);
        if SN = 'S' then
            terminar:= false
        else if SN = 'N' then
            terminar:= true;
        ClrScr;
    end;
    ImprimirAlumnos(alumnos, cantidadAlumnos);
    writeln('<------------------------------------->');


end.
