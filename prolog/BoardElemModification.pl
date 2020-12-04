:-  module(boardElemModification,[removeElem/2,insertElem/2, replaceElem/5]).

replaceElem( Matrix , X , Y , NewValue , NewMatrix ) :-
  append(RowPfx,[Row|RowSfx],Matrix),
  length(RowPfx,X) ,
  append(ColPfx,[_|ColSfx],Row) ,
  length(ColPfx,Y) ,
  append(ColPfx,[NewValue|ColSfx],RowNew) ,
  append(RowPfx,[RowNew|RowSfx],NewMatrix)
  .

removeElem( Matrix, NewMatrix ) :-
  writeln("Digite o numero da linha: (entre 1 e 9)"),
  read(Row), nl,
  ((Row < 1 ; Row > 9) -> writeln('Valor inv�lido, escolha um n�mero entre 1 e 9') , removeElem( Matrix, NewMatrix )
  ;
  writeln("Digite o numero da coluna (entre 1 e 9)"),
  read(Column), nl,
  ((Column < 1 ; Column > 9) -> writeln('Valor inv�lido, escolha um n�mero entre 1 e 9') , removeElem( Matrix, NewMatrix )
  ;
  Y is Column - 1,
  X is Row - 1,
  replaceElem( Matrix , X , Y , 0 , NewMatrix ) ))
  .

insertElem( Matrix , NewMatrix ) :-
  writeln("Digite o numero da linha: (entre 1 e 9)"),
  read(Row), nl,
  ((Row < 1 ; Row > 9) -> writeln('Valor inv�lido, escolha um n�mero entre 1 e 9') , insertElem( Matrix, NewMatrix )
  ;
  writeln("Digite o numero da coluna (entre 1 e 9)"),
  read(Column), nl,
  ((Column < 1 ; Column > 9) -> writeln('Valor inv�lido, escolha um n�mero entre 1 e 9') , insertElem( Matrix, NewMatrix )
  ;
  writeln("Digite o novo valor (entre 1 e 9)"),
  read(NewValue), nl,
  ((NewValue < 1 ; NewValue > 9) -> writeln('Valor inv�lido, escolha um n�mero entre 1 e 9') , insertElem( Matrix, NewMatrix )
  ;
  Y is Column - 1,
  X is Row - 1,
  replaceElem( Matrix , X , Y , NewValue , NewMatrix ) )))
  .

