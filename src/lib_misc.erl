%%%-------------------------------------------------------------------
%%% @author richard
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Apr 2015 00:41
%%%-------------------------------------------------------------------
-module(lib_misc).
-author("richard").

%% API
-export([qsort/1, zip/2, consult/1]).

qsort([]) -> [];
qsort([Pivot|T]) -> qsort([X||X <- T,X<Pivot])
                     ++[Pivot]++
                    qsort([X||X <- T,X>Pivot]).

zip(A,B) ->
  zip(A,B,[]).
zip(_,[],Result) ->
  lists:reverse(Result);
zip([],_,Result) ->
  lists:reverse(Result);
zip([A|Atl],[B|Btl],Result) ->
  zip(Atl,Btl,[{A,B}|Result]).


consult(File) ->
  case file:open(File,read) of
    {ok, S} ->
      Val = consultl(S),
      file:close(S),
      {ok,Val};
    {error, Why} ->
      {error, Why}
  end.

consultl(S) ->
  case file:read_line(S) of
    eof         -> [];
    {ok, Term}  -> [Term|consultl(S)];
    Error     -> Error
end.
