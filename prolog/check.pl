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