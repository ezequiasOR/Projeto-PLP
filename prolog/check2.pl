:-  module(check2,[compararTabuleiros/2]).
% Opção de checking simplificada // Testing

compare_matrix(NewBoard, CompleteBoard) :-
   %matrix(Board, I, J, Value1),
   %matrix(CompleteBoard, I, J, Value2),
   NewBoard == CompleteBoard.

compararTabuleiros(NewBoard, CompleteBoard) :-
  (compare_matrix(NewBoard, CompleteBoard) -> 
  writeln("PARABÉNS, VOCÊ GANHOU!");
  writeln("DISCREPÂNCIA ENCONTRADA")).