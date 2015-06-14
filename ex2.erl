%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Jun 2015 11:53 AM
%%%-------------------------------------------------------------------
-module(ex2).
-author("rasrivastava").

%% API
-compile(export_all).

sum(0) -> 0;
sum(N) -> N + sum(N-1).

sum(M,M) -> M;
sum(N,M) when N<M ->
  N + sum(N+1,M);
sum(N,M) when N > M ->
  exit("err").

createLst(N) when N > 1->
  PendingLst = createLst(N-1),
  PendingLst ++ [N];
createLst(1) ->
  [1].


reverse_create(N) when N > 1 -> [N | reverse_create(N-1)];
reverse_create(1) -> [1].


print_integers(N) when N>1 ->
  io:format("~p~n",[N]),
  print_integers(N-1);
print_integers(1) ->
  io:format("~p~n",[1]).

print_even(N) when N rem 2 == 0 ->
  io:format("~p~n",[N]),
  print_even(N-1);
print_even(N) when N rem 2 == 1,N > 1 ->
  print_even(N-1);
print_even(N) when N == 1 ->
  ok.

my_filter(Lst,Predicate) ->
  lists:filter(fun(X) -> X =< Predicate end,Lst).

my_reverse([H|T]) ->
  my_reverse(T) ++ [H];
my_reverse([]) -> [].

concat(Lst) ->
  case Lst of
    [H|T] -> H ++ concat(T);
    [] -> []
  end.

flatten([X|S]) when is_list(X) ->
  flatten(X) ++ flatten(S);
flatten([X|S]) ->
  [X|flatten(S)];
flatten([]) -> [].

merge([X1|S1],[X2|S2]) when X1 =< X2 -> [X1| merge(S1,[X2|S2])];
merge([X1|S1],[X2|S2]) when X2 < X1  -> [X2 | merge([X1|S1],S2)];
merge([X1|S1], []) -> [X1|S1];
merge([], [X2|S2]) -> [X2|S2];
merge([],[]) -> [].

mergeSort([X|[]]) -> [X];
mergeSort(Lst) ->
  L = length(Lst),
  Mid = L div 2,
  {Lst1,Lst2} = lists:split(Mid,Lst),
  SortedLst1 = mergeSort(Lst1),
  SortedLst2 = mergeSort(Lst2),
  merge(SortedLst1,SortedLst2).


