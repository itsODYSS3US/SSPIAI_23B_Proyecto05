bc :- consult('enfermedades.pl'), consult('lista_enfermedades.pl').
:- initialization(bc).

agregar_enfermedad :-
    write('Ingrese el nombre de la enfermedad: '),
    read(Enfermedad),
    agregar_enfermedad_lista(Enfermedad),
    open('enfermedades.pl', append, Stream),
    write(Stream, '\n   enfermedad(' ),write(Stream, Enfermedad), write(Stream, ') :-\n'),
    agregar_sintomas(Stream, []),
    write(Stream, '.\n'),
    close(Stream).

agregar_sintomas(Stream, Sintomas) :-
    write('Ingrese un sintoma (o "fin" para terminar): '),
    read(Sintoma),
    ( Sintoma == fin ->
        escribir_sintomas(Stream, Sintomas) ;
        agregar_sintomas(Stream, [Sintoma|Sintomas])
    ).

escribir_sintomas(Stream, [Sintoma]) :-
    !, write(Stream, '    sintoma(\''), write(Stream, Sintoma), write(Stream, '\')').
escribir_sintomas(Stream, [Sintoma|Resto]) :-
    write(Stream, '    sintoma(\''), write(Stream, Sintoma), write(Stream, '\'),\n'),
    escribir_sintomas(Stream, Resto).

insertar_final(Elemento, [], [Elemento]).
insertar_final(Elemento, [Cabeza|Cola], [Cabeza|ListaResultado]) :-
    insertar_final(Elemento, Cola, ListaResultado).


agregar_enfermedad_lista(Enfermedad) :-
    enfermedades(Lista),
    insertar_final(Enfermedad, Lista, Lr),
    retract(enfermedades(Lista)),
    assertz(enfermedades(Lr)),
    guardar,
    write('La base de conocimientos ha sido actualizada...'), nl.


% agregar(Elemento,Tipo) :- animales(Tipo,Lista),
%     buscar1(Elemento,Lista),
%     write('El elemento que desea agregar ya se encuentra en la lista'), nl.

    guardar :- tell('lista_enfermedades.pl'), listing(enfermedades/1), told.
insertar(E,L,Lr) :- Lr = [E|L].


iniciar :-
    deshacer,
    bc,
    analisis(Enfermedad),
    (Enfermedad == desconocido ->
        writeln('No se encontro una enfermedad que coincida con los sintomas');
        (write('Es probable que tengas: '), true)
    ),
    ((Enfermedad \== desconocido) -> write(Enfermedad) ; true),
    nl, deshacer.


preguntar(Pregunta) :-
    write('El paciente tiene alguno de estos sintomas: '),
    write(Pregunta),
    write(' ?'),
    read(Respuesta),
    nl,
    % validar_respuesta(Respuesta),
    ((Respuesta == si) -> assert(si(Pregunta)) ; assert(no(Pregunta)), fail).

% validar_respuesta(si) :- !.
% validar_respuesta(no) :- !.
% validar_respuesta(_) :-
%     write('Por favor, responde con "si" o "no".'), nl,
%     fail.

:- dynamic si/1,no/1.

sintoma(S) :-
    (si(S) -> true ; (no(S) -> fail ; preguntar(S))).

deshacer :- retract(si(_)),fail.
deshacer :- retract(no(_)),fail.
deshacer.

% analisis(Enfermedad) :-
%     enfermedades(Enfermedades),
%     member(Enfermedad, Enfermedades),
%     enfermedad(Enfermedad), !.

analisis(Enfermedad) :-
    enfermedades(Enfermedades),
    (member(Enfermedad, Enfermedades), enfermedad(Enfermedad) ->
        true ;
        Enfermedad = desconocido
    ).


% Predicados para representar las opciones del menu
opcion(1, 'Consulta').
opcion(2, 'Agregar').
opcion(3, 'Salir').


% Predicado para imprimir el menu
imprimir_menu :-
    writeln('Menu:'),
    forall(opcion(Opcion, Texto), format('~d. ~w~n', [Opcion, Texto])).

% Predicado para procesar la eleccion del usuario
procesar_opcion(1) :-
    writeln('Bienvenido a consulta.'),
    iniciar,
    nl.


procesar_opcion(2) :-
    writeln('Ingrese nueva enfermedad.'),
    agregar_enfermedad,
    nl.

procesar_opcion(3) :-
     writeln('Saliendo del programa.').


procesar_opcion(Opcion) :-
    Opcion \= 1, Opcion \= 2, Opcion \= 3,
    writeln('Opcion no vaida. Por favor, elige una opcion valida.').

% Consulta principal para ejecutar el menu
menu :-
    repeat,
    imprimir_menu,
    write('Elige una opcion: '), read(Opcion),
    procesar_opcion(Opcion),
    (Opcion == 3, ! ; fail).
