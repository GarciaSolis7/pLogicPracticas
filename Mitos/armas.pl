%PROBLEMA 2
%Las armas de los 4 heroes mitologicos. 

heroe(aquiles).
heroe(perseo).
heroe(teseo).
heroe(hercules).
%------------

arma(espada).
arma(escudo).
arma(arco).
arma(lanza).
%------------
:- discontiguous usa/2.

usa(aquiles,lanza).
usa(hercules,espada).

%------------
usa(teseo,arco).
usaria(teseo,escudo).
usaria(perseo,arco).
usa(perseo,escudo).

%------------
no_usa(aquiles,escudo).
no_usa(aquiles,arco).
no_usa(perseo,espada).
no_usa(hercules,lanza).
no_usa(hercules,escudo).

%REGLA
arma_usada(Heroe, Arma) :-
    usa(Heroe, Arma).
