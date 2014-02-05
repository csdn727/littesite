%% @author man
%% @doc @todo Add description to site_sup.


-module(site_sup).
-behaviour(supervisor).
-export([init/1,start_link/1]).
-include_lib("record.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([]).



%% ====================================================================
%% Behavioural functions 
%% ====================================================================
start_link(_Argv)->
    R = supervisor:start_link({local, ?MODULE}, ?MODULE, []),
    reloader:start_link(),
    supervisor:start_child(?MODULE, config(site_mgr)),
    Out = supervisor:start_child(?MODULE, config(http_serv)),
    mysql:start_link(db,"localhost",3306,"root","0792","littersite",undefined,utf8),
    ets:new('ets_user', [ordered_set,named_table,public,{write_concurrency, true},{keypos,#user.userid}]),
    site_mgr:start(),
    R.

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

config(Name)->
    {Name,
     {Name, start_link ,[Name]},
     permanent,
     10000,
     worker,
     [Name]}.
%% ====================================================================
%% Internal functions
%% ====================================================================


