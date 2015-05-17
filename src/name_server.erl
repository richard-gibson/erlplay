%%%-------------------------------------------------------------------
%%% @author richard
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. May 2015 22:12
%%%-------------------------------------------------------------------
-module(name_server).
-author("richard").

%% API
-export([add/2, find/1, init/0, handle/2]).
-import(server1, [rpc/2]).

add(Name,Place) -> rpc(name_server, {add, Name, Place}).
find(Name) -> rpc(name_server, {find, Name}).

init() -> maps:new().
handle({add, Name, Place}, Map) -> {ok, maps:put(Name, Place, Map)};
handle({find, Name}, Map) -> {maps:find(Name, Map), Map}.