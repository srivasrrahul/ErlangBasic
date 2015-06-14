
-module(area_server0).


%% API
%%-export([]).
-compile(export_all).

start() -> spawn(fun loop/0).

area(Pid,What) ->
  rpc(Pid,What).

loop() ->
  receive
    {Pid,{rectangle,W,H}} ->
      %%io:format("Area is ~p~n",[W*H]),
      Pid ! {self(),W*H},
      loop();
    {Pid,{circle,R}} ->
      %%io:format("Area of cicle is ~p~n",[3.14 * R * R]),
      Pid ! {self(),3.14*R*R},
      loop();
    {Pid,_ }->
      Pid ! {self(),error},
      io:format("Area unknown"),
      loop()
  end.

rpc(Pid,Request) ->
  Pid ! {self(),Request},
  receive
    {Pid,Response} ->
      Response
  end.

sleep(T) ->
  receive
    after T ->
      io:format("Slept for ~p msec",[T]),
      true
  end.