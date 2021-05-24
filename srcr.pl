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





vizinhos(Estado,Vizinhos, Visitados, Orla):-
	findall(E, (haCaminho(Estado,E), not(member(E,Visitados)), not(member(E,Orla))), Vizinhos).