%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. May 2015 8:59 PM
%%%-------------------------------------------------------------------
-module(misc).
-author("rasrivastava").

%% API
-compile(export_all).

sum(L) -> sum(L,0).

sum([],N) -> N;
sum([H|T],N) -> sum(T, H+N).


area({rectangle, Width, Ht}) -> Width * Ht;
area({circle, R})            -> 3.14159 * R * R.