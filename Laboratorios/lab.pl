  usa_equipo/2 estén separadas
:- discontiguous usa_equipo/2.

% laboratorio(Color, Científico, Especialidad, Equipo, Bebida).

laboratorio(amarillo, _, quimica, microscopio, _).
laboratorio(rojo, _, biologia, _, cafe).
laboratorio(azul, _, fisica, _, _).
laboratorio(naranja, _, matematicas, _, _).
laboratorio(verde, _, _, _, te).
laboratorio(negro, _, _, _, agua).

% Reglas de equipo
usa_equipo(quimico, espectrofotometro).
usa_equipo(_, centrifuga) :- laboratorio(amarillo, _, _, centrifuga, _).
usa_equipo(ciencias_computacion, laptop).
usa_equipo(_, osciloscopio).

% El primer laboratorio usa un microscopio.
primer_laboratorio(Color) :- laboratorio(Color, _, _, microscopio, _).

% Relaciones espaciales
derecha(verde, blanco).

% Relación de equipos junto a otros
junto(pipeta, fisico).
junto(balanza, espectrofotometro).

% Reglas de inferencia
trabaja_en(Cientifico, Especialidad) :-
    laboratorio(_, Cientifico, Especialidad, _, _).

usa_equipo(Cientifico, Equipo) :-
    laboratorio(_, Cientifico, _, Equipo, _).

bebe(Cientifico, Bebida) :-
    laboratorio(_, Cientifico, _, _, Bebida).

% Determinar en qué laboratorio trabaja el científico de Química
laboratorio_quimico(Color) :-
    laboratorio(Color, _, quimica, _, _).

% Determinar quién usa la pipeta
quien_usa_pipeta(Cientifico) :-
    usa_equipo(Cientifico, pipeta).

% Determinar la bebida preferida del científico que investiga en Matemáticas
bebida_matematicas(Bebida) :-
    trabaja_en(Cientifico, matematicas),
    bebe(Cientifico, Bebida).
