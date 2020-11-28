cloneBoard([],[]).
cloneBoard([H|T],[H|Z]):- clone(T,Z).

emptyBoard(0, CloneBoard, GameBoard):-
	GameBoard = CloneBoard.
emptyBoard(emptyCells, CloneBoard, GameBoard):-
	random_between(1, 9, C),
	random_between(1, 9, R),
	% preciso inserir um 0 na posicao CloneBoard[R][C] - preciso da parte de joao


gameBoard(CompleteBoard, GameBoard):- 
	cloneBoard(CompleteBoard, CloneBoard),
	emptyBoard(52, CloneBoard, GameBoard).