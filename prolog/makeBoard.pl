base(3).
side(9).
rbase([0,1,2]).
nums(N) :- random_permutation([1,2,3,4,5,6,7,8,9], N).

pattern(R, C, P) :-
  base(B),
  side(S),
  P is (B*(R mod B)+R//B+C) mod S.

rows(R) :-
  rbase(B),
  random_permutation(B, J),
  random_permutation(B, K),
  build(J, K, R).

cols(C) :-
  rbase(B),
  random_permutation(B, J),
  random_permutation(B, K),
  build(J, K, C).

sumIn(_, [] , []).
sumIn([], _, []).
sumIn([J|JT], [K|KT] , L) :-
  base(B),
  sumIn([J|JT], KT, L1),
  N is J*B+K,
  L = [N | L1].

build(_, [] , []).
build([], _, []).
build([J|JT], [K|KT] , L) :-
  sumIn([J|JT], [K|KT] , L1),
  build(JT, [K|KT], L2),
  append(L1, L2, L).

getBoard(_, [], _, []).
getBoard([], _, _, []).
getBoard([R|RT], [C|CT], N, B):-
  pattern(R, C, P),
  getBoard([R|RT], CT, N, B1),
  nth0(P, N, E),
  B = [E | B1].

makeBoard(_, [], _, []).
makeBoard([], _, _, []).
makeBoard([R|RT], [C|CT], N, B):-
  getBoard([R|RT], [C|CT], N, B1),
  makeBoard(RT, [C|CT], N, B2),
  append([B1], B2, B).

board(B):-
  nums(N),
  rows(R),
  cols(C),
  makeBoard(R, C, N, B).
