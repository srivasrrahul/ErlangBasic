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
%%     {sendData,SendMsg} ->
%%       io:format("Data is now being sent to socket~n"),
%%       gen_tcp:send(Socket,SendMsg),
%%       %%From ! sent,
%%       perform_chat(Socket,ListenHandler);

    {tcp,Socket,BinData} ->
      io:format("Data recieved from other end~n"),
      ListenHandler ! {dataReceieved,BinData},
      perform_chat(Socket,ListenHandler);
    {tcp_closed,Socket} ->
      io:format("Server closed the connection~n"),
      ListenHandler ! serverClosedConnection
  end.


recieveDataProcesssor() ->
  receive
    {dataReceieved,BinData} ->
      io:format("data recvd is ~p ~n",[BinData]),
      recieveDataProcesssor();
    {serverClosedConnection} ->
      io:format("Server closed connection~n")
  end.

extract_user_input(Sender,Socket) ->
%%   io:format("Inside extract user input~n"),
%%   SendMessage = createSendMessage(<<"rahul">>),
%%   Sender ! {sendData,SendMessage},
%%   timer:sleep(1000),
%%   extract_user_input(Sender).

  case io:get_line("Enter the data >") of
    eof ->
      io:format("Input closed");
    Line ->
      io:format("Line recieved"),
      SendMessage = createSendMessage(Line),
      %RetValue = Sender ! {sendData,self(),SendMessage},
      %io:format("Return value is ~p~n",[RetValue]),
      gen_tcp:send(Socket,SendMessage),
      extract_user_input(Sender,Socket)

  end.



nano_get_url(Host) ->
  {ok,Socket} = gen_tcp:connect(Host,2345,[binary,{packet,4}]),
  io:format("Connected socket successfully~n"),
  Message = connectMessage(),
  ok = gen_tcp:send(Socket,Message),
  %% Now connected
  Listener = spawn(fun() -> recieveDataProcesssor() end),
  spawn(fun() -> extract_user_input(self(),Socket) end),
  %%timer:sleep(1000),
  perform_chat(Socket,Listener).

  %Sender = spawn(fun() -> perform_chat(Socket,Listener) end),
  %extract_user_input(Sender).
