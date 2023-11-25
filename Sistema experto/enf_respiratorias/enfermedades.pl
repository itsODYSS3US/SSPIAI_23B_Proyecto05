

% sintomas(asma,[dolor_pecho,falta_aire,silibancia,probremas_dormir,tos]).
% sintomas(neumonia,[tos_flema,fiebre,escolofrios,difilcutad_respirar,sudoracion,perdida_apetido,fatiga]).
% sintomas(bronquitis,[tos,tos_flema,dolor_pecho,cansancio,dolor_cabeza,dolor_garganta]).
% sintomas(bronquiolitis,[mucosidad,cangestion_nasal,fiebre,tos,silibancia,difilcutad_respirar,infeccion_oido,deshidratacion]).
% sintomas(gripe,[fiebre,tos,tos_flema,dolor_garganta,congestion_nasal,dolor_muscular,dolor_cabeza,fatiga]).
% sintomas(tuberculosis,[tos_intensa,tos_flema,dolor_pecho,fatiga,escalofrios,fiebre,sudoracion]).

% preg(1,"Tiene sintomas de tos?").
% preg(2,"Presenta dificultades para respirar?").
% preg(3,"¿Tiene fiebre?").
% preg(4,"¿Tiene sibilancia?").
% preg(5,"Tiene mucosidad en la nariz?").
% preg(6,"¿Tiene deshidratacion?").
% preg(7,"¿Presenta escalofrios?").
% preg(8,"¿Presenta sudoracion?").
% preg(9,"¿Tiene piel pegajosa?").
% preg(10,"¿Presenta perdida de apetito?").
% preg(11,"¿Ha presentado problemas para dormir?").
% preg(12,"¿Ha sentido dolor u opresion en el pecho?").
% preg(13,"¿Se ha sentido cansado?").
% preg(14,"¿Presenta dolor de garganta?").
% preg(15,"¿Tiene congestion nasal?").
% preg(16,"¿Presenta dolor muscular?").
% preg(17,"¿Ha presentado dolores de cabeza?").

% mensaje(Num) :- preg(Num, Preg), write(Preg).

% sintoma(fiebre).
% sintoma(tos).
% sintoma(dolor_garganta).
% sintoma(congestion_nasal).

% enfermedad(X, asma) :- 
%     sintima(fiebre), sintoma(congestion_nasal), sintoma(tos).

% preguntar([], _).
% preguntar([tos], Enfermedad) :- 
%     write('¿El paciente tiene '), write(Sintoma), write('?  (si/no)'),
%     read(Repuesta),
%     (Respuesta == si ->
%         preguntar(Otros, Enfermedad) ;
%         preguntar(Otros, Enfermedad)
%     ).

% diagnosticar(Enfermedad) :- enfermedades(Enfermedad,Sintomas),
%     preguntar(Sintomas, Enfermedad).

asma :- 
    sintoma('Tos'),
    sintoma('Problemas para dormir'),
    sintoma('Dolor de pecho'),
    sintoma('Falta de aire'),
    sintoma('Silibacia').

neumonia :-
    sintoma('Tos con flema'),
    sintoma('Fiebre'),
    sintoma('Escalofrios'),
    sintoma('Dificulta para respirar'),
    sintoma('Sudoracion'),
    sintoma('Perdida de apetito'),
    sintoma('Fatiga').

bronquitis :-
    sintoma('Tos'),
    sintoma('Tos con flema'),
    sintoma('Dolor en pecho'),
    sintoma('Dolor de cabeza'),
    sintoma('Cansancio'),
    sintoma('Dolor de garganta').

bronquiolitis :- 
    sintoma('Tos'),
    sintoma('Fiebre'),
    sintoma('Congestion nasal'),
    sintoma('Mucosidad'),
    sintoma('Silibancia'),
    sintoma('Dificultad para respirar'),
    sintoma('Infeccion en el oido'),
    sintoma('Deshidratacion').

gripe :-
    sintoma('Tos'),
    sintoma('Fiebre'),
    sintoma('Tos con flema'),
    sintoma('Congestion nasal'),
    sintoma('Dolor muscular'),
    sintoma('Dolor de cabeza'),
    sintoma('Dolor de garganta'),
    sintoma('Fatiga').

tuberculosis :-
    sintoma('Tos con flema'),
    sintoma('Fiebre'),
    sintoma('Fatiga'),
    sintoma('Dolor en pecho'),
    sintoma('Tos intensa'),
    sintoma('Escalofrios'),
    sintoma('Sudoracion').