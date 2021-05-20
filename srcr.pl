:- consult(paths).


loadcsv(Path,Rows):- csv_read_file(Path, Rows,[functor(local), arity(6)]),
   				maplist(assert, Rows).



haCaminho(Estado, Estado1) :-
	caminho(Estado, Estado1);
	caminho(Estado1, Estado).

inicial(-1).
final(-2).

resolveDFS(Solucao):-
	inicial(InicialEstado),
	resolveDFS(InicialEstado, [InicialEstado], Solucao).

resolveDFS(Estado, Historico, [(Estado,Estado1)|Solucao]):-
	haCaminho(Estado, Estado1),
	not(member(Estado1, Historico)),
	resolveDFS(Estado1, [Estado1|Historico], Solucao).

resolveDFS(Estado, Historico, []).

