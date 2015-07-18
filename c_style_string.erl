%%%-------------------------------------------------------------------
%%% @author Rahul
%%% @copyright (C) 2015, Anybody to view and change provided writer is informed
%%% @doc
%%% This file provided capability to have C++ style strings sans \0 at end.
%%% It stores in strings in bit string format so access of a string and length etc is O(1) operation.
%%% @end
%%% Created : 17. Jul 2015 9:53 AM
%%%-------------------------------------------------------------------
-module(c_style_string).
-author("Rahul").

%% API
-export([test_code/0,
  make_string/0,
  length_str/1,
  append_single_byte_char/2,
  get_index_val/2,
  append_string/2,
  find_char/2,
  sub_string/2,
  compare_string/2,
  serialize_string/1,
  deserialize_string/1
  ]).

-record(basic_string,{
  lst = <<>>,
  len = 0
}).

make_string() ->
  #basic_string{}.

internal_make_string(Lst,Len) ->
  #basic_string{lst = Lst,len = Len}.

length_str(BasicString) ->
  #basic_string{lst=_,len = Len} = BasicString,
  Len.

get_deep_binary(BasicString) ->
  #basic_string{lst = Bin,len=_} = BasicString,
  Bin.

append_single_byte_char(BasicString,Ch) ->
  Bin = get_deep_binary(BasicString),
  L = length_str(BasicString),
  Bin1 = <<Bin/binary,Ch>>,
  #basic_string{lst = Bin1,len = L + 1}.

get_index_val(BasicString,Index) ->
  Bin = get_deep_binary(BasicString),
  BitSize = (Index-1)*8,
  <<_:BitSize/bitstring,Val:8,_/binary>> = Bin,
  Val.

append_string(BasicString,S) ->
  Bin = get_deep_binary(BasicString),
  Bin1 = get_deep_binary(S),
  L = length_str(BasicString),
  L1 = length_str(S),
  BinUpdated = <<Bin/binary,Bin1/binary>>,
  #basic_string{lst = BinUpdated,len = L + L1}.

find_string_internal(<<CharValue:8,_/binary>>,CharValue,Index) ->
  Index;
find_string_internal(<<CharValueDiff:8,Rest/binary>>,CharValue,Index) ->
  find_string_internal(Rest,CharValue,Index+1);
find_string_internal(<<>>,_,_) ->
  -1.

find_char(BasicString,CharValue) ->
  Bin = get_deep_binary(BasicString),
  find_string_internal(Bin,CharValue,0).

sub_string(BasicString,IndexVal) ->
  Bin = get_deep_binary(BasicString),
  BitSize = (IndexVal-1)*8,
  <<_:BitSize/bitstring,Val/binary>> = Bin,
  L = length_str(Bin),
  internal_make_string(Val,L-IndexVal).


compare_bin_internal(<<>>,<<>>) ->
  0;
compare_bin_internal(_,<<>>) ->
  1;
compare_bin_internal(<<>>,_) ->
  -1;
compare_bin_internal(Bin1,Bin2) ->
  <<X1:8,Rest1/binary>> = Bin1,
  <<X2:8,Rest2/binary>> = Bin2,
  case X1 == X2 of
    true ->
      compare_bin_internal(Rest1,Rest2);
    false ->
      case X1 < X2 of
        true -> -1;
        false -> 1
      end
  end.


compare_string(S1,S2) ->
  Bin1 = get_deep_binary(S1),
  Bin2 = get_deep_binary(S2),
  compare_bin_internal(Bin1,Bin2).

serialize_string(S1) ->
  B1 = get_deep_binary(S1),
  B2 = binary:copy(B1),
  B2.

deserialize_string(BinaryData) ->
  S = internal_make_string(BinaryData,size(BinaryData)),
  S.

test_code() ->
  S = make_string(),
  S1 = append_single_byte_char(S,$h),
  S2 = append_single_byte_char(S1,$e),
  S3 = append_single_byte_char(S2,$e),
  S4 = append_single_byte_char(S3,$e),
  I = find_char(S4,$e),
  io:format("Index is  ~p~n",[I]),
  Rc = compare_string(S2,S1),
  io:format("~p~n",[Rc]),
  S5 = serialize_string(S4),
  S6 = deserialize_string(S5),
  io:format("Final string is~p~n",[S5]).














