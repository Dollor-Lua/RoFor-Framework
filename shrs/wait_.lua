-- wait_.lua
-- 7/17/2020
-- DollorLua (Module setup) | Blizzya (Main function)

--[[

This module is an alternative version of the default 'wait' function.
On the server, the default wait function will slow the server down.

Using this module instead will keep it working fine.

example:

m.wait(time)

]]

local waitController = {}
waitController.__index = waitController

function waitController.wait(val)
	local t = tick()
    repeat game:GetService("RunService").Stepped:Wait() until tick()-t >= val
end

return waitController
