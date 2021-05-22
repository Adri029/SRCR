:- consult(paths).


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
final(12).

resolveBFS(Solucao):-
	inicial(InicialEstado),
	resolveBFS([InicialEstado], [],Solucao).

resolveBFS([],_,[]):-
	fail, !.

resolveBFS([E |Orla], _, [E]):-
	final(E),!.

resolveBFS([E|Orla], Visitados, [E|Sol]):-
	vizinhos(E,Vizinhos, Visitados, [E|Orla]), %calcular vizinhos
	append(Orla,Vizinhos,NOrla), % adicionar vizinhos no fim da orla
	resolveBFS(NOrla,[E|Visitados], Sol). %calcular BFS para primeiro elemento da orla, adicionando a posicao atual aos visitados






vizinhos(Estado,Vizinhos, Visitados, Orla):-
	findall(E, (haCaminho(Estado,E), not(member(E,Visitados)), not(member(E,Orla))), Vizinhos).