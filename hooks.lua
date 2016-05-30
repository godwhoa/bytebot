function tokenized(inputstr)
	sep = " "
    if sep == nil then
    	sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end

function onChat(user, channel, message)
	for k,v in ipairs(current.config.commands) do
		if string.sub(message,1,#v.name+1) == v.name.." " and v.execute ~= nil then
			args = tokenized(message)
			v:execute(user,channel,message,args)
		end
		if v.single then
			args = tokenized(message)
			v:execute(user,channel,message,args)
		end
		if v.every ~= nil then
			v:every(user,channel,message,args)
		end
	end
end

function onJoin(user, channel)
	for k,v in ipairs(current.config.commands) do
		if v.onjoin ~= nil then
			v:onjoin(user,channel)
		end
	end
end

function onLeave(user, channel)
	for k,v in ipairs(current.config.commands) do
		if v.onleave ~= nil then
			v:onleave(user,channel)
		end
	end
end