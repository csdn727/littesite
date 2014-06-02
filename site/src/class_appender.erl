%% @author man
%% @doc @todo Add description to class_appender.


-module(class_appender).
-behaviour(gen_server).
-include_lib("record.hrl").
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-define(HEADER, [{"Content-Type","text/html,json; charset=utf-8"}]).
-define(SUCCESS, "success").
%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/1]).



%% ====================================================================
%% Behavioural functions 
%% ====================================================================
-record(state, {classname,pickclass,dropclass,limit}).

start_link({Cid,Cname,Cmax})->
    gen_server:start_link({local,erlang:list_to_atom("class_ap_"++Cid)}, ?MODULE, [Cid,Cname,Cmax], []).
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
init([Cid,Cname,Cmax]) ->
    Cid2 = list_to_binary(Cid),
    mysql:connect(db, "localhost", undefined, "root", "0792", "littersite",utf8, true),
    mysql:prepare(erlang:list_to_atom("pick_class_"++Cid),
          <<<<"insert into `class_reg`(`classId`,`userId`,`userName`,`className`) values(">>/binary,Cid2/binary,<<",?,?,?)">>/binary>>),
    mysql:prepare(erlang:list_to_atom("drop_class_"++Cid),
          <<<<"delete from `class_reg` where `classId`=">>/binary,Cid2/binary,<<" and `userId`=?">>/binary>>),
    Num = case mysql:fetch(db, <<<<"select count(`userId`) As num FROM `class_reg` where `classId`=">>/binary,Cid2/binary,<<" group by `userId`">>/binary>>) of
              {data,{mysql_result,_,Data,_,_,_,_,_}} ->
                  case Data of
                      [] ->
                          0;
                      [[Num2]] ->
                          Num2
                  end;
              _ ->
                  0
          end,
    io:format("Num-Cmax------------------------~p,~p,~p~n~n~n",[Num,Cmax,Cmax-Num]),
    {ok, #state{limit=Cmax-Num,classname=Cname,pickclass=erlang:list_to_atom("pick_class_"++Cid),dropclass=erlang:list_to_atom("drop_class_"++Cid)}}.


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
handle_cast({UserId,pickclass,Req}, State) ->
    try
        Headers = ?HEADER,
        io:format("m l f:~p~n", [{?MODULE,?LINE,handle_cast}]),
        case ets:lookup(ets_user, UserId) of
            [User] when is_record(User, user) ->
                Li = State#state.limit,
                if Li > 0 ->
                       Out = mysql:execute(db, State#state.pickclass, [list_to_binary(User#user.userid), User#user.userName,State#state.classname]),
                       io:format("out:~p~n", [{?MODULE,?LINE,Out}]),
                       State2 = State#state{limit= Li-1},
                       Req:respond({200, Headers, ?SUCCESS}),
                       {noreply, State2};
                   true ->
                       Req:respond({200, Headers, "class is full, please choice others"}),
                       {noreply, State}
                end;
            _ ->
                Req:respond({200, Headers, "user not login"}),
                {noreply, State}
        end
    catch
        X:Y->
            io:format("~pwhy:~pReason~p|~n~p~n",[{?MODULE,?LINE},X,Y,erlang:get_stacktrace()]),
            {noreply, State}
    end;
handle_cast({UserId,dropclass,Req}, State) ->
    try
        Headers = ?HEADER,
        io:format("m l f:~p~n", [{?MODULE,?LINE,handle_cast}]),
        case ets:lookup(ets_user, UserId) of
            [User] when is_record(User, user) ->
                Out = mysql:execute(db, State#state.dropclass, [list_to_binary(User#user.userid)]),
                io:format("out:~p~n", [{?MODULE,?LINE,Out}]),
                Req:respond({200, Headers, ?SUCCESS});
            _ ->
                Req:respond({200, Headers, "user not login"})
        end
    catch
        X:Y->
            io:format("~pwhy:~pReason~p|~n~p~n",[{?MODULE,?LINE},X,Y,erlang:get_stacktrace()]),
            {noreply, State}
    end,
    {noreply, State};
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


