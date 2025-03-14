% Declaraciones para evitar advertencias
:- discontiguous hombre/1, mujer/1, padre/1, madre/1.
:- discontiguous padre_de/2, madre_de/2, hermano_de/2, hermana_de/2.
:- discontiguous pareja/2, hijo/1, hija/1, hermano/1, hermana/1.
:- discontiguous primo/1, prima/1, tio/1, tia/1, sobrino/1, sobrina/1.
:- discontiguous nieto/1, nieta/1, primo_de/2, prima_de/2, tio_de/2, tia_de/2.
:- discontiguous nieto_de/2, nieta_de/2, sobrino_de/2, sobrina_de/2.

% Permitir definiciones en múltiples archivos
:- dynamic primo_de/2, prima_de/2, sobrino_de/2, sobrina_de/2.
:- dynamic tio_de/2, tia_de/2, nieto_de/2, nieta_de/2.

%----- GEN 1
hombre(carlos).
mujer(sofia).

hombre(juan).
mujer(laura).

hijo(juan).
hija(laura).
hermano_de(juan, laura).
hermana_de(laura, juan).

padre_de(carlos, juan).
padre_de(carlos, laura).
madre_de(sofia, juan).
madre_de(sofia, laura).

pareja(carlos, sofia).

%----------------------------------------
%----- GEN 2
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

% Otras relaciones
primo_de(jose, javier).
primo_de(jose, marta).
prima_de(lucia, javier).
prima_de(lucia, marta).

primo_de(javier, jose).
primo_de(javier, lucia).
prima_de(marta, jose).
prima_de(marta, lucia).

sobrina_de(lucia, maria).
sobrina_de(lucia, juan).
sobrino_de(jose, juan).
sobrino_de(jose, maria).

sobrina_de(marta, laura).
sobrina_de(marta, jorge).
sobrino_de(javier, laura).
sobrino_de(javier, jorge).

tia_de(laura, marta).
tia_de(laura, javier).
tia_de(maria, jose).
tia_de(maria, lucia).

tio_de(jorge, javier).
tio_de(jorge, marta).
tio_de(juan, lucia).
tio_de(juan, jose).

nieta_de(marta, carlos).
nieta_de(marta, sofia).
nieta_de(lucia, carlos).
nieta_de(lucia, sofia).
nieto_de(javier, carlos).
nieto_de(javier, sofia).
nieto_de(jose, carlos).
nieto_de(jose, sofia).

%-------------------------------------------------
% REGLAS 
%-------------------------------------------------


% 1. Regla para saber si son hermanos/hermanas $
es_hermano(X, Y) :- 
    padre_de(P, X), padre_de(P, Y), 
    madre_de(M, X), madre_de(M, Y), 
    X \= Y.
es_hermano(X, Y) :- 
    padre_de(P, X), padre_de(P, Y), 
    X \= Y.
es_hermano(X, Y) :- 
    madre_de(M, X), madre_de(M, Y), 
    X \= Y.

% 2. Regla para saber si es abuelo o abuela $
es_abuelo(X, Y) :- 
    padre_de(X, Z), padre_de(Z, Y).
es_abuelo(X, Y) :- 
    padre_de(X, Z), madre_de(Z, Y).

es_abuela(X, Y) :- 
    madre_de(X, Z), padre_de(Z, Y).
es_abuela(X, Y) :- 
    madre_de(X, Z), madre_de(Z, Y).

% 3. Regla para encontrar tíos y tías
es_tio(X, Y) :- 
    es_hermano(X, P), (padre_de(P, Y) ; madre_de(P, Y)).
es_tia(X, Y) :- 
    es_hermano(X, M), (padre_de(M, Y) ; madre_de(M, Y)).

% 4. Regla para encontrar primos y primas 
es_primo(X, Y) :- 
    padre_de(P1, X), padre_de(P2, Y), 
    es_hermano(P1, P2).
es_primo(X, Y) :- 
    madre_de(M1, X), madre_de(M2, Y), 
    es_hermano(M1, M2).

es_prima(X, Y) :- 
    padre_de(P1, X), madre_de(M2, Y), 
    es_hermano(P1, M2).
es_prima(X, Y) :- 
    madre_de(M1, X), padre_de(P2, Y), 
    es_hermano(M1, P2).

% 5. Regla para saber si es nieto o nieta 
es_nieto(X, Y) :- 
    padre_de(Y, P), padre_de(P, X).
es_nieto(X, Y) :- 
    madre_de(Y, P), padre_de(P, X).

es_nieta(X, Y) :- 
    padre_de(Y, P), madre_de(P, X).
es_nieta(X, Y) :- 
    madre_de(Y, P), madre_de(P, X).
