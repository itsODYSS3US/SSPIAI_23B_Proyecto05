enfermedad(asma) :- 
    sintoma('Tos'),
    sintoma('Problemas para dormir'),
    sintoma('Dolor de pecho'),
    sintoma('Falta de aire'),
    sintoma('Sibilancia').

enfermedad(neumonia) :-
    sintoma('Tos con flema'),
    sintoma('Fiebre'),
    sintoma('Escalofrios'),
    sintoma('Dificultad para respirar'),
    sintoma('Sudoracion'),
    sintoma('Perdida de apetito'),
    sintoma('Fatiga').

enfermedad(bronquitis) :-
    sintoma('Tos'),
    sintoma('Tos con flema'),
    sintoma('Dolor en pecho'),
    sintoma('Dolor de cabeza'),
    sintoma('Cansancio'),
    sintoma('Dolor de garganta').

enfermedad(bronquiolitis) :- 
    sintoma('Tos'),
    sintoma('Fiebre'),
    sintoma('Congestion nasal'),
    sintoma('Mucosidad'),
    sintoma('Sibilancia'),
    sintoma('Dificultad para respirar'),
    sintoma('Infeccion en el oido'),
    sintoma('Deshidratacion').

enfermedad(gripe) :-
    sintoma('Tos'),
    sintoma('Fiebre'),
    sintoma('Tos con flema'),
    sintoma('Congestion nasal'),
    sintoma('Dolor muscular'),
    sintoma('Dolor de cabeza'),
    sintoma('Dolor de garganta'),
    sintoma('Fatiga').

enfermedad(tuberculosis) :-
    sintoma('Tos con flema'),
    sintoma('Fiebre'),
    sintoma('Fatiga'),
    sintoma('Dolor en pecho'),
    sintoma('Tos intensa'),
    sintoma('Sudoracion').