:- consult(paths).


loadcsv(Path1,Path2,Path3):- 
	csv_read_file(Path1, Rows1,[functor(lixo), arity(3)]),
   	maplist(assert, Rows1),
   	csv_read_file(Path2, Rows2,[functor(local), arity(2)]),
   	maplist(assert, Rows2),
   	csv_read_file(Path3, Rows3,[functor(coordenada), arity(4)]),
   	maplist(assert, Rows3).



haCaminho(Estado, Estado1) :-
	caminho(Estado, Estado1).

inicial(0).
final(24).

resolveDFS(Solucao):-
	inicial(InicialEstado),
	resolveDFS(InicialEstado, [InicialEstado], Solucao).

resolveDFS(Estado, _, [Estado]):-
	final(Estado), !.

resolveDFS(Estado, Historico, [Estado|Solucao]):-
	haCaminho(Estado, Estado1),
	not(member(Estado1, Historico)),
	resolveDFS(Estado1, [Estado1|Historico], Solucao).


resolveBFS(Solucao):-
	inicial(InicialEstado),
	resolveBFS(InicialEstado, [InicialEstado], Solucao).

% Procura 1 nodo, vai a todos os vizinhos e repete o processo

resolveBFS(S):-
	inicial(Estado),
	resolveBFS(Estado,[Estado],S).


resolveBFS(Estado,_,[Estado]):-
	final(Estado), !.

resolveBFS(Estado, Visitados, [Estado|Caminho]):-
	vizinhos(Estado,L,Visitados),
	vizinhosBFS(L,E).
	

vizinhosBFS([H|Vizinhos],H):-
	final(H), !.

vizinhosBFS([],_).
vizinhosBFS([H|Vizinhos],E):-
	not(final(H)), vizinhosBFS(Vizinhos).



adicionaListas([],[],[]).
adicionaListas([],[H|T],[H|R]):- 
	adicionaListas([],L,R).
adicionaListas([H|T],L,[H|R]):- 
	adicionaListas(T,L,R).




vizinhos(Estado,L,Visitados):-
	findall(E, (haCaminho(Estado,E), not(member(E,Visitados))), L).