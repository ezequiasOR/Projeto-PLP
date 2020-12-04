% Opção de checking simplificada // Testing

compare_matrix(Board, CompleteBoard) :-
   matrix(Board, I, J, Value1),
   matrix(CompleteBoard, I, J, Value2),
   Value1 == Value2.

compararTabuleiros(Board, CompleteBoard) :-
  (compare_matrix(Board, CompleteBoard) -> 
  writeln("PARABÉNS, VOCÊ GANHOU!");
  writeln("DISCREPÂNCIA ENCONTRADA")).