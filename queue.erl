%%%-------------------------------------------------------------------
%%% @author Rahul
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. Jul 2015 2:26 PM
%%%-------------------------------------------------------------------
-module(queue).
-author("Rahul").

%% API
-export([create_queue/0,add/2,remove_q/1,test_queue/0]).

create_queue() ->
  [].

add(Data,Q) ->
  [Data|Q].

remove_internal(_,[]) ->
  erlang:error("No element to remove");
remove_internal(Q,[X|[]]) ->
  {X,lists:reverse(Q)};
remove_internal(Q,[X|Y]) ->
  remove_internal([X|Q],Y).

remove_q(Q) ->
  remove_internal([],Q).

test_queue() ->
  Q = create_queue(),
  Q1 = add(1,Q),
  Q2 = add(2,Q1),
  Q3 = add(3,Q2),
  {X,Q4} = remove_q(Q3),
  {X1,Q5} = remove_q(Q4),
  {X2,Q6} = remove_q(Q5),
  io:format("Values ar ~p~n",[X]),
  io:format("Values ar ~p~n",[X1]),
  io:format("Values ar ~p~n",[X2]).

