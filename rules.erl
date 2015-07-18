%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Jul 2015 5:11 PM
%%%-------------------------------------------------------------------
-module(rules).
-author("rasrivastava").

%% API
-export([get_all_stored_rules/0,test/0,rule_basic_check/1]).
-define(CUSTOMER_NAME,customer_name).

get_all_stored_rules() ->
  Rule = [],
  Rule1 = add_rule_based_check(Rule),
  Rule1.

rule_basic_check(Context) ->

  io:format("Applying rules~n"),
  %No name present is problem
  case dict:find(?CUSTOMER_NAME,Context) of
    error ->
      -1;
    {ok,_} ->
      1

  end.

add_rule_based_check(Lst) ->
  UpdatedLst = lists:append(Lst,[fun rules:rule_basic_check/1]),
  UpdatedLst.


test() ->
  Rules = get_all_stored_rules(),
  D = dict:new(),
  D1 = dict:append(?CUSTOMER_NAME,rahul,D),
  lists:map(fun(X) -> X(D1) end , Rules).






