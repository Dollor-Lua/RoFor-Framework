-- events.lua
-- DollorLua
-- July 8, 2020

--[[

Example usage:
	
local events = require(events)

local event = events.new()

event:Connect(function(args)
	-- run code here
end)

event:Fire(arguments)

event:Disconnect() -- allows you to disconnect any code used on the event.
event:Rid() -- gets rid of the event completely.

====================

This module is similar to the AeroGameFramework event module.
Same usual things the other framework says but coded in a different way.

If you are advanced at coding and you want to edit this go ahead at it.
Make sure you don't break anything at it! If you do you can always re-insert
the framework.

--]]

local sel = select
local unp = unpack

local events = {}
events.__index = events

function events.new()
	
	local self = setmetatable({
		_destroyed = false,
		_fired = false,
		_event = Instance.new("BindableEvent"),
	}, events)
	
	return self
	
end

function events:Fire(...) -- when you use fire it sends all arguments as "..."
	self._args = {...}
	self._argsCount = sel('#',...)
	self._event:Fire()
end

function events:Connect(f) -- connects it for use.
	if self._destroyed then error('Cannot connect to a non existant event.') end
	if type(f) ~= 'function' then error('Argument is not a valid function, plese use a function.') end
	
	return self._event.Event:Connect(function()
		f(unp(self._args,1,self._argsCount)) -- returns every argument as a single parameter each.
	end)
end

function events:Disconnect() -- resets the event
	self._event:Remove() -- destroys it
	self._event = Instance.new("BindableEvent") -- adds it back
end

function events:Rid() -- destroying the event completely
	if self._destroyed then warn('The event you tried to destroy is already destroyed!') return end
	self._destroyed = true
	self._event:Remove()
end

return events
