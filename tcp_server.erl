%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Jun 2015 5:27 PM
%%%-------------------------------------------------------------------
-module(tcp_server).
-author("rasrivastava").

%% API
-export([start_nano_server/0]).

start_nano_server() ->
  ChatServerPid = spawn(fun() -> chatServerHandler() end),
  {ok,ListenSocket} = gen_tcp:listen(2345,[binary,{packet,4},
    {reuseaddr,true},
    {active,true}]),
%%   {ok,Socket} = gen_tcp:accept(ListenSocket),
%%   spawn(fun() -> loop(Socket) end),
%%   io:format("Socket connected successfully"),
  mainLoop(ListenSocket,ChatServerPid).

iterateNext(Table,PrevKey,Fun) ->
  case ets:next(Table,PrevKey) of
    {Pid,_} ->
      Fun(Pid),
      iterateNext(Table,Pid,Fun);
    '$end_of_table' ->
      io:format("Iterating finished")
  end.

iterate(Table,Fun) ->
  case ets:first(Table) of
    {Pid,_} ->
      Fun(Pid),
      iterateNext(Table,Pid,Fun);
    '$end_of_table' ->
      io:format("Table is empty")
  end.

broadcast(Table,ClientPid,Message) ->
  iterate(Table,fun(Pid) -> Pid ! {sendMessage,Message} end).


chatServerGroup(Table) ->
  receive
    {From,newClientAdded,ClientPid} ->
      ets:insert(Table,{ClientPid,0}),
      chatServerGroup(Table);
    {From,clientLoggedOff,ClientPid} ->
      ets:delete(Table,ClientPid);
    {From,messageRecieved,ClientPid,Message} ->
      broadcast(Table,ClientPid,Message),
      chatServerGroup(Table)

  end.

chatServerHandler() ->
  %%broadcaset to all groups
  TableId = ets:new(chatGroup,[set]),
  chatServerGroup(TableId).

mainLoop(ListenSocket,ChatServerPid) ->
  io:format("Entering to main loop"),
  {ok,Socket} = gen_tcp:accept(ListenSocket),
  io:format("Rcieved new connection\n"),
  spawn(fun() -> mainLoop(ListenSocket,ChatServerPid) end),

  loop(Socket,ChatServerPid).

parseMessage(Message,ChatServerPid) ->

  <<HeaderVal:8,MessageVal/binary>> = Message,
  io:format("Value is ~p~n",[HeaderVal]),

  case HeaderVal of
    1 ->
      io:format("Connect Message recieved from ~p ~n",[MessageVal]),
      ChatServerPid ! {self(),newClientAdded,self()};
    2 ->
      io:format("Actual Message Recieved ~p ~n",[Message]),
      ChatServerPid ! {self(),messageRecieved,self(),Message};
    3 ->
      ChatServerPid ! {self(),clientLoggedOff,self()},
      io:format("Disconnect Recieved ~n")

  end.



loop(Socket,ChatServerPid) ->
  io:format("Entering Loop ~n"),
  receive
    {tcp,Socket,Bin} ->
      io:format("Data recieved is : ~p ",[Bin]),
      parseMessage(Bin,ChatServerPid),
      gen_tcp:send(Socket,"Hello World \n"),
      %%gen_tcp:close(Socket);

      loop(Socket,ChatServerPid);

    {tcp_closed,Socket} ->
      io:format("Socket closed"),
      ChatServerPid ! {self(),clientLoggedOff,self()};

    {sendMessage,Message} ->
      gen_tcp:send(Socket,Message),
      loop(Socket,ChatServerPid);

    Unexpected ->
      io:format("Default case ~p",[Unexpected])
  end.

