%%%-------------------------------------------------------------------
%%% @author richard
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. Apr 2015 22:43
%%%-------------------------------------------------------------------
-module(geometry).
-author("richard").

%% API
-export([calc_area/0, rpc/2, rpc_wrapper/2]).

area({rectangle,Width,Height}) -> Width * Height;
area({circle,Radius}) -> 3.14 * Radius * Radius;
area({square,Side}) -> Side * Side.


%% retrieving responses from processes blocks
%% wonder if futures can be created?
rpc_wrapper(Pid, Request) ->
  io:format("making rpc call~n"),
  Rpc = rpc(Pid,Request),
  io:format("call made~n"),
  io:format("results: ~p~n", [Rpc]).

rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    Response ->
      Response
  end.

calc_area() ->
  receive
    {Sender, {rectangle,_,_} = Rec} ->
      timer:sleep(2000),
      Sender ! area(Rec),
      calc_area();
    {Sender, {circle,_} = Circ} ->
      Sender ! area(Circ),
      calc_area();
    {Sender, {square,_} = Sq} ->
      Sender ! area(Sq),
      calc_area();
    {Sender, Other} ->
      Sender !{error,Other},
      calc_area()
  end.