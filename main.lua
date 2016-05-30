config = require "config"

require "irc.init"
require "hooks"
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
        seen     =  {},
        tell     =  {}
    }
    local s = irc.new(c)
    s:hook("OnChat", onChat)
    s:connect(server);

    for i=1,#channels do
        local c = channels[i]
        local k = keys[i]
        s:join(c, k);
    end

    table.insert(servers, {config = c, irc = s})
end

newServer("siObot", "irc.freenode.net", 6667, {"##sio"}, {""})

while true do
    for i,v in ipairs(servers) do
        current = v
        v.irc:think()
    end
	sleep(2)
end