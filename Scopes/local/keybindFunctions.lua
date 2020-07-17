-- keybindFunctions.lua
-- DollorLua
-- July 9, 2020

--[[

Example usage:

local m = require(framework.local.keybindFunctions)
local constructed = m.connectBinder(true, true, Enum.KeyCode.E, Enum,KeyCode.ButtonX)

constructed.Inputted:Connect(function(input)
	if input == 'Touch' then
		print('touch!')
	end
	if input.KeyCode and input.KeyCode == Enum.KeyCode.E then
		print('Keyboard!')
	end
end)

==========================

This module was to make some things like user input server or context action service simpler.

local constructor = m.connectBind(true, true, Enum, Enum)
                                    1     2     3     4

1. (bool) if the code should only run outside of text labels. (false if it will run inside them)
2. (bool) if a mobile button should be created.
3. (Enum.KeyCode) the key that a computer/desktop/laptop user would use.
4. (Enum.KeyCode) the key an xbox/console user would use.

]]


local uis = game:GetService("UserInputService")
local cas = game:GetService("ContextActionService")

local kbinds = {}
kbinds.__index = kbinds

function kbinds.connectBinder(proccess, isMobile, keybindComputer, keybindConsole)
	
	local e = Instance.new("BindableFunction")
	
	local self = setmetatable({
		_proccess = proccess,
		_mobile = isMobile,
		_key = keybindComputer,
		_cons = keybindConsole,
		_event = e,
		
		_destroyed = false,
		_disabled = true,
		
		Inputted = e.Event,
	}, kbinds)
	
	return self
	
end

function kbinds:Enable()
	if self._destroyed then warn('This keybind function no longer exists!') return end
	
	local function runInput(input)
		if self._disabled then return end
		if self._destroyed then return end
		if input == 'Touch' or input.KeyCode == self._key or input.KeyCode == self._cons then
			self._event:Fire(input)
		end
	end
	
	local function a()
		runInput('Touch')
	end
	
	cas:BindAction(tostring(tick()), a, true)
	
	uis.InputBegan:Connect(function(input, proc)
		if self._proccess then
			if proc then
				return
			end
		else
			if not proc then
				return
			end
		end
		
		runInput(input)
	end)
end

function kbinds:Disable()
	self._disabled = true
end

function kbinds:Rid()
	self._destroyed = true
	self._event:Destroy()
	self._event = nil
	self.Inputted = nil
end

return kbinds
