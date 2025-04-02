
%PROBLEMA 1.
% Guardianes de los templos.
guardian(apolo).
guardian(hecate).
guardian(ares).
guardian(hermes).

templo(fuego).
templo(aire).
templo(agua).
templo(tierra).
%----------
cuida(hermes, fuego).
cuida(hermes, agua).
cuida(hecate, fuego).
cuida(hecate, agua).
cuida(apolo, aire).
cuida(ares,tierra).
%-----
no_cuida(ares,agua).
no_cuida(ares,aire).
no_cuida(hecate, aire).
no_cuida(apolo, fuego).
no_cuida(apolo, tierra).

% Regla para responder qué templo cuida un guardián 
templos_cuidados(Guardian, Templo) :-
    cuida(Guardian, Templo).
