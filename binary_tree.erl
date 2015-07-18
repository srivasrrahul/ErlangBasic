%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc Its basic binary search tree
%%%
%%% @end
%%% Created : 18. Jul 2015 11:19 AM
%%%-------------------------------------------------------------------
-module(binary_tree).
-author("rasrivastava").

%% API
-export([make_binary_tree/1,add_tree/2,find_element/2,test_tree/0]).

make_binary_tree(RootElement) ->
  {RootElement,null,null}.

get_current_element({X,_,_}) -> X.

get_left_link({_,L,_}) -> L.
get_right_link({_,_,R}) -> R.


add_tree(null,Element) ->
  {Element,null,null};
add_tree(CurrentNode,Element) ->
  CurrentElement = get_current_element(CurrentNode),
  case Element < CurrentElement of
    true ->
      LeftLink = add_tree(get_left_link(CurrentNode),Element),
      {get_current_element(CurrentNode),LeftLink,get_right_link(CurrentNode)};
    false ->
      RightLink = add_tree(get_right_link(CurrentNode),Element),
      {get_current_element(CurrentNode),get_left_link(CurrentNode),RightLink}

  end.

find_element(null,_) ->
  null;
find_element(CurrentNode,Element) ->
  CurrentElement = get_current_element(CurrentNode),
  case Element =:= CurrentElement of
    true ->
      CurrentNode;
    false ->
      case  Element < CurrentElement of
        true ->
          find_element(get_left_link(CurrentNode),Element);
        false ->
          find_element(get_right_link(CurrentNode),Element)
      end
  end.


test_tree() ->
  T = make_binary_tree(10),
  T1 = add_tree(T,15),
  T2 = add_tree(T1,12),
  T3 = add_tree(T2,9),
  io:format("Tree is ~p~n",[T3]),
  io:format("~p ~n",[find_element(T3,19)]).