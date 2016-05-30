-- Basic template --


-- store the data you need here
-- name is needed, it'll use that for command matching.

sample = {
	name=".sample"
}

-- runs when it matches name
function sample:execute(user,chan,msg,args)
end

-- runs on every message
function sample:every(user,chan,message,args)
end

-- runs on join
function sample:onjoin(user, chan)
end

-- runs on leave
function sample:onleave(user, chan)
end

-- next:
-- sample = require "commands.sample" in main.lua
-- add sample to commands array in main.lua
-- done.

-- note: if you are doing commands that taken no arguments then have a look at echo.lua.

return sample