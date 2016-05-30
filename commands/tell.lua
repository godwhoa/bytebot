inspect = require 'inspect'
tell = {
  name = ".tell",
  tell = {}
}

-- runs when it matches with command
function tell:execute(user,chan,msg,args)
  to,from = args[2],user.nick

  -- message to send
  -- basically everything before the message i.e .tell,two spaces and to
  i = #to+7
  message = string.sub(msg,i,#msg)

  table.insert(self.tell,{to=to,from=from,message=message,date=os.date("!%c UTC")})
  current.irc:sendChat(chan, "Ok, got it.")

end

-- runs on join
function tell:onjoin(user, chan)
  for i,v in ipairs(self.tell) do
  	print(v.to,user)
    if v.to == user then
      current.irc:sendChat(chan, user.nick..", "..v.from.." left this message for you:"..v.message)
      current.irc:sendChat(chan,"On "..v.date)
      table.remove(self.tell,i)
    end
  end
end

function tell:every(user,chan,message,args)
  for i,v in ipairs(self.tell) do
    if v.to == user.nick then
      current.irc:sendChat(chan, user.nick..", "..v.from.." left this message for you:"..v.message)
      current.irc:sendChat(chan,"On "..v.date)
      table.remove(self.tell,i)
    end
  end
end
return tell
