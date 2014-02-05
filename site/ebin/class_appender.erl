%% @author man
%% @doc @todo Add description to class_appender.


-module(class_appender).
-behaviour(gen_server).
-include_lib("record.hrl").
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/1]).



%% ====================================================================
%% Behavioural functions 
%% ====================================================================
-record(state, {}).

start_link({Cid,Cname})->
    gen_server:start_link({local,erlang:list_to_atom("class_ap_"++Cid)}, ?MODULE, [{Cid,Cname}], []).
%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, State}
			| {ok, State, Timeout}
			| {ok, State, hibernate}
			| {stop, Reason :: term()}
			| ignore,
	State :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([{Cid,Cname}]) ->
    mysql:connect(db, "localhost", undefined, "root", "0792", "littersite",
          true),
    mysql:prepare(pick_class,
          list_to_binary("insert into `class_reg`(`classId`,`userId`,`userName`,`className`) values("++Cid++",?,?,'"++binary_to_list(Cname)++"')")),
    mysql:prepare(drop_class,
          list_to_binary("delete * from `class_reg` where `classId`="++Cid++" and `userId`=?")),
    {ok, #state{}}.


%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
	Result :: {reply, Reply, NewState}
			| {reply, Reply, NewState, Timeout}
			| {reply, Reply, NewState, hibernate}
			| {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason, Reply, NewState}
			| {stop, Reason, NewState},
	Reply :: term(),
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity,
	Reason :: term().
%% ====================================================================
handle_call(Request, From, State) ->
    Reply = ok,
    {reply, Reply, State}.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Request :: term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast({UserId,pickclass,Req}, _State) ->
    try
        io:format("m l f:~p~n", [{?MODULE,?LINE,handle_cast}]),
        case ets:lookup(ets_user, UserId) of
            User when is_record(User, user) ->
                Out = mysql:execute(db, pick_class, [list_to_binary(User#user.userid), list_to_binary("'"++User#user.userName++"'")]),
                io:format("out:~p~n", [{?MODULE,?LINE,Out}]),
                Headers = [{"Allow", "GET,PUT,DELETE"}],
                Req:respond({200, Headers, "success"});
            _ ->
                ok
        end
    catch
        X:Y->
            io:format("~pwhy:~pReason~p|~n~p~n",[{?MODULE,?LINE},X,Y,erlang:get_stacktrace()])
    end,
    {noreply, _State};
handle_cast({UserId,dropclass,Req}, _State) ->
    try
        io:format("m l f:~p~n", [{?MODULE,?LINE,handle_cast}]),
        case ets:lookup(ets_user, UserId) of
            User when is_record(User, user) ->
                mysql:execute(db, drop_class, [list_to_binary(User#user.userid)]),
                Headers = [{"Allow", "GET,PUT,DELETE"}],
                Req:respond({200, Headers, "success"});
            _ ->
                ok
        end
    catch
        X:Y->
            io:format("~pwhy:~pReason~p|~n~p~n",[{?MODULE,?LINE},X,Y,erlang:get_stacktrace()])
    end,
    {noreply, _State};
handle_cast(Msg, State) ->
    {noreply, State}.


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_info(Info, State) ->
    {noreply, State}.


%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
	Reason :: normal
			| shutdown
			| {shutdown, term()}
			| term().
%% ====================================================================
terminate(Reason, State) ->
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
	Result :: {ok, NewState :: term()} | {error, Reason :: term()},
	OldVsn :: Vsn | {down, Vsn},
	Vsn :: term().
%% ====================================================================
code_change(OldVsn, State, Extra) ->
    {ok, State}.


%% ====================================================================
%% Internal functions
%% ====================================================================


