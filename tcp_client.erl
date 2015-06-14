%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Jun 2015 5:03 PM
%%%-------------------------------------------------------------------
-module(tcp_client).
-author("rasrivastava").

%% API
-export([get_url/1]).

get_url(HostName) -> nano_get_url(HostName).

connectMessage() ->
  Header = <<1>>,
  Name = <<"rahul">>,
  [Header,Name].

createSendMessage(Msg) ->
  Header = <<2>>,
  [Header,Msg].

perform_chat(Socket,ListenHandler) ->
  receive
    {From,sendData,SendMsg} ->
      ok = gen_tcp:send(Socket,SendMsg),
      From ! sent,
      perform_chat(Socket,From);

    {tcp,Socket,BinData} ->
      ListenHandler ! {dataReceieved,BinData},
      perform_chat(Socket,ListenHandler);
    {tcp_closed,Socket} ->
      io:format("Server closed the connection"),
      ListenHandler ! serverClosedConnection
  end.


recieveDataProcesssor() ->
  receive
    {dataReceieved,BinData} ->
      io:format("data recvd is ~p ~n",[BinData]),
      recieveDataProcesssor;
    {serverClosedConnection} ->
      io:format("Server closed connection~n")
  end.

extract_user_input(Sender) ->
  case io:get_line("Enter the data >") of
    eof ->
      io:format("Input closed");
    Line ->
      SendMessage = createSendMessage(Line),
      Sender ! {self(),sendData,SendMessage},
      extract_user_input(Sender)

  end.



nano_get_url(Host) ->
  {ok,Socket} = gen_tcp:connect(Host,2345,[binary,{packet,4}]),
  io:format("Connected socket successfully"),
  Message = connectMessage(),
  ok = gen_tcp:send(Socket,Message),
  %% Now connected
  Listener = spawn(fun() -> recieveDataProcesssor() end),
  Sender = spawn(fun() -> perform_chat(Socket,Listener) end),
  extract_user_input(Sender).
