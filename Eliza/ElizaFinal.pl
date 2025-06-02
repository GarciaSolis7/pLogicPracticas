% ---------------------------------------------
% PROYECTO FINAL: Eliza - Version Corregida Definitiva
% ---------------------------------------------

% Declaraciones iniciales
:- discontiguous hombre/1, mujer/1, padre/1, madre/1.
:- discontiguous padre_de/2, madre_de/2, hermano_de/2, hermana_de/2.
:- discontiguous pareja/2, hijo/1, hija/1, hermano/1, hermana/1.
:- discontiguous primo/1, prima/1, tio/1, tia/1, sobrino/1, sobrina/1.
:- discontiguous nieto/1, nieta/1, primo_de/2, prima_de/2, tio_de/2,
tia_de/2.
:- discontiguous nieto_de/2, nieta_de/2, sobrino_de/2, sobrina_de/2.

:- dynamic primo_de/2, prima_de/2, sobrino_de/2, sobrina_de/2.
:- dynamic tio_de/2, tia_de/2, nieto_de/2, nieta_de/2.

% ----------------------------
% ARBOL GENEALOGICO
% ----------------------------

% Generacion 1
hombre(carlos).
mujer(sofia).
pareja(carlos, sofia).

hombre(juan).
mujer(laura).

padre_de(carlos, juan).
padre_de(carlos, laura).
madre_de(sofia, juan).
madre_de(sofia, laura).

hermano_de(juan, laura).
hermana_de(laura, juan).

% Generacion 2
mujer(maria).
hombre(javier).
mujer(marta).

padre_de(juan, javier).
padre_de(juan, marta).
madre_de(maria, javier).
madre_de(maria, marta).
pareja(juan, maria).

hombre(jorge).
hombre(jose).
mujer(lucia).

padre_de(jorge, jose).
padre_de(jorge, lucia).
madre_de(laura, jose).
madre_de(laura, lucia).
pareja(jorge, laura).

% Otras Relaciones (mantener solo si se desean como hechos directos y no inferidos)
primo_de(jose, javier).
primo_de(jose, marta).
prima_de(lucia, javier).
prima_de(lucia, marta).

sobrino_de(jose, juan).
sobrino_de(jose, maria).
sobrina_de(lucia, juan).
sobrina_de(lucia, maria).

sobrino_de(javier, jorge).
sobrino_de(javier, laura).
sobrina_de(marta, jorge).
sobrina_de(marta, laura).

tio_de(juan, jose).
tio_de(juan, lucia).
tio_de(jorge, javier).
tio_de(jorge, marta).

tia_de(laura, javier).
tia_de(laura, marta).
tia_de(maria, jose).
tia_de(maria, lucia).

nieto_de(javier, carlos).
nieto_de(javier, sofia).
nieto_de(jose, carlos).
nieto_de(jose, sofia).

nieta_de(marta, carlos).
nieta_de(marta, sofia).
nieta_de(lucia, carlos).
nieta_de(lucia, sofia).

% ----------------------------
% REGLAS FAMILIARES
% ----------------------------

% 1. Relaciones basicas
es_padre(X, Y) :- padre_de(X, Y).
es_madre(X, Y) :- madre_de(X, Y).

es_hijo(X, Y) :- (padre_de(Y, X) ; madre_de(Y, X)), hombre(X).
es_hija(X, Y) :- (padre_de(Y, X) ; madre_de(Y, X)), mujer(X).

% 2. Hermanos/hermanas
es_hermano(X, Y) :-
    (padre_de(P, X), padre_de(P, Y) ; madre_de(M, X), madre_de(M, Y)),
    X \= Y, hombre(X).

es_hermana(X, Y) :-
    (padre_de(P, X), padre_de(P, Y) ; madre_de(M, X), madre_de(M, Y)),
    X \= Y, mujer(X).

% 3. Abuelos/abuelas
es_abuelo(X, Y) :-
    (padre_de(X, Z) ; madre_de(X, Z)),
    (padre_de(Z, Y) ; madre_de(Z, Y)),
    hombre(X).

es_abuela(X, Y) :-
    (padre_de(X, Z) ; madre_de(X, Z)),
    (padre_de(Z, Y) ; madre_de(Z, Y)),
    mujer(X).

% 4. Tios/tias
es_tio(X, Y) :-
    hombre(X),
    (
        (es_hermano(X, P_parent), (padre_de(P_parent, Y) ; madre_de(P_parent, Y)))
        ;
        (es_pareja(X, T), mujer(T), es_hermana(T, P_parent_spouse), (padre_de(P_parent_spouse, Y) ; madre_de(P_parent_spouse, Y)))
    ).

es_tia(X, Y) :-
    mujer(X),
    (
        (es_hermana(X, P_parent), (padre_de(P_parent, Y) ; madre_de(P_parent, Y)))
        ;
        (es_pareja(X, T), hombre(T), es_hermano(T, P_parent_spouse), (padre_de(P_parent_spouse, Y) ; madre_de(P_parent_spouse, Y)))
    ).

% 5. Primos/primas
es_primo(X, Y) :-
    hombre(X),
    X \= Y,
    (
        (es_padre(P1, X), es_padre(P2, Y), (es_hermano(P1, P2) ; es_hermana(P1, P2)))
        ;
        (es_madre(M1, X), es_madre(M2, Y), (es_hermano(M1, M2) ; es_hermana(M1, M2)))
    ).

es_prima(X, Y) :-
    mujer(X),
    X \= Y,
    (
        (es_padre(P1, X), es_padre(P2, Y), (es_hermano(P1, P2) ; es_hermana(P1, P2)))
        ;
        (es_madre(M1, X), es_madre(M2, Y), (es_hermano(M1, M2) ; es_hermana(M1, M2)))
    ).

% 6. Sobrinos/sobrinas
es_sobrino(X, Y) :-
    hombre(X),
    (es_hijo(X, P), (es_hermano(P, Y) ; es_hermana(P, Y))).

es_sobrina(X, Y) :-
    mujer(X),
    (es_hija(X, P), (es_hermano(P, Y) ; es_hermana(P, Y))).

% 7. Nietos/nietas
es_nieto(X, Y) :-
    hombre(X),
    (es_hijo(X, Z) ; es_hija(X, Z)),
    (es_padre(Y, Z) ; es_madre(Y, Z)).

es_nieta(X, Y) :-
    mujer(X),
    (es_hijo(X, Z) ; es_hija(X, Z)),
    (es_padre(Y, Z) ; es_madre(Y, Z)).

% 8. Pareja/conyuge
es_pareja(X, Y) :- pareja(X, Y) ; pareja(Y, X).

% ----------------------------
% ENFERMEDADES (Tos Ferina y Tetano)
% ----------------------------

% Sintomas
sintoma(tos_seca). sintoma(tos_convulsiva). sintoma(estornudos).
sintoma(fiebre_moderada). sintoma(fiebre_alta). sintoma(apnea).
sintoma(vomitos). sintoma(cansancio_extremo). sintoma(cianosis).
sintoma(convulsiones). sintoma(espasmos_musculares).
sintoma(rigidez_muscular). sintoma(dificultad_tragar).
sintoma(trismo). sintoma(risa_sardonica). sintoma(opistotonos).
sintoma(sudoracion_excesiva). sintoma(taquicardia).
sintoma(hipertension). sintoma(irritabilidad).
sintoma(herida_contaminada). sintoma(contracturas).
sintoma(dificultad_respirar). sintoma(estridor).
sintoma(babeo). sintoma(fiebre_ligera). sintoma(escalofrios).

% Causas
causa(tos_ferina, bacteria_bordetella_pertussis).
causa(tos_ferina, contagio_aereo).
causa(tos_ferina, contacto_estrecho).
causa(tos_ferina, sistema_inmune_debil).
causa(tos_ferina, no_vacunacion).

causa(tetanos, bacteria_clostridium_tetani).
causa(tetanos, herida_contaminada).
causa(tetanos, quemaduras_infectadas).
causa(tetanos, ulceras_cronicas).
causa(tetanos, cirugia_contaminada).
causa(tetanos, objetos_oxidados).
causa(tetanos, no_vacunacion).
causa(tetanos, parto_antihigienico).

% Sintomas por enfermedad
sintomas(tos_ferina, [
    tos_seca, tos_convulsiva, estornudos, fiebre_moderada,
    apnea, vomitos, cansancio_extremo, cianosis,
    dificultad_respirar, estridor, fiebre_ligera
]).

sintomas(tetanos, [
    espasmos_musculares, rigidez_muscular, dificultad_tragar,
    trismo, risa_sardonica, opistotonos, sudoracion_excesiva,
    taquicardia, hipertension, irritabilidad, herida_contaminada,
    contracturas, babeo, fiebre_alta, escalofrios
]).

% Reglas de diagnostico
diagnostico(Sintomas, Enfermedad) :-
    sintomas(Enfermedad, ListaSintomas),
    subset(Sintomas, ListaSintomas),
    length(Sintomas, Cantidad),
    Cantidad >= 2. % At least 2 matching symptoms for a diagnosis

% ----------------------------
% Eliza - Sistema Principal
% ----------------------------

% Inicio del sistema
eliza :-
    writeln('Hola, soy Eliza, tu asistente familiar y medico.'),
    writeln('Puedes:'),
    writeln('- Consultar relaciones familiares (ej: "juan es tio de javier?")'),
    writeln('- Describir sintomas (ej: "tengo tos seca y fiebre")'),
    writeln('- Preguntar sobre enfermedades (ej: "que causa el tetanos?")'),
    writeln('Escribe "adios" para terminar.'),
    leer_input(Input),
    procesar_input(Input).

% Procesamiento principal
procesar_input(['adios']) :- writeln('Adios. Espero haberte ayudado.'), !.
procesar_input(Input) :-
    % Intentar procesar la entrada con los diferentes manejadores
    (consultar_relacion(Input)
    ; consultar_diagnostico(Input)
    ; consultar_enfermedad(Input)
    ; (writeln('No entendi tu pregunta. Puedes reformularla?'), fail) % Si todo falla, pedir y fallar para permitir la siguiente cláusula
    ),
    !, % Cortar para comprometerse con la rama elegida si tiene exito
    leer_input(NuevaEntrada),
    procesar_input(NuevaEntrada).
% Retorno si la disyunción anterior falla (no debería ser alcanzado con 'fail' en la última rama)
procesar_input(_) :-
    writeln('Hubo un problema procesando tu solicitud. Intentemos de nuevo.'),
    leer_input(NuevaEntrada),
    procesar_input(NuevaEntrada).

% Lectura de entrada: Converts a line of text to a list of atoms
leer_input(Input) :-
    read_line_to_string(user_input, String),
    string_lower(String, LowerString),
    % Reemplazar 'y' por un espacio para que extract_sintomas pueda separar bien los síntomas
    string_replace(LowerString, " y ", " ", ProcessedString),
    split_string(ProcessedString, " ", "", Lista),
    maplist(atom_string, Input, Lista).

% ----------------------------
% CONSULTAS FAMILIARES
% ----------------------------

% match(+Pattern, +InputList, -ExtractedVars)
% Pattern: List of atoms or s(Variable) for elements to extract.
% InputList: The list of atoms from user input.
% ExtractedVars: A list of atoms extracted from the input corresponding to s(Variable) in Pattern.
match([], [], []).
% If pattern has s(Var), unify Var with Atom and add Atom to ExtractedVars
match([s(Var)|PatternT], [Atom|InputT], [Atom|ExtractedVars]) :-
    Var = Atom, % Explicitly unify Var with Atom
    match(PatternT, InputT, ExtractedVars).
% If pattern and input match literally, continue
match([H|PatternT], [H|InputT], ExtractedVars) :-
    match(PatternT, InputT, ExtractedVars).

% Helper predicate for family queries (more generic matching)
% Captures two names regardless of the specific relation word.
handle_family_query(Input, RelationWord, RelationPredicate) :-
    atom_string(RelationAtom, RelationWord),
    ( (member(es, Input), member(de, Input), % Check for "es" and "de"
       match([s(A), es, RelationAtom, de, s(B)], Input, [A_atom, B_atom]))
    ; (member(es, Input), not(member(de, Input)), % Allow "X es Y" (e.g., "carlos es sofia")
       match([s(A), es, s(B)], Input, [A_atom, B_atom]),
       % Ensure B is not a relation word itself, but potentially a person for "pareja"
       (RelationAtom \= B_atom -> true ; (RelationAtom = pareja, es_pareja(A_atom, B_atom)))) % Special case for 'pareja'
    ),
    (call(RelationPredicate, A_atom, B_atom) ->
        Resp = ['Si,', A_atom, 'es', RelationAtom, 'de', B_atom]
    ;
        Resp = ['No,', A_atom, 'no es', RelationAtom, 'de', B_atom]
    ),
    writeln_lista(Resp),
    !.

consultar_relacion(Input) :- handle_family_query(Input, 'padre', es_padre).
consultar_relacion(Input) :- handle_family_query(Input, 'madre', es_madre).
consultar_relacion(Input) :- handle_family_query(Input, 'hijo', es_hijo).
consultar_relacion(Input) :- handle_family_query(Input, 'hija', es_hija).
consultar_relacion(Input) :- handle_family_query(Input, 'tio', es_tio).
consultar_relacion(Input) :- handle_family_query(Input, 'tia', es_tia).
consultar_relacion(Input) :- handle_family_query(Input, 'abuelo', es_abuelo).
consultar_relacion(Input) :- handle_family_query(Input, 'abuela', es_abuela).
consultar_relacion(Input) :- handle_family_query(Input, 'primo', es_primo).
consultar_relacion(Input) :- handle_family_query(Input, 'prima', es_prima).
consultar_relacion(Input) :- handle_family_query(Input, 'sobrino', es_sobrino).
consultar_relacion(Input) :- handle_family_query(Input, 'sobrina', es_sobrina).
consultar_relacion(Input) :- handle_family_query(Input, 'nieto', es_nieto).
consultar_relacion(Input) :- handle_family_query(Input, 'nieta', es_nieta).
consultar_relacion(Input) :- handle_family_query(Input, 'pareja', es_pareja). % Added for explicit pareja queries
consultar_relacion(_). % If no family relation matches, this clause succeeds silently.


% ----------------------------
% CONSULTAS MEDICAS
% ----------------------------

% extract_sintomas(+InputList, -SintomasExtracted)
% Extracts symptoms from the input list, recognizing potential "y" as a separator.
extract_sintomas(InputList, SintomasExtracted) :-
    findall(Sintoma,
        (member(Word, InputList), sintoma(Word)),
        SintomasExtracted
    ).

consultar_diagnostico(Input) :-
    % Use `member(tengo, Input)` as a strong indicator for a symptom query
    member(tengo, Input),
    extract_sintomas(Input, Sintomas),
    Sintomas \= [], % Ensure at least one symptom was extracted
    (diagnostico(Sintomas, Enfermedad) ->
        writeln_lista(['Según tus sintomas, podrias tener:', Enfermedad, '.', 'Debes consultar a un medico.'])
    ;
        writeln('No reconozco una enfermedad con esos sintomas. Podrias describirlos mejor.')
    ),
    !. % Add cut to commit to this path if "tengo" is present.

consultar_enfermedad(Input) :-
    % Handle "que causa el/la [enfermedad]"
    ( (match([que, causa, el, s(Enf)], Input, [Enf_atom]) ;
       match([que, causa, la, s(Enf)], Input, [Enf_atom])) ->
        (findall(C, causa(Enf_atom, C), Causas),
        (Causas \= [] -> writeln_lista(['Las causas de', Enf_atom, 'son:', Causas]) ;
         writeln(['No tengo informacion sobre las causas de', Enf_atom])))
    ;
    % Handle "sintomas de el/la [enfermedad]"
    ( (match([sintomas, de, el, s(Enf)], Input, [Enf_atom]) ;
       match([sintomas, de, la, s(Enf)], Input, [Enf_atom])) ->
        (sintomas(Enf_atom, SintomasList) ->
            writeln_lista(['Los sintomas de', Enf_atom, 'son:', SintomasList]) ;
            writeln(['No tengo informacion sobre los sintomas de', Enf_atom]))
    ;
    fail % If neither cause nor symptom query matches within this predicate
    )),
    !. % Add cut here to commit to this successful branch.


% ----------------------------
% UTILIDADES
% ----------------------------

% Replaces occurrences of a substring in a string.
string_replace(String, Old, New, Result) :-
    atomic_list_concat(List, Old, String),
    atomic_list_concat(List, New, Result).

% Prints a list of atoms, separated by spaces, ending with a newline.
writeln_lista([]) :- nl.
writeln_lista([H|T]) :- write(H), write(' '), writeln_lista(T).
