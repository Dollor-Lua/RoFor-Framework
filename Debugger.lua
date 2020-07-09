local m = {}

local continueDebugging = true
local continueAfterError = true

function m.StartDebugging()
	warn('This may take a bit to debug! You can stop debugging with module.StopDebugging()')
	
	continueDebugging = true
	for i,v in pairs(script.Parent:GetDescendants()) do
		if continueDebugging and v:IsA("ModuleScript") then
			local s,e = pcall(function()
				local m = require(v)
			end)
			
			if not s then
				warn("An error occured while processing the module '"..v.Name..". | ".. e)
			end
		
			wait()
		else
			return true
		end
	end
	
	return true
end

function m.StopDebugging()
	continueDebugging = false
	return true
end

function m.SetContinueAfterError(v)
	if type(v) == 'boolean' then
		continueAfterError = v
	else
		warn('debugger error >> invalid bool (must be true or false).')
	end
end

return m
