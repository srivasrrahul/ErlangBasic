%%%-------------------------------------------------------------------
%%% @author Rahul
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2015 8:41 AM
%%%-------------------------------------------------------------------
-module(functions).
-compile(export_all).
-author("rasrivastava").

%% API
%%-export([]).
head([H|_]) -> H.
same(X,X) -> true;
same(_,_) -> false.

valid_date({Data = {Y,M,D}},Time={H,M,S}) ->
  io:format("Valid date ~s , ~s, ~s",[Y,M,D]),
  io:format("Valid time is ~s ~s ~s",[H,M,S]);
valid_date(_,_) -> io:format("Invali data").

old_enough(X) when X >= 16,X =< 1104 -> true;
old_enough(_) -> false.

beach(Temperature) ->
  case Temperature of
    {celcius,_} -> io:format("Its a cerlcuis");
    {fahrenheit,_} -> io:format("Its fahrenheit");
    _ -> io:format("DOnt know")
  end.
