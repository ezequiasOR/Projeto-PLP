% Checking - Checagem comparativa do tabuleiro em jogo com o tabuleiro-resposta

checkTable(NewBoard, CompleteBoard):-
  checkTable(NewBoard, 0, CompleteBoard).

checkTable([H], N, CompleteBoard):-
  checkTable(H, N, 0, CompleteBoard),
  !.

checkTable([H|T], N, CompleteBoard):-
  checkTable(H, N, 0, CompleteBoard),
  NTemp is N + 1,
  checkTable(T, NTemp, CompleteBoard).

checkTable([_], N, M, CompleteBoard):-
  checkCell(N, M, CompleteBoard),
  !.

checkTable([_|T], N, M, CompleteBoard):-
  checkCell(N, M, CompleteBoard),
  MTemp is M + 1,
  checkTable(T, N, MTemp, CompleteBoard).

checkCell(N, M, Board):-
  findNeighborVertival([N, M], List0),
  findNeighborHorizontal([N, M], List1),
  findNeighborSquare([N, M], List2),
  getNeighborsValue(CompleteBoard, List0, Values0),
  getNeighborsValue(CompleteBoard, List1, Values1),
  getNeighborsValue(CompleteBoard, List2, Values2),
  permutation(Values0, Values1),
  permutation(Values1, Values2),
  permutation(Values2, [1, 2, 3, 4, 5, 6, 7, 8, 9]).

findNeighborVertival(Pos, List):-
  findNeighborVertival(Pos, 0, NewBoard).

findNeighborVertival(_, 9, []):- !.

findNeighborVertival([_, M|_], Counter, List):-
  TmpCounter is Counter + 1,
  findNeighborVertival([_, M], TmpCounter, TmpList),
  append([[Counter, M]], TmpList, List).

findNeighborHorizontal(Pos, List):-
  findNeighborHorizontal(Pos, 0, List).

findNeighborHorizontal(_, 9, []):- !.

findNeighborHorizontal([N|_], Counter, List):-
  TmpCounter is Counter + 1,
  findNeighborHorizontal([N, _], TmpCounter, TmpList),

findNeighborSquare([N, M | _], List):-
  TmpN is (N//3)*3,
  TmpM is (M//3)*3,
  TmpNPlus1 is TmpN + 1,
  TmpMPlus1 is TmpM + 1,
  TmpNPlus2 is TmpN + 2,
  TmpMPlus2 is TmpM + 2,
  List = [[TmpN, TmpM], [TmpN, TmpMPlus1], [TmpN, TmpMPlus2], [TmpNPlus1, TmpM], [TmpNPlus1, TmpMPlus1], [TmpNPlus1, TmpMPlus2], [TmpNPlus2, TmpM], [TmpNPlus2, TmpMPlus1], [TmpNPlus2, TmpMPlus2]].
  append([[N, Counter]], TmpList, List).

getNeighborsValue(Board, [H], NeighborsValues):-
  [N, M|_] = H,
  get2D(N, M, Board, Result),
  NeighborsValues = [Result],
  !.

getNeighborsValue(Board, [H|T], NeighborsValues):-
  [N, M|_] = H,
  getNeighborsValue(Board, T, TmpAns),
  get2D(N, M, Board, Result),
  append([Result], TmpAns, NeighborsValues).