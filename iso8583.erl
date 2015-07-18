%%%-------------------------------------------------------------------
%%% @author Rahul
%%% @copyright (C) 2015, Self
%%% @doc
%%%
%%% @end
%%% Created : 09. Jul 2015 8:15 AM
%%%-------------------------------------------------------------------
-module(iso8583).
-author("rasrivastava").

%% API
-export([update_mti/2,test_code/0]).
%%All other record types have no types
-record(primary_bit_map,{pan,processing_code,amount,transmission_date_and_time,system_trace_number,card_expiration_date}).
-record(secondary_bit_map,{}).
-record(iso8583msg, {mti,primary_bit_map = #primary_bit_map{},secondary_bit_map = #secondary_bit_map{}}).

update_mti(Iso8583Msg,Mti) ->
  UpdatedRecord = Iso8583Msg#iso8583msg{mti = Mti},
  UpdatedRecord.

update_pan(Iso8583Msg,PanNumber) ->
  UpdatedRecord = Iso8583Msg#iso8583msg#primary_bit_map{pan=PanNumber},
  UpdatedRecord.
%%
%% update_processing_code(Iso8583Msg,ProcessingCode) ->
%%   UpdatedRecord = Iso8583Msg#iso8583msg#primary_bit_map{processing_code=ProcessingCode},
%%   UpdatedRecord.
%%
%% update_amount(Iso8583Msg,Amount) ->
%%   UpdatedRecord = Iso8583Msg#iso8583msg#primary_bit_map{amount=Amount},
%%   UpdatedRecord.
%%
%% update_transmission_date_time(Iso8583Msg,TranmissionDateAndTime) ->
%%   UpdatedRecord = Iso8583Msg#iso8583msg#primary_bit_map{transmission_date_and_time=TranmissionDateAndTime},
%%   UpdatedRecord.
%%
%% update_system_trace_number(Iso8583Msg,SystemTraceNumber) ->
%%   UpdatedRecord = Iso8583Msg#iso8583msg#primary_bit_map{system_trace_number=SystemTraceNumber},
%%   UpdatedRecord.
%%
%% update_card_expiration_date(Iso8583Msg,CardExpirationDate) ->
%%   UpdatedRecord = Iso8583Msg#iso8583msg#primary_bit_map{card_expiration_date =CardExpirationDate},
%%   UpdatedRecord.


encode_mti(Iso8583Msg,EncodedMsgThusFar) ->
  Mti = Iso8583Msg#iso8583msg.mti,
  case Mti of
    100 -> Value = [EncodedMsgThusFar,<<0:4,1:4,0:8>>],
      Value

  end.


encode_pan(Iso8583Msg,EncodedMsgThusFar) ->
  Pan = Iso8583Msg#iso8583msg.primary_bit_map#primary_bit_map.pan,

  Pan.

  %%Encode PAN first




test_code() ->
  Iso8583Msg = #iso8583msg{mti=100},
  X = <<>>,
  Y = encode_mti(Iso8583Msg,X),
  Y.
















