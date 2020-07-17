-- Constructor.lua
-- DollorLua
-- July 9, 2020

--[[

Example Usage:

local pc = require(framework.plugins.Constructor)

local tb = pc.newToolbar("Custom Toolbar A!")
local b = pc.newButton('name', 'this is a description', 'rbxassetid://0', tb)

=======================

this helps build the toolbars and buttons.

]]

local plugConstructor = {}
plugConstructor.__index = plugConstructor

function plugConstructor.newToolbar(name)
	local name = name or 'Custom toolbar '.. tick()
	local tb = plugin:CreateToolbar(name)
	return tb
end

function plugConstructor.newSavedToolbar(name)
	local name = name or 'Custom toolbar '.. tick()
	local tb = plugin:CreateToolbar(name)
	local v = Instance.new("ObjectValue")
	v.Name = name..'Toolbar'
	v.Value = tb
	v.Parent = game:GetService("CoreGui")
	return tb
end

function plugConstructor:GetToolbarFromName(name)
	if game:GetService("CoreGui"):FindFirstChild(name..'Toolbar') then
		return game:GetService("CoreGui"):FindFirstChild(name..'Toolbar').Value
	else
		warn('If you want to recieve your toolbars through this method use contructor.newSavedToolbar()')
		return
	end 
end

function plugConstructor.newButton(name, description, image, toolbar)
	local d = Instance.new("Decal")
	d.Texture = image
	wait()
	local image = d.Texture
	local b = toolbar:CreateButton(name, description, image)
	
	return b
end

return plugConstructor
