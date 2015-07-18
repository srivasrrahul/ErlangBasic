%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. Jul 2015 3:09 PM
%%%-------------------------------------------------------------------
-module(trie).
-author("rasrivastava").

%% API
-export([add_char/2,test_trie/0]).


make_trie_node(WordFlag) ->
  {WordFlag,maps:new()}.

add_char([X|[]],{_,Links}) ->
  case maps:is_key(X,Links) of
    true ->
      {true,Links};
    false ->
      io:format("In false~n"),
      UpdatedLink = Links#{X => make_trie_node(false)},
      {true,UpdatedLink}

  end;
add_char([X|Y],{V,Links}) ->
  case maps:is_key(X,Links) of
    true ->
      io:format("In true~n"),
      NextNode = maps:get(X,Links),
      {_,ReturnedLink} = add_char(Y,NextNode),
      UpdatedLink = Links#{X => ReturnedLink},
      {V,UpdatedLink};
    false ->
      io:format("In false~n"),
      {_,ReturnedLink} = add_char(Y,make_trie_node(false)),
      UpdatedLink= Links#{X => ReturnedLink},
      {V,UpdatedLink}

  end.

test_trie() ->
  X = make_trie_node(false),
  X1 = add_char("hello",X),
  io:format("Tree is ~p",[X1]).
