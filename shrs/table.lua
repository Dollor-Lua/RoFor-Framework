-- table.lua
-- DollorLua
-- July 8, 2020

--[[

Example Usage:

local tableConstructor = require(table)

local s = tableConstructor.new('item1', 'item2', 'item3') -- infinitely many items to start on
s:push('item4')

if s:findIn('item1') then -- parameter can be anything (objects too!)
	print('item 1 exists!')
end

if s:findByName('something') then -- parameter must be an object.
	print('the object something exists')
end

s.itemAdded:Connect(function(item)
	print('an item was added to the table!')
end)

s.itemRemoved:Connect(function(item)
	print('an item was removed from the table!')
end)

=============================

tab in this stands for table, since table is already a lua function.

=============================

read the documentation for a "guide" on this module

]]

local unp = unpack

local tab = {}
tab.__index = tab

function createMetaSelf()
	local self = {
		itemAdded = Instance.new("BindableEvent"),
		itemRemoved = Instance.new("BindableEvent")
	}
	
	return self
end

function tab.new(...)
	
	local s2 = createMetaSelf()
	
	local self = setmetatable({
		contents = {...},
		
		_removed = false,
		_holder = s2,
		
		itemAdded = s2.itemAdded.Event,
		itemRemoved = s2.itemRemoved.Event
	}, tab)
	
	return self
	
end

function tab:push(object)
	table.insert(self.contents, object)
	self._holder.itemAdded:Fire(object)
end

function tab:findIn(object)
	for i,v in pairs(self.contents) do
		if v == object then
			return i
		end
	end
	
	return false
end

function tab:findByName(str)
	if not type(str) == 'string' then error('The string entered is not a valid string.') return end
	for i,v in pairs(self.contents) do
		if v:IsA("Instance") then
			if v.Name == str then
				return {i, v}
			end
		end
	end
	
	return false
end

function tab:remove(int)
	if type(int) ~= 'number' then error('The integer inputted is not a valid integer (:remove() function).') return end
	if math.floor(int) < int then error('You entered a float. This method requires a integer. (:remove())') return end
	
	local object
	for i,v in pairs(self.contents) do
		if i == int then
			object = v
			break
		end
	end
	
	table.remove(self.contents, int)
	
	if object then
		self._holder.itemRemoved:Fire(object)
	end
end

function tab:Reset()
	self.contents = {}
end

function tab:Rid()
	if self._removed then warn('You cannot get rid of a table that has already been destroyed.') return end
	
	self.contents = nil
	self._holder.itemAdded:Destroy()
	self._holder.itemRemoved:Destroy()
	self._removed = true
end

return tab
