% Punto de entrada principal
eliza :-
    writeln('Hola, soy Eliza, tu chatbot.'),
    writeln('Por favor, escribe tu consulta usando solo minusculas y sin punto final:'),
    leer_input(Input),
    eliza(Input), !.

% Caso para salir
eliza(['adios']) :-
    writeln('Adios. Espero haber sido de ayuda.'), !.

% Caso general: buscar template
eliza(Input) :-
    template(Stim, Resp, Indices),
    match(Stim, Input),
    replace0(Indices, Input, 0, Resp, RespuestaFinal),
    writeln_lista(RespuestaFinal),
    leer_input(NuevaEntrada),
    eliza(NuevaEntrada), !.

% Leer linea y convertirla en lista de atomos
leer_input(Input) :-
    read_line_to_codes(user_input, Codes),
    string_codes(String, Codes),
    split_string(String, " ", "", Lista),
    maplist(string_lower, Lista, Lower),
    maplist(atom_string, Input, Lower).

% Escribir lista 
writeln_lista([]) :- nl.
writeln_lista([H|T]) :-
    write(H), write(' '),
    writeln_lista(T).

% Coincidencia 
match([], []).
match([], _) :- true.
match([S|Stim], [I|Input]) :-
    atom(S),
    S == I,
    match(Stim, Input), !.
match([s(_)|Stim], [_|Input]) :-
    match(Stim, Input), !.

% Plantillas
template([hola, mi, nombre, es, s(_), '.'], ['Hola', 0, 'como estas?'], [4]).
template([me, gusta, s(_), '.'], ['Por que te gusta', 0, '?'], [2]).
template([yo, soy, s(_), '.'], ['Por que eres', 0, '?'], [2]).
template([tu, eres, s(_), '.'], [flagIs], [2]).
template([que, eres, tu, '.'], [flagIs], [2]).
template([te, gustan, las, s(_), '.'], [flagLike], [3]).
template([te, gustan, los, s(_), '.'], [flagLike], [3]).
template([tu, haces, s(_), '.'], [flagDo], [2]).
template([porque, s(_), '.'], ['Esa no es una razon valida.'], []).
template([como, estas, tu, '.'], ['Estoy bien, gracias por preguntar.'], []).
template([pienso, que, s(_), '.'], ['Bueno, esa es tu opinion.'], []).
template(_, ['No estoy segura de como responder a eso. Puedes explicarlo mejor?'], []).

% Gustos de Eliza
elizaLikes(X, R) :- likes(X), R = ['Si, me gustan los', X].
elizaLikes(X, R) :- \+likes(X), R = ['No, no me gustan los', X].

likes(apples).
likes(manzanas).
likes(gatos).
likes(libros).
likes(musica).
likes(ponies).
likes(zombies).
likes(ciencia).

elizaDoes(X, R) :- does(X), R = ['Si, yo', X, 'y me encanta hacerlo.'].
elizaDoes(X, R) :- \+does(X), R = ['No, no', X, 'muy seguido.'].

does(estudio).
does(programo).
does(pinto).
does(cocino).
does(canto).

elizaIs(X, R) :- is0(X), R = ['Si, soy', X].
elizaIs(X, R) :- \+is0(X), R = ['No, no soy', X].

is0(amable).
is0(robot).
is0(lista).
is0(curiosa).

replace0([], _, _, Resp, Resp) :- !.

replace0([I|_], Input, _, [flagLike], R) :-
    nth0(I, Input, Atom),
    elizaLikes(Atom, R).

replace0([I|_], Input, _, [flagDo], R) :-
    nth0(I, Input, Atom),
    elizaDoes(Atom, R).

replace0([I|_], Input, _, [flagIs], R) :-
    nth0(I, Input, Atom),
    elizaIs(Atom, R).

replace0([I|Index], Input, N, Resp, R) :-
    nth0(I, Input, Atom),
    select(N, Resp, Atom, RespParcial),
    N1 is N + 1,
    replace0(Index, Input, N1, RespParcial, R).
