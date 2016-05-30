timein = {
  name=".timein",
  single=true
}

function sec(hr,min)
  return (hr*60*60) + (min * 60)
end

function timein:execute(user,chan,msg,args)
  -- utc+5:30 india
  india = os.date( "!%a %b %d, %H:%M", os.time() + sec(5,30))
  -- utc+1:00 uk
  uk = os.date( "!%a %b %d, %H:%M", os.time() + sec(1,0))

  if string.sub(msg,1,#self.name) == self.name then
  	current.irc:sendChat(chan,"India: "..india)
  	current.irc:sendChat(chan,"UK: "..uk)
  end
end

return timein
