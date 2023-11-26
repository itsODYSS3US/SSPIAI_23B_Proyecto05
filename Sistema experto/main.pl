bc :- consult('enfermedades.pl').
:- initialization(bc).

agregar_enfermedad :-
    write('Ingrese el nombre de la enfermedad: '),
    read(Enfermedad),
    open('enfermedades.pl', append, Stream),
    write(Stream, Enfermedad), write(Stream, ' :-\n'),
    agregar_sintomas(Stream, []),
    write(Stream, '.\n'),
    close(Stream).

agregar_sintomas(Stream, Sintomas) :-
    write('Ingrese un síntoma (o "fin" para terminar): '),
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
    analisis(Enfermedad),
    ((Enfermedad == desconocido) -> write('Tu diagnostico es: ') ; write('Es probable que tengas: '), true),
    write(Enfermedad),
    nl, deshacer.

preguntar(Pregunta) :-
    write('El paciente tiene alguno de estos sintomas: '),
    write(Pregunta),
    write(' ?'),
    read(Respuesta),
    nl,
    validar_respuesta(Respuesta),
    ((Respuesta == si) -> assert(si(Pregunta)) ; assert(no(Pregunta)), fail).

validar_respuesta(si) :- !.
validar_respuesta(no) :- !.
validar_respuesta(_) :-
    write('Por favor, responde con "si" o "no".'), nl,
    fail.

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
    enfermedad(Enfermedad).