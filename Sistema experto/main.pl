bc :- consult('enfermedades.pl'), consult('lista_enfermedades.pl'), consult('sintomas.pl'), consult('listas.pl').
:- initialization(bc).

agregar_enfermedad :-
    write('Ingrese el nombre de la enfermedad: '),
    read(Enfermedad),
    validar_lista(Enfermedad),
    open('enfermedades.pl', append, Stream),
    write(Stream, '\n   enfermedad(' ),write(Stream, Enfermedad), write(Stream, ') :-\n'),
    agregar_sintomas(Enfermedad,Stream, []),
    write(Stream, '.\n'),
    close(Stream).

agregar_sintomas(Enfermedad, Stream, Sintomas) :-
    write('Ingrese un sintoma o causa entre comillas simples (o fin para terminar): '),
    read(Sintoma),
    ( Sintoma == fin ->
        assertz(sintomas(Enfermedad, Sintomas)),
        guardar_sintomas,
        escribir_sintomas(Stream, Sintomas) ;
        agregar_sintomas(Enfermedad, Stream, [Sintoma|Sintomas])
    ).

escribir_sintomas(Stream, [Sintoma]) :-
    !, write(Stream, '    sintoma_causa(\''), write(Stream, Sintoma), write(Stream, '\')').
escribir_sintomas(Stream, [Sintoma|Resto]) :-
    write(Stream, '    sintoma_causa(\''), write(Stream, Sintoma), write(Stream, '\'),\n'),
    escribir_sintomas(Stream, Resto).

insertar_final(Elemento, [], [Elemento]).
insertar_final(Elemento, [Cabeza|Cola], [Cabeza|ListaResultado]) :-
    insertar_final(Elemento, Cola, ListaResultado).


agregar_enfermedad_lista(Enfermedad) :-
    enfermedades(Lista),
    insertar_final(Enfermedad, Lista, Lr),
    retract(enfermedades(Lista)),
    assertz(enfermedades(Lr)),
    guardar, nl.

validar_lista(Enfermedad):-
    enfermedades(Enfermedades),
    (member(Enfermedad, Enfermedades) ->
        write('La enfermedad ya existe en la base de conocimiento,\n'),fail ;
        agregar_enfermedad_lista(Enfermedad)).


    guardar :- tell('lista_enfermedades.pl'), listing(enfermedades/1), told.
insertar(E,L,Lr) :- Lr = [E|L].

guardar_sintomas :-
    tell('sintomas.pl'),
    listing(sintomas/2),
    told.

iniciar :-
    deshacer,
    bc,
    analisis(Enfermedad),
    (Enfermedad == desconocido ->
        realizar_pruebas, iniciar1;
        (write('Es probable que tengas: '), true)
    ),
    ((Enfermedad \== desconocido) -> write(Enfermedad) ; true),
    nl, deshacer.


preguntar(Pregunta) :-
    write('El paciente presenta el siguiente sintoma o causa? '),
    write(Pregunta), write(' :'),
    read(Respuesta),
    nl,
    validar_respuesta(Pregunta, Respuesta),
    ((Respuesta == si) -> assert(si(Pregunta)) ; assert(no(Pregunta)), fail).

validar_respuesta(_, si) :- !.
validar_respuesta(_, no) :- !.
validar_respuesta(Pregunta, _) :-
    write('Por favor, responde con "si" o "no".'), nl,
    preguntar(Pregunta).

:- dynamic si/1,no/1.

sintoma_causa(S) :-
    (si(S) -> true ; (no(S) -> fail ; preguntar(S))).

deshacer :- retract(si(_)),fail.
deshacer :- retract(no(_)),fail.
deshacer.

analisis(Enfermedad) :-
    enfermedades(Enfermedades),
    (member(Enfermedad, Enfermedades), enfermedad(Enfermedad) ->
        true ;
        Enfermedad = desconocido
    ).


inicio :- nl,
    write('---Menu---'), nl, 
    write('1. Consultar'), nl, 
    write('2. Agregar'), nl, 
    write('3. Salir'), nl, 
    write('Ingresa una opcion (1-3)'), nl, 
    read(Op), opcion(Op), !.


opcion(1) :- iniciar, inicio. 
opcion(2) :- agregar_enfermedad, write('Base de conocimiento actualizada'), inicio. 
opcion(3) :- write('Fin de programa...'), !. 
opcion(_) :- write('Revisa que el numero ingresado corresponda a una opcion (1-3) '), inicio. 
