%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2015 8:53 AM
%%%-------------------------------------------------------------------
-module(ring).
-author("rasrivastava").

%% API
-compile(export_all).


start(N) ->
  spawn(ring,startEach,[self(),N-1]).


startEach(OrigPid,N)->
  createRing(OrigPid,N).


loop(NextPid) ->
  receive
    {X,M} when is_integer(X) andalso M == 0->
      io:format("End of loop~n"),
      loop(NextPid);
    {X,M} when is_integer(X) ->
      io:format("Buffer recieved back~n"),
      pingNext(X,M-1,NextPid),
      loop(NextPid)
  end.

pingNext(X,M,NextPid) ->
  NextPid ! {X,M}.


createRing(OrigPid,0) ->
  loop(OrigPid);
createRing(OrigPid,N) ->
  Pid = spawn(ring,startEach,[OrigPid,N-1]),
  loop(Pid).

