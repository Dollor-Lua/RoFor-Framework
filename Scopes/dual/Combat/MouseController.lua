-- MouseController.lua
-- 7/17/2020
-- DollorLua

--[[

This module allows you to work with the mouse easily

Must be used in a local script.

Example Usage:

local e = m.new()
e:Enable()

e.Click:Connect(function(inpType)
	-- do something here
end)

local vector3Pos = e:GetHit(true)
local cframePos = e:GetHit(false)

local part_That_The_Mouse_Touches = e:GetTarget()

e:Disable()

e:Rid()

---------------------------

Upcoming: RMB and MMB support.

]]

local m = {}
m.__index = m

function m.new()
	local event = Instance.new("BindableEvent")
	
	local self = setmetatable({
		_destroyed = false,
		_enabled = false,
		_eventClicked = nil,
		_eventClicked2 = nil,
		_eventClicked3 = nil,
		
		_event = event,
		Click = event.Event
	}, m)
end

function m:GetHit(isVector3)
	local plr = game.Players.LocalPlayer
	local mouse = plr:GetMouse()
	
	if isVector3 then
		return mouse.Hit.p
	else
		return mouse.Hit
	end
end

function m:GetTarget()
	local plr = game.Players.LocalPlayer
	local mouse = plr:GetMouse()
	
	return mouse.Target
end

function m:Enable()
	if self._enabled then warn('This click controller event is already enabled!') return end
	
	if self._enabled == nil then return end
	
	self._enabled = true
	
	local plr = game.Players.LocalPlayer
	local mouse = plr:GetMouse()
	
	self._eventClicked = mouse.Button1Down:Connect(function()
		self._event:Fire(Enum.UserInputState.Begin)
	end)
	
	self._eventClicked2 = mouse.Button1Up:Connect(function()
		self._event:Fire(Enum.UserInputState.End)
	end)
	
	self._eventClicked3 = mouse.Move:Connect(function()
		self._event:Fire(Enum.UserInputState.Change)
	end)
end

function m:Disable()
	if not self._enabled then warn('This click controller event is already disabled!') return end
	
	self._enabled = false
	
	self._eventClicked:Disconnect()
	self._eventClicked = nil
	
	self._eventClicked2:Disconnect()
	self._eventClicked2 = nil
	
	self._eventClicked3:Disconnect()
	self._eventClicked3 = nil
end

function m:Rid()
	if self._destroyed then warn('This click controller event is already destroyed!') return end
	
	self._destroyed = true
	
	self:Disable()
	
	self._event:Destroy()
	self._event = nil
	self.Click = nil
	self._enabled = nil
end

return m
