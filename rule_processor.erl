%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Jul 2015 8:29 AM
%%%-------------------------------------------------------------------
-module(rule_processor).
-author("rasrivastava").

%% API
-export([test_code/0]).
%%-include("rules.erl").



start_nano_server() ->
  RulesTable = rules:get_all_stored_rules(),
  {ok,ListenSocket} = gen_tcp:listen(2345,[binary,{packet,4},
    {reuseaddr,true},
    {active,true}]),
%%   {ok,Socket} = gen_tcp:accept(ListenSocket),
%%   spawn(fun() -> loop(Socket) end),
%%   io:format("Socket connected successfully"),
  mainLoop(ListenSocket,RulesTable).


mainLoop(ListenSocket,RulesTable) ->
  io:format("Entering to main loop"),
  {ok,Socket} = gen_tcp:accept(ListenSocket),
  io:format("Recieved new connection\n"),
  spawn(fun() -> mainLoop(ListenSocket,RulesTable) end),

  handle_message(Socket,RulesTable).


iterate_and_apply_rules(MessageVal,RulesTable) ->
  case RulesTable of
    [Rule|RuleTable] ->
      Val = Rule(MessageVal) + iterate_and_apply_rules(MessageVal,RuleTable),
      Val;
    [] -> 0
  end.

apply_rules(MessageVal,RulesTable) ->

  iterate_and_apply_rules(MessageVal,RulesTable).


handle_message(Socket,RulesTable) ->
  receive
    {tcp,Socket,Message} ->
      <<HeaderVal:8,MessageVal/binary>> = Message,
      case HeaderVal of
        1 ->
          io:format("Apply rules recieved"),
          apply_rules(MessageVal,RulesTable)
      end

  end.


test_code() ->
  Rules = rules:get_all_stored_rules(),
  D0 = dict:new(),
  D1 = dict:append(customer_name,"rahul",D0),
  iterate_and_apply_rules(D1,Rules).