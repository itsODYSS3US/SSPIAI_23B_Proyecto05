bc :- consult('enfermedades.pl').

%Menú
inicio :- nl,
    write('---Menu---'), nl, 
    write('1. Listar'), nl, 
    write('2. Buscar'), nl, 
    write('3. Agregar'), nl, 
    write('4. Longitud'), nl, 
    write('5. Ordenar'), nl, 
    write('6. Eliminar'), nl, 
    write('7. Concatenar'), nl, 
    write('8. Salir'), nl, 
    write('Ingresa una opcion (1-8)'), nl, 
    read(Op), opcion(Op), !.


opcion(1) :- lista2, inicio. 
opcion(2) :- buscar, inicio. 
opcion(3) :- agregar, inicio. 
opcion(4) :- contar_elementos, inicio. 
opcion(5) :- ordenar, inicio. 
opcion(6) :- eliminar, inicio. 
opcion(7) :- concatenar, inicio. 
opcion(8) :- write('Fin de programa...'), !.
opcion(_) :- write('Revisa que el numero ingresado corresponda a una opcion (1-8) '), inicio. 


% preg1 :- write('¿Tiene sintomas de tos?') read(Op), preg1(Op).
% preg2 :- write('¿?') read(Op), preg1(Op).
% preg3 :- write('') read(Op), preg1(Op).
% preg4 :- write('') read(Op), preg1(Op).
% preg5 :- write('') read(Op), preg1(Op).
% preg6 :- write('') read(Op), preg1(Op).
% preg7 :- write('') read(Op), preg1(Op).
% preg8 :- write('') read(Op), preg1(Op).
% preg9 :- write('') read(Op), preg1(Op).
% preg10 :- write('') read(Op), preg1(Op).
% preg11 :- write('') read(Op), preg1(Op).
% preg12 :- write('') read(Op), preg1(Op).
% preg13 :- write('') read(Op), preg1(Op).
% preg14 :- write('') read(Op), preg1(Op).
% preg15 :- write('') read(Op), preg1(Op).
% preg16 :- write('') read(Op), preg1(Op).
% preg17 :- write('') read(Op), preg1(Op).
% preg18 :- write('') read(Op), preg1(Op).
% preg19 :- write('') read(Op), preg1(Op).
% preg20 :- write('') read(Op), preg1(Op).
% preg21 :- write('') read(Op), preg1(Op).
% preg22 :- write('') read(Op), preg1(Op).
% preg23 :- write('') read(Op), preg1(Op).
% preg24 :- write('') read(Op), preg1(Op).
% preg25 :- write('') read(Op), preg1(Op).
% preg26 :- write('') read(Op), preg1(Op).
% preg27 :- write('') read(Op), preg1(Op).
% preg28 :- write('') read(Op), preg1(Op).



%Listar
listar :- write('Que lista va a mostrar (volador, acuatico, domestico, venenoso, nocturno): '),
    nl, read(Tipo), animales(Tipo,Lista), imprimir(Lista).

imprimir([]).
imprimir([H|T]) :- write('- '), write(H), nl,
    imprimir(T).


%Buscar
buscar1(X,[_|T]) :- buscar1(X,T). 
buscar1(H,[H|_]).

buscar :- write('Que elemento desea buscar?: '),
    nl, read(Elemento), 
    write('En que lista se encuentra dicho elemento (volador, acuatico, domestico, venenoso, nocturno)?: '),
    nl, read(Tipo), buscar(Elemento,Tipo).

buscar(Elemento,Tipo) :- animales(Tipo,Lista), buscar1(Elemento,Lista), write('El elemento si se encuentra en la lista'), nl.
buscar(Elemento,Tipo) :- animales(Tipo,Lista), \+buscar1(Elemento,Lista),
    write('El elemento no se encuentra en la lista'), nl,
    write('Quiere agregar el elemento a esa lista? Si(s), No(n): '), nl, 
    read(Op), opc(Op,Elemento,Tipo).

opc(s,Elemento,Tipo) :- agregar(Elemento,Tipo).
opc(n,_,_) :- !.

%Agregar
guardar :- tell('listas.pl'), listing(animales/2), told.
insertar(E,L,Lr) :- Lr = [E|L].

agregar :- write('Ingrese el elemento que desea agregar?: '),
    nl, read(Elemento), 
    write('En que lista se va a agregar? (volador, acuatico, domestico, venenoso, nocturno): '),
    nl, read(Tipo), agregar(Elemento,Tipo).

agregar(Elemento,Tipo) :- animales(Tipo,Lista),
    \+buscar1(Elemento,Lista),
    insertar(Elemento,Lista,Lr),
    retract(animales(Tipo,Lista)),
    assertz(animales(Tipo,Lr)), 
    guardar, write('La base de conocimientos ha sido actualizada...'), nl.

agregar(Elemento,Tipo) :- animales(Tipo,Lista),
    buscar1(Elemento,Lista),
    write('El elemento que desea agregar ya se encuentra en la lista'), nl.

%Longitud listo
longitud([], 0).
longitud([_|T], L) :- longitud(T,L1), L is L1 + 1.

contar_elementos :- write('Ingrese el tipo de la lista: (volador, acuatico, domestico, venenoso, nocturno) '), 
    nl, read(Tipo), contar_elementos(Tipo,Cant), write('Los elementos en la lista '), write(Tipo), write(' son: '), write(Cant). 

contar_elementos(Tipo,Cant) :-
    animales(Tipo,Lista),
    longitud(Lista,Cant).

%Ordenamiento listo - listar
ordenar :- write('Ingresa el tipo que desea ordenar: (volador, acuatico, domestico, venenoso, nocturno) '),
    nl, read(Tipo), ordenar(Tipo, Lr), write('La lista ordenada es la siguiente: '), nl, imprimir(Lr).

ordenar(Tipo, Lr) :- animales(Tipo,Lista), msort(Lista, Lr).

%Eliminar listo
eliminar1(R, [R|T], T) :- !.
eliminar1(R, [H|T], [H|T2]) :- H \= R, eliminar1(R, T, T2).

eliminar :- write('Que elemento desea eliminar?: '),
    nl, read(Elemento), 
    write('En que lista se encuentra dicho elemento?: (volador, acuatico, domestico, venenoso, nocturno) '),
    nl, read(Tipo), eliminar(Elemento,Tipo).

eliminar(Elemento, Tipo) :- animales(Tipo,Lista), 
    buscar1(Elemento,Lista),
    eliminar1(Elemento, Lista, T), 
    retract(animales(Tipo,Lista)),
    assertz(animales(Tipo,T)), 
    guardar, write('El elemento ha sido eliminado...'), nl.

eliminar(Elemento, Tipo) :- animales(Tipo,Lista), 
    \+buscar1(Elemento,Lista),
    write('El elemento que desea eliminar no se encuentra en la lista'), nl.

%Concatenar 2 listas
concatenar1([], L, L).
concatenar1([H|T], L, [H|Result]) :- concatenar1(T, L, Result).

concatenar :- write('Que lista desea concatenar: (volador, acuatico, domestico, venenoso, nocturno) '),
    nl, read(Tipo1),
    write('Con que lista se va a concatenar: (volador, acuatico, domestico, venenoso, nocturno) '),
    nl, read(Tipo2), concatenar(Tipo1,Tipo2).

concatenar(Tipo1,Tipo2) :- animales(Tipo1,Lista1), animales(Tipo2,Lista2),
    concatenar1(Lista1,Lista2,Lr), imprimir(Lr).