:-  module(emptyBoard,[gameBoard/2]).

replaceElem( Matrix , X , Y , NewValue , NewMatrix ) :-
	append(RowPfx,[Row|RowSfx],Matrix),
  	length(RowPfx,X) ,
	append(ColPfx,[_|ColSfx],Row) ,
	length(ColPfx,Y) ,
	append(ColPfx,[NewValue|ColSfx],RowNew) ,
	append(RowPfx,[RowNew|RowSfx],NewMatrix).

cloneBoard([],[]).
cloneBoard([H|T],[H|B]):- cloneBoard(T,B).

emptyBoard(CloneBoard,0,CloneBoard).
emptyBoard(CloneBoard,EmptyCells,GameBoard):-
	random_between(0,8,C), random_between(0,8,R),
	replaceElem(CloneBoard,R,C,0,CBoard),
	EmptyCells1 is (EmptyCells - 1),
	emptyBoard(CBoard,EmptyCells1,GameBoard).

gameBoard(CompleteBoard, GameBoard):- 
	cloneBoard(CompleteBoard, CloneBoard),
	emptyBoard(CloneBoard,55,GameBoard).
