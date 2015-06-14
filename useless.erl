%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2015 8:14 AM
%%%-------------------------------------------------------------------
-module(useless).
-author("rasrivastava").

%% API
-export([add/2,hello/0,greet/2]).

add(A,B) -> A + B.

hello() -> io:format("Hello World!~n").

greet(male,Name) -> io:format("Hello mr. ~s!",[Name]);
greet(female,Name) -> io:format("Hello mrs. ~s!",[Name]);
greet(_,Name) -> io:format("Hello unknown ~s!",[Name]).


