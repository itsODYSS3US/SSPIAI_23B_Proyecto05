preguntas(['Tos seca', 'Tos con flema', 
            'Fiebre', 'Sibilancia', 'Congestion nasal', 
            'Dolor de pecho', 'Dolor de cabeza',
            'Fatiga', 'Dificultad para respirar','Sudoracion']).

enfermedad(asma) :- 
    sintoma_causa('Tos seca'),
    sintoma_causa('Dolor de pecho'),
    sintoma_causa('Dificultad para respirar'),
    sintoma_causa('Sibilancia'),
    sintoma_causa('Problemas para dormir').

enfermedad(neumonia) :-
    sintoma_causa('Tos con flema'),
    sintoma_causa('Fiebre'),
    sintoma_causa('Fatiga'),
    sintoma_causa('Dificultad para respirar'),
    sintoma_causa('Sudoracion'),
    sintoma_causa('Perdida de apetito'),
    sintoma_causa('Escalofrios').

enfermedad(bronquitis) :-
    sintoma_causa('Tos seca'),
    sintoma_causa('Tos con flema'),
    sintoma_causa('Dolor de pecho'),
    sintoma_causa('Dolor de cabeza'),
    sintoma_causa('Cansancio'),
    sintoma_causa('Dolor de garganta').

enfermedad(bronquiolitis) :- 
    sintoma_causa('Tos seca'),
    sintoma_causa('Fiebre'),
    sintoma_causa('Congestion nasal'),
    sintoma_causa('Mucosidad'),
    sintoma_causa('Sibilancia'),
    sintoma_causa('Dificultad para respirar'),
    sintoma_causa('Infeccion en el oido'),
    sintoma_causa('Deshidratacion').

enfermedad(gripe) :-
    sintoma_causa('Tos seca'),
    sintoma_causa('Tos con flema'),
    sintoma_causa('Fiebre'),
    sintoma_causa('Fatiga'),
    sintoma_causa('Congestion nasal'),
    sintoma_causa('Dolor muscular'),
    sintoma_causa('Dolor de cabeza'),
    sintoma_causa('Dolor de garganta').

enfermedad(tuberculosis) :-
    sintoma_causa('Tos con flema'),
    sintoma_causa('Fiebre'),
    sintoma_causa('Fatiga'),
    sintoma_causa('Dolor en pecho'),
    sintoma_causa('Tos intensa'),
    sintoma_causa('Sudoracion').

