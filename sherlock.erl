-module(sherlock).
-author("Richo Healey, richo@psych0tik.net").
-export([start/0, start/1]).

-define(NICK, "shERLock").
-define(REALNAME, "shERLock").

% TODO Stub these out into configurables
server() ->
    "irc.freenode.net".
channel() ->
    "#richo".
port() ->
    6667.
use_ssl() ->
    false.

start() ->
    client(server(), port(), channel(), use_ssl()).

start(Server) ->
    client(Server, port(), channel(), use_ssl()).

client(Server, Port, Channel, UseSSL) ->
    {ok, Socket} = gen_tcp:connect(Server, Port, [binary, {packet, 0}, {active, false}]),
    initialize(Socket),
    join(Socket, Channel),
    timer:sleep(15).

initialize(Socket) ->
    send(Socket, "USER " ++ ?NICK ++ " 8 * :" ++ ?REALNAME),
    send(Socket, "NICK " ++ ?NICK).

join(Socket, Channel) ->
    send(Socket, "JOIN " ++ Channel).

send(Socket, Text) ->
    io:format("~p~n", [Text]),
    gen_tcp:send(Socket, list_to_binary(Text ++ "\r\n")).
