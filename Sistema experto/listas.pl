:-dynamic enf/2.

% Regla para contar coincidencias entre dos listas
contar_coincidencias([], _, 0).
contar_coincidencias([H|T], Lista2, Count) :-
    member(H, Lista2),
    contar_coincidencias(T, Lista2, SubCount),
    Count is SubCount + 1.
contar_coincidencias([_|T], Lista2, Count) :-
    contar_coincidencias(T, Lista2, Count).

% Regla principal para comparar dos listas de animales
comparar_listas(Enfermedad, Lista2, Coincidencias) :-
    sintomas(Enfermedad, Lista1),
    contar_coincidencias(Lista1, Lista2, Coincidencias), !.


% Regla para encontrar la relación con el valor mayor
valorm(Relacion, Valor) :-
    enf(_, Valor),           % Verifica que exista al menos una relación
    findall(Val, enf(_, Val), Valores),  % Obtiene todos los valores de las relaciones
    max_list(Valores, Valor),         % Encuentra el valor máximo
    enf(Relacion, Valor).    % Obtiene la relación con el valor máximo



coincid([], _).
coincid([H|T], ListaEv) :-
    comparar_listas(H, ListaEv, C),
    assert(enf(H, C)),
    coincid(T, ListaEv).


deshacerenf :- retractall(enf(_,_)), retractall(res(_)),fail.
deshacerenf.



iniciar1 :-
    deshacerenf,
    % Crear lista con si
    enfermedades(Lista),
    listar(Lista1),
    coincid(Lista, Lista1),
    bvalor, !.


bvalor :-
    valorm(Relacion,Valor),
    resultado(Relacion,Valor).
    
    
porcentaje(Numero, Divisor, Resultado) :-
    Resultado is (Numero / Divisor) * 100.

%Sumar la longitud 
longitud([], 0).
longitud([_|T], L) :- longitud(T,L1), L is L1 + 1.

%En caso de que el valor sea diferete de 0
resultado(Relacion, Valor) :-
    write("Tienes riesgo de padecer "),
    write(Relacion),
    sintomas(Relacion,Sint),
    longitud(Sint,C),
    porcentaje(Valor, C, R),
    write(" en un "), write(R), write(" porciento"), !.

:- dynamic res/1.
% Valores, Predicado Lista Resultante
listar(Res) :- 
    findall(Sintoma, si(Sintoma), Sintomas),
    assert(res(Sintomas)), res(Res).



% Método para hacer preguntas y almacenar las respuestas
realizar_preguntas([]).
realizar_preguntas([Sintoma|Resto]) :-
    \+ (si(Sintoma); no(Sintoma)),  % Verificar si el síntoma ya ha sido preguntado
    write('El paciente presenta el siguiente sintoma o causa? '), write(Sintoma), write(' : '),
    read(Respuesta), nl,
    validar_respuestas([Sintoma|Resto], Respuesta),
    (
        Respuesta = 'si' -> assert(si(Sintoma)); % Si la respuesta es sí, almacenar si(Sintoma)
        Respuesta = 'no' -> assert(no(Sintoma))  % Si la respuesta es no, almacenar no(Sintoma)
    ),
    realizar_preguntas(Resto).

realizar_preguntas([_|Resto]) :-
    realizar_preguntas(Resto).  % Si el síntoma ya ha sido preguntado, pasar al siguiente

validar_respuestas(_, si) :- !.
validar_respuestas(_, no) :- !.
validar_respuestas([Sintoma|Resto], _) :-
    write('Por favor, responde con "si" o "no".'), nl,
    realizar_preguntas([Sintoma|Resto]).

% Método principal para realizar las preguntas con los síntomas de la lista de pruebas
realizar_pruebas :-
    preguntas(ListaSintomas),
    realizar_preguntas(ListaSintomas).
