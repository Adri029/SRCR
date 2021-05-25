:- consult(paths).

loadcsv:-
	csv_read_file('C:\\Users\\adria\\Documents\\GitHub\\SRCR\\lixo.csv', Rows1,[functor(lixo), arity(3)]),
   	maplist(assert, Rows1),
   	csv_read_file('C:\\Users\\adria\\Documents\\GitHub\\SRCR\\local.csv', Rows2,[functor(local), arity(2)]),
   	maplist(assert, Rows2),
   	csv_read_file('C:\\Users\\adria\\Documents\\GitHub\\SRCR\\coordenada.csv', Rows3,[functor(coordenada), arity(4)]),
   	maplist(assert, Rows3).

loadcsv(Path1,Path2,Path3):- 
	csv_read_file(Path1, Rows1,[functor(lixo), arity(3)]),
   	maplist(assert, Rows1),
   	csv_read_file(Path2, Rows2,[functor(local), arity(2)]),
   	maplist(assert, Rows2),
   	csv_read_file(Path3, Rows3,[functor(coordenada), arity(4)]),
   	maplist(assert, Rows3).



haCaminho(Estado, Estado1) :-
	caminho(Estado, Estado1);
	caminho(Estado1, Estado).

inicial(0).
final(24).



%adptar para receber o nodo anterior

resolveBFS(Solucao):-
	inicial(InicialEstado),
	resolveBFS([InicialEstado], [],Solucao).

resolveBFS([],_,[]):-
	!,fail.

resolveBFS([E |Orla], _, [E]):-
	final(E),!.

resolveBFS([E|Orla], Visitados, [E|Sol]):-
	vizinhos(E,Vizinhos, Visitados, [E|Orla]), %calcular vizinhos
	append(Orla,Vizinhos,NOrla), % adicionar vizinhos no fim da orla
	resolveBFS(NOrla,[E|Visitados], Sol). %calcular BFS para primeiro elemento da orla, adicionando a posicao atual aos visitados


resolveDFS(Solucao):-
	inicial(InicialEstado),
	resolveDFS([InicialEstado], [],Solucao).

resolveDFS([],_,[]):-
	!, fail.

resolveDFS([E |Orla], _, [E]):-
	final(E),!.

resolveDFS([E|Orla], Visitados, [E|Sol]):- 
	vizinhos(E,Vizinhos, Visitados, [E|Orla]), %calcular vizinhos
	append(Vizinhos, Orla, NOrla), % adicionar vizinhos no fim da orla
	resolveDFS(NOrla,[E|Visitados], Sol). %calcular BFS para primeiro elemento da orla, adicionando a posicao atual aos visitados



% DFS com limite de procura

resolveDFS([],_,_,[]).

resolveDFS([E |Orla],_, _, [E]):-
	final(E),!.

resolveDFS([E |Orla], 0, Vis, Sol):-
	!, not(final(E)), resolveDFS(Orla,0,Vis, Sol).

resolveDFS([E|Orla], N ,Visitados, [E|Sol]):- 
	vizinhos(E,Vizinhos, Visitados, [E|Orla]), %calcular vizinhos
	append(Vizinhos, Orla, NOrla), % adicionar vizinhos no fim da orla
	Next is N - 1,
	resolveDFS(NOrla, Next, [E|Visitados], Sol). %calcular BFS para primeiro elemento da orla, adicionando a posicao atual aos visitados


resolveIDDFS(S,N):-
	resolveIDDFS(S,N,0).

resolveIDDFS(S,N,P):-
	P is N + 1,
	!,fail.

resolveIDDFS(S,N,C):-
	inicial(InicialEstado),
	C =< N,
	resolveDFS([InicialEstado],C,[],S),
	final(E),member(E,S).

resolveIDDFS(S,N,C):-	
	NewC is C + 1,
	resolveIDDFS(S,N,NewC).



insertSorted((State,Value),[],[(State,Value)]).
insertSorted((State,Value),[(S,V)|List],Resp):-
		Value =< V,
		append([(State,Value)],[(S,V)|List],Resp).
insertSorted((State,Value),[(S,V)|List],[(S,V)|Resp]):-
		Value > V,
		insertSorted((State,Value),List,Resp).


aScore(A,R):-
	final(E),
	distancia(A,E,R).


resolveAStar(S):-
	inicial(InicialEstado),
	aScore(InicialEstado, Score),
	resolveAStar([(InicialEstado,Score)],[(InicialEstado, Score)], S).

resolveAStar([(E,Score)|Orla],_,[(E,Score)]):-
	final(E),!.

resolveAStar([],_,[]):-
	!,fail.

resolveAStar([(E,Score)|Orla],Visitados,[(E,Score)|S]):-
	findall(Estado, (haCaminho(E,Estado), not(member(E,Visitados))), Vizinhos),
	forEach(aStarAux, Vizinhos, Orla, NOrla),
	resolveAStar(NOrla,[E|Visitados],S).

% calcular os custos dos caminhos

aStarAux(Estado, Orla, NOrla):-
	aScore(Estado, R),
	AScore is R + Score,
	(not(member((Estado,_),Orla)), insertSorted((Estado,AScore),Orla, NOrla);
	member((Estado,NowScore),Orla), AScore < NowScore, delete(Orla,(Estado,NowScore),VOrla), insertSorted((Estado,NowScore),VOrla,NOrla)).

forEach(_,_,[],_,[]).
forEach(Pred,[E|T],Orla,R):-
	call(Pred,E,Orla,R1),
	forEach(Pred,T,R1,R).
	








vizinhos(Estado,Vizinhos, Visitados, Orla):-
	findall(E, (haCaminho(Estado,E), not(member(E,Visitados)), not(member(E,Orla))), Vizinhos).


degreesToRadians(D,R):-
	R is D * 3.1415 / 180.

distancia(A,E,R):-
	coordenada(_,A,Lat1,Lon1),
	coordenada(_,E,Lat2,Lon2),
	Dlat is Lat2 - Lat1,
	Dlon is Lon2 - Lon1,
	degreesToRadians(Lat1, NLat1),
	degreesToRadians(Lat2, NLat2),
	Dlat2 is Dlat / 2,
	Dlon2 is Dlon / 2,
	C is sin(Dlat2) * sin(Dlat2) + sin(Dlon2) * sin(Dlon2) * cos(NLat1) * cos(NLat2),
	B is 1 - C,
	R is 6371 * 2 * atan2(sqrt(C), sqrt(B)).