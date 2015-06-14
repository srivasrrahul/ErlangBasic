%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2015 8:25 AM
%%%-------------------------------------------------------------------
-module(processors).
-author("rasrivastava").

%% API
-export([max/1]).

max(N) ->
  Max = erlang:system_info(process_limit),
  io:format("Max is ~p",[Max]),
  statistics(runtime),
  Max.


