Program InstaPas;

Type
    PuntArbol= ^NodoUsuarioArbol;
    PuntSeguidos= ^NodoSeguidos;
    PuntHistoria= ^NodoListaHistorias;
    NodoUsurioArbol= record
        nombre: string;
        password: string[8];
        email: string;
        usuariosSeguidos: PuntSeguidos;
        Historias: PuntHistoria;
        Menores, Mayores: PuntArbol;
    end;
    NodoListaHistorias= record
        fechaHora: string;
        fecha: Fecha;
        hora: Hora;
        texto: string;
        Sig: PuntHistoria;
    end;
    Fecha= record
        dia: integer;
        mes: integer;
        anio: integer;
    end;
    Hora= record
        hora: integer;
        minuto: integer;
    end;
    NodoSeguidos= record;
        nombre: string;
        Sig: PuntSeguidos;
    end;
