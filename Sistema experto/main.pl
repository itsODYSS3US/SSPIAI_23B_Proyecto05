bc :- consult('enfermedades.pl').
:- initialization(bc).

agregar_enfermedad :-
    write('Ingrese el nombre de la enfermedad: '),
    read(Enfermedad),
    open('enfermedades.pl', append, Stream),
    write(Stream, '\n   enfermedad(' ),write(Stream, Enfermedad), write(Stream, ') :-\n'),
    agregar_sintomas(Stream, []),
    write(Stream, '.\n'),
    close(Stream).

agregar_sintomas(Stream, Sintomas) :-
    write('Ingrese un sÃ­ntoma (o "fin" para terminar): '),
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



iniciar :-
    deshacer,
    analisis(Enfermedad),
    ((Enfermedad == desconocido) -> write('Los sÃ­ntomas no coinciden con la base de conocimiento') ; write('Es probable que tengas: '), true),
    write(Enfermedad),
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


% analisis(asma) :- asma, !.
% analisis(neumonia) :- neumonia, !.
% analisis(bronquitis) :- bronquitis, !.
% analisis(bronquiolitis) :- bronquiolitis, !.
% analisis(gripe) :- gripe, !.
% analisis(tuberculosis) :- tuberculosis, !.

analisis(Enfermedad) :-
    enfermedades(Enfermedades),
    member(Enfermedad, Enfermedades),
    enfermedad(Enfermedad), !.

% Predicados para representar las opciones del menú
opcion(1, 'Consulta').
opcion(2, 'Agregar').
opcion(3, 'Salir').


% Predicado para imprimir el menú
imprimir_menu :-
    writeln('Menú:'),
    forall(opcion(Opcion, Texto), format('~d. ~w~n', [Opcion, Texto])).

% Predicado para procesar la elección del usuario
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
    writeln('Opción no válida. Por favor, elige una opción válida.').

% Consulta principal para ejecutar el menú
menu :-
    repeat,
    imprimir_menu,
    write('Elige una opción: '), read(Opcion),
    procesar_opcion(Opcion),
    (Opcion == 3, ! ; fail).
