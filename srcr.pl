:- consult(paths).

loadcsv:-
	csv_read_file('C:\\Users\\Adriano\\Documents\\GitHub\\SRCR\\lixo.csv', Rows1,[functor(lixo), arity(3)]),
   	maplist(assert, Rows1),
   	csv_read_file('C:\\Users\\Adriano\\Documents\\GitHub\\SRCR\\local.csv', Rows2,[functor(local), arity(2)]),
   	maplist(assert, Rows2),
   	csv_read_file('C:\\Users\\Adriano\\Documents\\GitHub\\SRCR\\coordenada.csv', Rows3,[functor(coordenada), arity(4)]),
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
/*
resolveBFS(_,Solucao):-
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
*/



% custo do último incluído
resolveBFS(Sol1/Custo/Reco):-
	inicial(NodeS),
	final(NodeD),
	bfs([[NodeS]/0/0], NodeD, Sol/Custo/Reco),
	reverse(Sol,Sol1).

bfs([[Node|Path]/Custo/Reco|_], Node, [Node|Path]/Custo/Reco).

bfs([Path|Paths], NodeD, Sol):-
	extende(Path, NewPaths),
	append(Paths, NewPaths, Paths1),
	bfs(Paths1, NodeD, Sol).

extende([Node|Path]/Custo/Reco, NewPaths) :-
	findall([NewNode, Node|Path]/NCusto/NReco, 
					(haCaminho(Node, NewNode), not(member(NewNode, [Node|Path])), 
					 lixo(NewNode,_,Lixo),NReco is Reco + Lixo,
					 NReco < 15000,
					 distancia(Node,NewNode,D), NCusto is Custo + D),
			NewPaths).



/*
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

*/

% custo do primeiro incluído

resolveDFS([Nodo|Caminho]/Custo/Reco):-
	inicial(Nodo),
    dfs(Nodo,[Nodo],Caminho/Custo/Reco),
    Reco =< 15000.
    

dfs(Nodo,_, []/0/0):-
    final(Nodo).

dfs(Nodo, Historico, [NodoProx|Caminho]/NCusto/NReco):-
    haCaminho(Nodo, NodoProx),
    not(member(NodoProx, Historico)),
    dfs(NodoProx, [NodoProx|Historico], Caminho/Custo/Reco),
    distancia(Nodo,NodoProx, D),
    NCusto is Custo + D,
    lixo(Nodo,_,Lixo),
    NReco is Reco + Lixo.


resolveIDFS([Nodo|Caminho]/NCusto/NReco,N):-
	inicial(Nodo),
    idfsAux(Nodo,Caminho/NCusto/NReco, 0,N).

idfsAux(_,[]/0/0,N,N).

idfsAux(Nodo ,Caminho, I,N):-
	idfs(Nodo,[Nodo],Caminho, I,N).

idfsAux(Nodo ,Caminho, I,N):-
	NI is I+1,
	idfs(Nodo,[Nodo],Caminho, NI,N).

idfs(Nodo,_, []/0/0, _,_):-
    final(Nodo).

idfs(_,_,[]/0/0,N,N):- !.

idfs(Nodo, Historico, [NodoProx|Caminho]/NCusto/NReco, I ,N):-
    haCaminho(Nodo, NodoProx),
    not(member(NodoProx, Historico)),
    NI is I + 1,
    idfs(NodoProx, [NodoProx|Historico] ,Caminho/Custo/Reco, NI, N),
    distancia(Nodo,NodoProx, D),
    NCusto is Custo + D,
    lixo(Nodo,_,Lixo),
    NReco is Reco + Lixo.


% DFS com limite de procura
/*
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
*/

/*

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

*/

insertSorted((State,Value),[],[(State,Value)]).
insertSorted((State,Value),[(S,V)|List],Resp):-
		Value =< V,
		append([(State,Value)],[(S,V)|List],Resp).
insertSorted((State,Value),[(S,V)|List],[(S,V)|Resp]):-
		Value > V,
		insertSorted((State,Value),List,Resp).


aScore(A,R):-
	final(E),
	distancia(A,E,R),!.

/*
resolveAStar(S):-
	inicial(InicialEstado),
	aScore(InicialEstado, Score),
	resolveAStar([(InicialEstado,Score)],[], S).

resolveAStar([(E,Score)|Orla],_,[(E,Score)]):-
	final(E),!.

resolveAStar([],_,[]):-
	!,fail.

resolveAStar([(E,Score)|Orla],Visitados,[(E,Cumulative)|S]):-
	findall(Estado, (haCaminho(E,Estado), not(member((Estado,_),Visitados))), Vizinhos),
	aScore(E,AScr),
	Cumulative is Score - AScr,
	forEach(aStarAux, (E,Cumulative), Vizinhos, Orla, NOrla),
	resolveAStar(NOrla,[(E,Cumulative)|Visitados],S).


aStarAux(Estado, (Pai,Custo) , Orla, NOrla):-
	distancia(Pai,Estado,Score),
	aScore(Estado, R),
	AScore is R + Score + Custo,
	(not(member((Estado,_),Orla)), insertSorted((Estado,AScore),Orla, NOrla);
	member((Estado,NowScore),Orla), AScore < NowScore, delete(Orla,(Estado,NowScore),VOrla), insertSorted((Estado,AScore),VOrla,NOrla)).

forEach(_,_,[],R1,R1).
forEach(Pred,Pai,[E|T],Orla,R):-
	call(Pred,E,Pai,Orla,R1),
	forEach(Pred,Pai,T,R1,R).

*/


%TODO adicionar qntds aqui


resolveAEstrela(Nodo, Caminho/Custo) :-
    aScore(Nodo, Estima),
    aestrela([[Nodo]/0/Estima], CaminhoInverso/Custo/_),
    reverse(CaminhoInverso, Caminho).

aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,final(Nodo).

aestrela(Caminhos, SolucaoCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expandeAEstrela(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    aestrela(NovoCaminhos, SolucaoCaminho).

obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor(Caminhos, MelhorCaminho).
    
expandeAEstrela(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacenteG(Caminho,NovoCaminho), ExpCaminhos). 

adjacenteG([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	haCaminho(Nodo, ProxNodo), distancia(Nodo,ProxNodo,PassoCusto), not(member(ProxNodo, Caminho)),
	NovoCusto is Custo + PassoCusto,
	aScore(ProxNodo, Est).
	

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).


resolveGulosa(Nodo, Caminho/Custo) :-
    aScore(Nodo, Estima),
    gulosa([[Nodo]/0/Estima], CaminhoInverso/Custo/_),
    reverse(CaminhoInverso, Caminho).

gulosa(Caminhos, Caminho) :-
	obtem_melhor_g(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,final(Nodo).

gulosa(Caminhos, SolucaoCaminho) :-
    obtem_melhor_g(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expandeGulosa(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    gulosa(NovoCaminhos, SolucaoCaminho).

obtem_melhor_g([Caminho], Caminho) :- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/_/Est2|Caminhos], MelhorCaminho) :-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor_g([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor_g(Caminhos, MelhorCaminho).
    
expandeGulosa(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacenteG(Caminho,NovoCaminho), ExpCaminhos). 


%TODO eliminar repetidos do dataset para os algoritmos funcionarem


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