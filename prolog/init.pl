:- use_module(makeBoard, [board/1]).
% makeBoard:board(B).

options2(1):- writeln("ler os dados..."),
	read(input), nl.
options2(2):- writeln("ler os dados..."), nl.

optionJogar :-
	writeln("Como voce deseja inserir o tabuleiro?"),
	writeln("1 - Uma lista (Ex. '[A, 2, 4, B, 3, 7, B, 4, 2]')"),
	writeln("2 - Um cedula por vez (Ex. [A, 2, 4] - coluna; linha; numero)"),
	read(Option), nl,
	((Option > 3; Option < 1) -> writeln("Opcao invalida") ,
		optionJogar ; options2(Option)).

insertNumber:- writeln("esperando joao"), nl, optionSolucao.

removeNumber:- writeln("esperando joao"), nl, optionSolucao.

checkTable:- writeln("esperando caio"), nl, optionSolucao.

getTip:- writeln("fazer depois que izaquiel integral o makeboard aqui"), nl, optionSolucao.

checkWin:- writeln("esperando caio"), nl, optionSolucao.

checkSolution:- writeln("fazer depois que izaquiel integral o makeboard aqui"), nl, main.

options3(1):- insertNumber(), nl.
options3(2):- removeNumber(), nl.
options3(3):- checkTable(), nl.
options3(4):- getTip(), nl.
options3(5):- checkWin(), nl.
options3(6):- checkSolution(), nl.

optionSolucao :-
	writeln("1 - Inserir um numero"),
	writeln("2 - Remover um numero"),
	writeln("3 - Fazer um check (verificar contradicao)"),
	writeln("4 - Pedir uma dica de uma celula especifica"),
	writeln("5 - Verificar se ganhou"),
	writeln("6 - Desistir e verificar solucao"),
	read(Option), nl,
	((Option > 6; Option < 1) -> writeln("Opcao invalida") ,
		optionSolucao ; options3(Option)).

options1(1):- optionJogar(), nl.
options1(2):- optionSolucao(), nl.
options1(3):- halt.

main:- write("1 - Solucao"), nl,
	write("2 - Jogar"), nl,
	write("3 - Parar de jogar"), nl,
	read(Option), nl,
	((Option > 4; Option < 1) -> writeln("Opcao invalida") ,
		main ; options1(Option)).