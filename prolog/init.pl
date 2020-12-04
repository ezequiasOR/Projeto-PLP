:- use_module(makeBoard, [board/1]).
:- use_module(boardElemModification,[removeElem/2,insertElem/2,replaceElem/5]).
:- use_module(emptyBoard,[gameBoard/2]).

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

insertNumber(CompleteBoard, GameBoard):-
	boardElemModification:insertElem(GameBoard, NewBoard), write(NewBoard), nl,
	optionSolucao(CompleteBoard, NewBoard).

removeNumber(CompleteBoard, GameBoard):-
	boardElemModification:removeElem(GameBoard, NewBoard), write(NewBoard), nl,
	optionSolucao(CompleteBoard, NewBoard).

checkTable(CompleteBoard, GameBoard):-
	check:checkTable(NewBoard, CompleteBoard), nl, optionSolucao(CompleteBoard, GameBoard).

findElem(CompleteBoard, Row, Col, Elem):-
	nth1(Row, CompleteBoard, ARow),
	nth1(Col, ARow, Elem).

getTip(CompleteBoard, GameBoard):-
	writeln("Digite o numero da linha: (entre 1 e 9)"),
	read(Row), nl,
	writeln("Digite o numero da Coluna (entre 1 e 9)") ,
	read(Col), nl,
	findElem(CompleteBoard, Row, Col, Elem),
	boardElemModification:replaceElem(GameBoard, Row, Col, Elem, NewGameBoard),
	print(NewGameBoard),
	optionSolucao(CompleteBoard, NewGameBoard).

checkWin(CompleteBoard, GameBoard):-
	check2:compararTabuleiros(NewBoard, CompleteBoard), nl,
	optionSolucao(CompleteBoard).

checkSolution(CompleteBoard):- print(CompleteBoard), nl, main.

options3(1, CompleteBoard, GameBoard):- insertNumber(CompleteBoard, GameBoard), nl.
options3(2, CompleteBoard, GameBoard):- removeNumber(CompleteBoard, GameBoard), nl.
options3(3, CompleteBoard, GameBoard):- checkTable(CompleteBoard, GameBoard), nl.
options3(4, CompleteBoard, GameBoard):- getTip(CompleteBoard, GameBoard), nl.
options3(5, CompleteBoard, GameBoard):- checkWin(CompleteBoard, GameBoard), nl.
options3(6, CompleteBoard, GameBoard):- checkSolution(CompleteBoard), nl.

optionSolucao(CompleteBoard, GameBoard) :-
	writeln("1 - Inserir um numero"),
	writeln("2 - Remover um numero"),
	writeln("3 - Fazer um check (verificar contradicao)"),
	writeln("4 - Pedir uma dica de uma celula especifica"),
	writeln("5 - Verificar se ganhou"),
	writeln("6 - Desistir e verificar solucao"),
	read(Option), nl,
	((Option > 6; Option < 1) -> writeln("Opcao invalida") ,
		optionSolucao(CompleteBoard, GameBoard) ; options3(Option, CompleteBoard, GameBoard)).

options1(1):- optionJogar(), nl.
options1(2):- makeBoard:board(CompleteBoard),
	emptyBoard:gameBoard(CompleteBoard, GameBoard),
	optionSolucao(CompleteBoard, GameBoard), nl.
options1(3):- halt.

main:- write("1 - Solucao"), nl,
	write("2 - Jogar"), nl,
	write("3 - Parar de jogar"), nl,
	read(Option), nl,
	((Option > 4; Option < 1) -> writeln("Opcao invalida") ,
		main ; options1(Option)).

print([]).
print([H|T]) :-
  writeln(H),
  print(T).