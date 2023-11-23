:- dynamic enfermedades/2.
:- dynamic preg/2.

enfermedades(asma,[dolor_pecho,falta_aire,silibancia,probremas_dormir,tos]).
enfermedades(neumonia,[tos_flema,fiebre,escolofrios,difilcutad_respirar,sudoracion,perdida_apetido,fatiga]).
enfermedades(bronquitis,[tos,tos_flema,dolor_pecho,cansancio,dolor_cabeza,dolor_garganta]).
enfermedades(bronquiolitis,[mucosidad,cangestion_nasal,fiebre,tos,silibancia,difilcutad_respirar,infeccion_oido,deshidratacion]).
enfermedades(gripe,[fiebre,tos,tos_flema,dolor_garganta,congestion_nasal,dolor_muscular,dolor_cabeza,fatiga]).
enfermedades(tuberculosis,[tos_intensa,tos_flema,dolor_pecho,fatiga,escalofrios,fiebre,sudoracion]).


preg(1,"¿Tiene sintomas de tos?").
preg(2,"¿Presenta dificultades para respirar?").
preg(3,"¿Tiene fiebre?").
preg(4,"¿Tiene sibilancia?").
preg(5,"¿Tiene mucosidad en la nariz?").
preg(6,"¿Tiene deshidratacion?").
preg(7,"¿Presenta escalofrios?").
preg(8,"¿Presenta sudoracion?").
preg(9,"¿Tiene piel pegajosa?").
preg(10,"¿Presenta perdida de apetito?").
preg(11,"¿Ha presentado problemas para dormir?").
preg(12,"¿Ha sentido dolor u opresion en el pecho?").
preg(13,"¿Se ha sentido cansado?").
preg(14,"¿Presenta dolor de garganta?").
preg(15,"¿Tiene congestion nasal?").
preg(16,"¿Presenta dolor muscular?").
preg(17,"¿Ha presentado dolores de cabeza?").

% mensaje(Num) :- preg(Num, Preg), write(Preg).