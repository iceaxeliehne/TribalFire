--backgrounds 

local background = display.newimage()
background.x =
background.y = 

local background2 = display.newimage()
background2.x =
background2.y = 

local level = display.newGroup()

for i = 1,8,1 do
	local ground = display.newimage()
	-- change imagewidth to value
	ground.x = (i * imageWidth) - imageWidth
	ground.y = 
