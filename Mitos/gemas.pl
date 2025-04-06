%PROBLEMA 3
% LAS GEMAS DE LOS 4 TITANES. 
titan(cronos).
titan(ocean).
titan(hiperion).
titan(japeto).

%-----------
gema(zafiro).
gema(rubi).
gema(esmeralda).
gema(diamante).
%-----------
tiene(japeto,diamante).
tiene(hiperion,esmeralda).
tiene(cronos,rubi).
tiene(ocean,zafiro).


%-----------
no_tiene(cronos,zafiro).
no_tiene(cronos,diamante).
no_tiene(ocean,rubi).
no_tiene(hiperion,zafiro).
no_tiene(hiperion,rubi).

%REGLA
tiene_gema(Titan, Gema) :-
    tiene(Titan, Gema).
