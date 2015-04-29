%%%-------------------------------------------------------------------
%%% @author richard
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Apr 2015 21:53
%%%-------------------------------------------------------------------
-module(erlplay).
-author("richard").

%% API
-export([start/0]).

start() ->
  Handle = bitcask:open("erlplay_database", [read_write]),
  ErlplayKey = <<"erlplay_executions">>,
  N = fetch(Handle,ErlplayKey),
  store(Handle,ErlplayKey, N+1),
  io:format("Application has been run ~p times~n",[N]),
  bitcask:close(Handle),
  init:stop().

store(Handle,PutKey,N) ->
  bitcask:put(Handle, PutKey, term_to_binary(N)).

fetch(Handle,GetKey) ->
  case bitcask:get(Handle,GetKey) of
    not_found -> 1;
    {ok, Bin} -> binary_to_term(Bin)
  end.