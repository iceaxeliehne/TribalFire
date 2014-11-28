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
	level:insert(ground)
end

function updateBackgrounds()
	background.x = background.x - (speed / 55)
	background2.x = background2.x - (speed / 55)

	-- change imagewidth to vaue
	if background.x <= -imagewidth then
		background.x = background.x + (2*imagewidth)
	end

	-- change imagewidth to vaue
	if background2.x <= -imagewidth then
		background2.x = background2.x + (2*imagewidth)
	end
end

function updateGround()
	for i = 1,level.numChildren , 1 do
		level[i].x = level[i].x - speed
		-- change imagewidth to value -- change numberofgroundtiles to value
		if level[i].x <= -imagewidth then
			level[i].x = level[i].x + (imagewidth * numberofgroundtiles)
		end
	end
end