%%%-------------------------------------------------------------------
%%% @author rasrivastava
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2015 9:06 AM
%%%-------------------------------------------------------------------
-module(recursive).
-author("rasrivastava").

%% API
%%-export([]).
-compile(export_all).
fac(N) when N == 0 -> 1;
fac(N) when N > 0 -> N * fac(N-1).

