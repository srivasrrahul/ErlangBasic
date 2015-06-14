%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Jun 2015 1:52 PM
%%%-------------------------------------------------------------------
-module(db).
-author("rasrivastava").

%% API
-compile(export_all).

new() ->
  [].


destroy(_) ->
  ok.

write(Key,Element,Db) ->
  [{Key,Element} | Db].


delete(Key,Db) ->
  lists:filter(fun({K,_}) -> K == Key end,Db).

read(Key,Db) ->
  case Db of
    [{K,V}|_] when K == Key ->
      V;
    [{_,_}|T] ->
      db:read(T);
    _ -> error("No sucj key")
  end.

