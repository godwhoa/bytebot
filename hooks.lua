function onChat(user, channel, message)
	aretell = string.sub(message,1,6)
	if string.find(aretell, ".tell ", 1, 6) then
		a, b = string.find(message, ".tell")
		c = string.find(message, " ", 7)
		if a == nil or b == nil or c == nil then
			return
		else
			nick = string.sub(message, b+2, c-1)
			message = string.sub(message, b+2)

			table.insert(current.config.tell, {from = user.nick, to = nick, message = message})

			current.irc:sendChat(channel, "Ok, got it.")
		end
	end

	areecho = string.sub(message,1,string.len(config.highlight_name.."!"))
	if string.find(areecho, config.highlight_name.."!") then
		current.irc:sendChat(channel, user.nick.."!")
	end

	for i,v in ipairs(current.config.tell) do
		if user.nick == v.to then
			current.irc:sendChat(channel, v.from.." left this message for you: "..v.message)
			table.remove(current.config.tell, i)
		end
	end

	areseen = string.sub(message,1,6)
	if string.find(areseen, ".seen ", 1, 6) then
		nick = string.sub(message,7)
		if current.config.seen[nick] then
			current.irc:sendChat(channel, nick.." was last seen on " .. current.config.seen[nick])
		end

	end

	current.config.seen[user.nick] = os.date()
end
