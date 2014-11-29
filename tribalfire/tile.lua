
local tileClass = {}
tileClass.__index = tileClass
 -- table titled with class name holds the functions of the class
 -- table titled _mt provides instances of class with 
 -- meta table classname. ie it tells the instance to look
 -- for functions in the className table

 function tileClass:new(params)
 	local newInstance = {
 		image = params.image
 		x = params.x
 		y = params.y
 		state = 'scrolling'
 	}
 	return setmetatable( newInstance, self )
 end

 --[[ constructor function
	called by 
	local instancename = className.new(propety1,property2)

	saves table of instance propeties with className_mt meta table
	wich tells the computer to look for functions in the className 
	table
]]--

-- private functions

local function title(parameter)
	return parameter
end

-- public functions

function tileClass:update()
	if self.state = 'scrolling' then
		self.x = self.x - speed
		-- change to values
		if self.x <= player.x + imagewidth 
	end
end

function tileClass:testCollide()

	local right = player.contentBounds.xMin <= self.contentBounds.xMin and player.contentBounds.xMax >= self.contentBounds.xMin
    local left = player.contentBounds.xMin >= self.contentBounds.xMin and player.contentBounds.xMin <= self.contentBounds.xMax
    local up = player.contentBounds.yMin <= self.contentBounds.yMin and player.contentBounds.yMax >= self.contentBounds.yMin
    local down = player.contentBounds.yMin >= self.contentBounds.yMin and player.contentBounds.yMin <= self.contentBounds.yMax
    return (left or right) and (up or down)
