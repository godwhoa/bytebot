config = require "config"

require "irc.init"
require "hooks"
echo   = require "commands.echo"
seen   = require "commands.seen"
tell   = require "commands.tell"
timein = require "commands.timein"
local sleep = require "socket".sleep

servers = {}
current = nil

function newServer(nick, server, port, channels, keys, username)
    local c = {
        nick     =  nick,
        username =  username,
        server   =  server,
        channels =  channels,
        keys     =  keys,
        port     =  port,
        commands =  {echo,seen,tell,timein}
    }

    local s = irc.new(c)
    s:hook("OnChat", onChat)
    s:hook("OnJoin", onJoin)
    s:hook("OnQuit", onLeave)

    s:connect(server);

    for i=1,#channels do
        local c = channels[i]
        local k = keys[i]
        s:join(c, k);
    end

    table.insert(servers, {config = c, irc = s})
end

newServer("bytebot_dev", "irc.freenode.net", 6667, {"##oodnet"}, {""})

while true do
    for i,v in ipairs(servers) do
        current = v
        v.irc:think()
    end
	sleep(0.5)
end