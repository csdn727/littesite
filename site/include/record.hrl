-record(user,{
              userid,
              userName,
              userIp,
              time}).

-define(HTTP_OPTS, [
            {loop, {http_serv, dispatch}},
            {port, 8442},
            {name, http_serv_8442}
            ]).
-record(resource, {type, data}).