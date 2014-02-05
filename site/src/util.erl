%% @author man
%% @doc @todo Add description to util.


-module(util).

%% ====================================================================
%% API functions
%% ====================================================================
-export([seconds/0,double_validate/4]).

seconds() ->
    {MegaSecs, Secs, _MicroSecs} = erlang:now(),
    1000000 * MegaSecs + Secs.

%% 检查IP和时间有效性
double_validate(S1,S2,Ip1,Ip2) ->
    Tdiff = abs(S1-S2),
    if Tdiff < 1800 andalso Ip1 =:= Ip2 -> %半小时有效
           true;
       true ->
           false
    end.

%% ====================================================================
%% Internal functions
%% ====================================================================


