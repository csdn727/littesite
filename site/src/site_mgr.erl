%% @author man
%% @doc @todo Add description to site_mgr.


-module(site_mgr).
-behaviour(supervisor).
-export([init/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/1, start/0,dispatch/1]).



%% ====================================================================
%% Behavioural functions 
%% ====================================================================
-record(state, {}).

start_link(_Name)->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).
start()->
    {data,{mysql_result,_,Data,_,_,_,_,_}} = mysql:fetch(db, <<"SELECT `classId`,`className`,`classMax` FROM `class_info`">>),
    start_class(Data).    
%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/supervisor.html#Module:init-1">supervisor:init/1</a>
-spec init(Args :: term()) -> Result when
    Result :: {ok, {SupervisionPolicy, [ChildSpec]}} | ignore,
    SupervisionPolicy :: {RestartStrategy, MaxR :: non_neg_integer(), MaxT :: pos_integer()},
    RestartStrategy :: one_for_all
                     | one_for_one
                     | rest_for_one
                     | simple_one_for_one,
    ChildSpec :: {Id :: term(), StartFunc, RestartPolicy, Type :: worker | supervisor, Modules},
    StartFunc :: {M :: module(), F :: atom(), A :: [term()] | undefined},
    RestartPolicy :: permanent
                   | transient
                   | temporary,
    Modules :: [module()] | dynamic.
%% ====================================================================
init([]) ->
    {ok,
     {
       {one_for_one,3,10}, 
       []
      }
    }.

dispatch({ClassId,UserId,Comm,Req})->
    try
    gen_server:cast(erlang:list_to_atom("class_ap_"++ClassId), {UserId,Comm,Req})
    catch
    exit:noproc ->
        {error, no_such_logger}
    end.
%% ====================================================================
%% Internal functions
%% ====================================================================
start_class([[Cid,Cname,Cmax]|T]) ->
    Cid2 = erlang:integer_to_list(Cid),
    C1 = {erlang:list_to_atom("class_"++Cid2),
      {class_appender, start_link ,[{Cid2,Cname,Cmax}]},
      temporary,
      10000,
      worker,
      [class_appender]},
    Out = supervisor:start_child(?MODULE, C1),
    io:format("class_~p---Out:~p~n",[{Cid2,Cname},Out]),
    start_class(T);
start_class([])->
    ok.


