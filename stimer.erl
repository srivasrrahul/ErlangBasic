%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2015 8:42 AM
%%%-------------------------------------------------------------------
-module(stimer).
-author("rasrivastava").

%% API
-export([start/2]).

start(Time,Fun) -> spawn(fun() -> timer(Time,Fun) end).

timer(Time,Fun) ->
  receive
    cancel ->
      void
    after Time ->
      Fun()

  end.