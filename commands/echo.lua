echo = {
  name = config.highlight_name.."!",
  single = true
}


function echo:execute(user,chan,msg,args)
	if string.sub(msg,1,#self.name) == self.name then
		current.irc:sendChat(chan,user.nick.."!")
	end
end

return echo
