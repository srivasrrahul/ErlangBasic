%%%-------------------------------------------------------------------
%%% @author Rahul
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. Jul 2015 2:16 PM
%%%-------------------------------------------------------------------
-module(stack).
-author("Rahul").

%% API
-export([create_stack/0,push/2,pop/1,size/1,test_stack/0]).

create_stack() ->
  [].

push(X,Stack) ->
  [X|Stack].

pop(Stack) ->
  case Stack of
    [X|T] -> {X,T};
    [] -> erlang:error("Stack is empty")
  end.

size(Stack) -> length(Stack).

test_stack() ->
  S = create_stack(),
  S1 = push(1,S),
  S2 = push(2,S1),
  S3 = push(3,S2),
  {X1,S4} = pop(S3),
  io:format("Stack is ~p ~n",[X1]),
  {X2,S5} = pop(S4),
  io:format("Stack is ~p ~n",[X2]),
  {X3,S6} = pop(S5),
  io:format("Stack is ~p ~n",[X3]),
  pop(S6).

