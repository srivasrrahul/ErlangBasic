%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. Jul 2015 9:33 PM
%%%-------------------------------------------------------------------
-module(file_processing).
-author("rasrivastava").

%% API
-export([file_read/1]).

file_read(FileName) ->
  case file:open(FileName,read) of
    {ok,Fd} -> read_file(Fd);
    _ -> io:format("Error in reading file")

  end.

read_file(Fd) ->
  case io:get_line(Fd,'') of
    eof -> io:format("File end recievced");
    Data -> io:format("~p",[Data]),
      read_file(Fd)
  end.