-- ButtonDefaults.lua
-- DollorLua
-- July 9, 2020

--[[

Example Usage:

local pc = require(framework.plugins.Constructor)
local bd = require(framework.plugins.ButtonDefaults)

local tb = pc.newToolbar("Custom Toolbar A!")
local b = pc.newButton('name', 'this is a description', 'rbxassetid://0', tb)

local b2 = bd.new(b)

b2:EnableConnect()

b2.clicked:Connect(function()
	print('plugin button was clicked')
end)

======================================

This helps connect your buttons to your guis.
a clicked property, and a enabled propery.

2 functions to help you connect the enabling to your gui.

:EnableConnect()
:EnableOnClick(gui)

]]


local bd = {}
bd.__index = bd

function bd.new(button)
	
	local e = Instance.new("BindableEvent")
	
	local self = setmetatable({
		_button = button,
		_event = e,
		_connection = nil,
		
		clicked = e.Event,
		enabled = false
	}, bd)
	
	return self
end

function bd:EnableOnClick(gui)
	if gui:IsA("GuiObject") then
		gui.Visible = false
		self.enabled = false
		
		self._connection = self._button.Click:Connect(function()
			self.enabled = not self.enabled
			gui.Visible = self.enabled
			self._event:Fire()
		end)
	elseif gui:IsA('ScreenGui') then
		gui.Enabled = false
		self.enabled = false
		
		self._connection = self._button.Click:Connect(function()
			self.enabled = not self.enabled
			gui.Enabled = self.enabled
			self._event:Fire()
		end)
	end
end

function bd:EnableConnect()
	self._connection = self._button.Click:Connect(function()
		self.enabled = not self.enabled
		self._event:Fire()
	end)
end

function bd:DisableConnect()
	self._connection = nil
end

return bd
