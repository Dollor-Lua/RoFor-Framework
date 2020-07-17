-- AnimationLoader.lua
-- 7/17/2020
-- DollorLua

--[[

This will load a list of animation objects for you!

Required to be used in a local script.

Exeption:
Inside an NPC this is required to be used in a normal script.

Example usage:

local AnimationA = script.AnimationA
local AnimationB = script.AnimationB

local listOfAnimations = m.loadList(humanoid, AnimationA, AnimationB)

-- you can have as many animation parameters as you need.

]]

local m = {}
m.__index = m

function m.loadList(hum, ...)
	if not hum or hum.ClassName ~= 'Humanoid' then warn('No valid humanoid was sent. Got \''.. typeof(hum) ..'\'') return end
	local list = {...}
	local loaded = {}
	for i,v in pairs(list) do
		if v:IsA("Animation") then
			if not loaded[v.Name] then
				loaded[v.Name] = hum:LoadAnimation(v)
			else
				warn('cannot have 2 animations of the same name.')
			end
		else
			warn('Did not get animation, got type \''.. typeof(v)..'\'')
		end
	end
	
	return loaded
end

return m
