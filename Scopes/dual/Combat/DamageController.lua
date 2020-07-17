-- DamageController.lua
-- 7/17/2020
-- DollorLua

--[[

With the given parameters this script will damage a humanoid with benefits.

Example usage

m.Damage('DollorLua', hit.Parent.Humanoid, 5, 20, true, 1, true, 10, 35)

.Damage(A, B, C, D, E, F, G, H, I)

A: The player doing the damage's username
B: The humanoid being damaged
C: Minimum amount of damage
D: Maximum amount of damage
E: Creates a tag (debounce)
F: Time before removing the tag (debounce)
G: Criticals will happen (true, they will | false, they wont)
H: The chance of a critical happening (number, 1-100)
I: The damage a critical will do

]]

local m = {}
m.__index = m

function m.Damage(username, hum, min, max, tags, tagRemoveTime, doCrits, critChance, critDamage)
	if not hum or hum.ClassName ~= 'Humanoid' then warn('No valid humanoid set.') return end
	
	local maxDamage = max or min
	
	local damage = math.random(min, maxDamage)
	local doesTag = tags or false
	
	if doesTag then
		if hum:FindFirstChild(username..'_tag') then
			return
		end
		
		local ttime = tagRemoveTime or 0.75
		
		local tag = Instance.new("ObjectValue")
		tag.Name = username..'_tag'
		tag.Parent = hum
		
		spawn(function()
			wait(ttime)
			tag:Destroy()
		end)
	end
	
	if doCrits then
		local isCrit = math.random(1,100)<=critChance
		
		if isCrit then
			damage = critDamage or (max + 10)
			hum:TakeDamage(damage)
			return
		end
	end
	
	hum:TakeDamage(damage)
end

return m
