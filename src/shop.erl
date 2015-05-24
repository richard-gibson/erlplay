%%%-------------------------------------------------------------------
%%% @author richard
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. Apr 2015 23:42
%%%-------------------------------------------------------------------
-module(shop).
-author("richard").

%% API
-export([cost/1, total/3, totalPerItemType/1, totalPerItemTypeWithTax/2]).

%% -define(MCOST,#{
%%         oranges  => 1,
%%         newspaper=> 2,
%%         apples   => 3,
%%         pears    => 5,
%%         milk     => 4
%%     }).

-define(MCOST,[
  {oranges,1},
  {newspaper,2},
  {apples,3},
  {pears,5},
  {milk,4}
]).

cost(Lookup) ->
%%     unable to pattern match when key is a variable
%%     ie #{Lookup := V } = mcost(),
  case orddict:find(Lookup,?MCOST) of
      {ok,E} -> E;
      {error} -> 0
    end.


totalPerItemType({What,N}) -> cost(What) * N.
totalPerItemTypeWithTax({What,N}, TaxInc) -> cost(What) * TaxInc * N.
%%foldl
total(foldL,Groceries, CostCalculation) -> lists:foldl(
    fun({What, N},Acc) -> Acc+CostCalculation({What, N}) end,
    0, Groceries);

%% Recursion with List comprehension
total(lComp,Groceries, CostCalculation) -> lists:sum([CostCalculation(Elem) || Elem <- Groceries]);

%% Recursion with anon fun
total(lRec,Groceries, CostCalculation) -> lists:sum(lists:map(fun({What, N}) -> CostCalculation({What, N}) end, Groceries)).

%% Buy = [{oranges,4}, {newspaper,1}, {apples,10}, {pears,6}, {milk,3}].
%% shop:total(foldL,Buy,fun shop:totalPerItemType/1).