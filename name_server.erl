%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Jun 2015 1:02 PM
%%%-------------------------------------------------------------------
-module(name_server).
-author("rasrivastava").

%% API
-export([start/0,store/2,lookup/1]).

start() -> register(name_server,spawn(fun() -> loop() end)).

store(Key,Value) ->
  io:format("Store recieved"),
  rpc({store,Key,Value}).

lookup(Key) ->
  io:format("Lookup recieved"),
  rpc({lookup,Key}).

rpc(Q) ->
  name_server ! {self(),Q},
  receive
    {name_server,Reply} ->
      Reply
  end.

loop() ->
  receive
    {From,{store,Key,Value}}->
      put(Key,{ok,Value}),
      From ! {name_server,true},
      loop();
    {From,{lookup,Key}} ->
      From ! {name_server,get(Key)},
      loop()
  end.


