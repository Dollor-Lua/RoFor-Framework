-- ConfigBuilder.lua
-- 7/17/2020
-- DollorLua

--[[

This script was made to make building a configuration easier.

Example

local config = m.new()

config:CreateInt('something', 5)

config:SetConfigParent(script)

config:Reset()

config:Rid()

-------------------------------------

functions:

:CreateInt(name, default value)
:CreateString(name, default value)
:CreateObj(name, default value)
:CreateNum(name, default value)

:SetConfigParent(obj)

:Rid()
:Reset()

]]

local m = {}
m.__index = m

function m.new()
	local self = setmetatable({
		_destroyed = false,
		_config = Instance.new("Configuration")
	}, m)
	return self
end

function m:CreateInt(name, defaultValue)
	local int = Instance.new("IntValue")
	int.Name = name or 'IntValue'
	int.Value = defaultValue or 0
	int.Parent = self._config
end

function m:CreateString(name, defaultValue)
	local str = Instance.new("StringValue")
	str.Name = name or 'StringValue'
	str.Value = defaultValue or ''
	str.Parent = self._config
end

function m:CreateObj(name, defaultValue)
	local obj = Instance.new("ObjectValue")
	obj.Name = name or 'ObjectValue'
	obj.Value = defaultValue or nil
	obj.Parent = self._config
end

function m:CreateNum(name, defaultValue)
	local num = Instance.new("NumberValue")
	num.Name = name or 'NumberValue'
	num.Value = defaultValue or 0
	num.Parent = self._config
end

function m:SetConfigParent(obj)
	self._config.Parent = obj or script
end

function m:Rid()
	if self._destroyed then warn('This configuration is already destroyed.') return end
	self._destroyed = true
	self._config:Destroy()
	self._config = nil
end

function m:Reset()
	for i,v in pairs(self._config:GetChildren()) do
		v:Destroy()
	end
	
	warn('✔️ successfully reset the configuration.')
end

return m
