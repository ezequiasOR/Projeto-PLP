replaceElem( Matrix , X , Y , NewValue , NewMatrix ) :-
  append(RowPfx,[Row|RowSfx],Matrix),
  length(RowPfx,X) ,
  append(ColPfx,[_|ColSfx],Row) ,
  length(ColPfx,Y) ,
  append(ColPfx,[NewValue|ColSfx],RowNew) ,
  append(RowPfx,[RowNew|RowSfx],NewMatrix)
  .

removeElem( Matrix , X , Y , 0 , NewMatrix ) :-
  replaceElem( Matrix , X , Y , 0 , NewMatrix )
  .

insertElem( Matrix , X , Y , NewValue , NewMatrix ) :-
  (   (   NewValue =:= 1; NewValue =:= 2; NewValue =:= 3; NewValue =:= 4; NewValue =:= 5; NewValue =:= 6; NewValue =:= 7; NewValue =:= 8; NewValue =:= 9) ->
  replaceElem( Matrix , X , Y , NewValue , NewMatrix )
  ; writeln('Valor invÃ¡lido, escolha um número entre 1 e 9'))
  .

