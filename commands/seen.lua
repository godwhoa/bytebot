seen = {
  name = ".seen",
  seen = {}
}


function seen:execute(user,chan,msg,args)
  date = self.seen[user.nick]
  if date == nil then
    current.irc:sendChat(chan,"Unkown")
  else
    current.irc:sendChat(chan,"Last seen on "..date)
  end
end

function seen:onjoin(user, chan)
  self.seen[user.nick] = os.date("%c")
end

function seen:onleave(user, chan)
  self.seen[user.nick] = os.date("%c")
end

function seen:every(user,chan,message,args)
  self.seen[user.nick] = os.date("%c")
end
return seen
