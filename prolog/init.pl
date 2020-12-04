:- use_module(makeBoard, [board/1]).
% makeBoard:board(B).
:- use_module(boardElemModification,[removeElem/2,insertElem/2]).

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

insertNumber(CompleteBoard):- boardElemModification:insertElem(CompleteBoard, NewBoard), nl, optionSolucao(NewBoard).

removeNumber(CompleteBoard):- boardElemModification:removeElem(CompleteBoard, NewBoard), nl, optionSolucao(NewBoard).

checkTable(CompleteBoard):- check:checkTable(NewBoard, CompleteBoard), nl, optionSolucao(CompleteBoard).


findElem(CompleteBoard, Row, Col, Elem):- 
	nth1(Row, CompleteBoard, ARow),
	nth1(Col, ARow, Elem).

getTip(CompleteBoard):-
	writeln("Digite o numero da linha: (entre 1 e 9)"),
	read(Row), nl,
	writeln("Digite o numero da Coluna (entre 1 e 9)") ,
	read(Col), nl,
	findElem(CompleteBoard, Row, Col, Elem),
	writeln(Elem),
	optionSolucao(CompleteBoard).

checkWin(CompleteBoard):- check2:compararTabuleiros(CompleteBoard, NewBoard), nl, optionSolucao(CompleteBoard).

checkSolution(CompleteBoard):- writeln(CompleteBoard), nl, main.

options3(1, CompleteBoard):- insertNumber(CompleteBoard), nl.
options3(2, CompleteBoard):- removeNumber(CompleteBoard), nl.
options3(3, CompleteBoard):- checkTable(CompleteBoard), nl.
options3(4, CompleteBoard):- getTip(CompleteBoard), nl.
options3(5, CompleteBoard):- checkWin(CompleteBoard), nl.
options3(6, CompleteBoard):- checkSolution(CompleteBoard), nl.

optionSolucao(CompleteBoard) :-
	writeln("1 - Inserir um numero"),
	writeln("2 - Remover um numero"),
	writeln("3 - Fazer um check (verificar contradicao)"),
	writeln("4 - Pedir uma dica de uma celula especifica"),
	writeln("5 - Verificar se ganhou"),
	writeln("6 - Desistir e verificar solucao"),
	read(Option), nl,
	((Option > 6; Option < 1) -> writeln("Opcao invalida") ,
		optionSolucao(CompleteBoard) ; options3(Option, CompleteBoard)).

options1(1):- optionJogar(), nl.
options1(2):- makeBoard:board(CompleteBoard), optionSolucao(CompleteBoard), nl.
options1(3):- halt.

main:- write("1 - Solucao"), nl,
	write("2 - Jogar"), nl,
	write("3 - Parar de jogar"), nl,
	read(Option), nl,
	((Option > 4; Option < 1) -> writeln("Opcao invalida") ,
		main ; options1(Option)).