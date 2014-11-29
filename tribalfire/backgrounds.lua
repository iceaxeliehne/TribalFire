--backgrounds 

local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth


-- adds image centered at x,y co-ords
local backbackground = display.newImage("images/backgrounds/bg.png", display.contentCenterX, display.contentCenterY)


local backgroundfar = display.newImage("images/backgrounds/bgfar1.png", display.contentCenterX, display.contentCenterY )


local backgroundnear1 = display.newImage("images/bgnear2.png")
backgroundnear1.x = 240
backgroundnear1.y = display.contentCenterY - 20

local backgroundnear2 = display.newImage("images/bgnear2.png")
backgroundnear2.x = 760
backgroundnear2.y = display.contentCenterY - 20

--group to hold blocks
local blocks = display.newGroup()

--ground position
local groundMin = 200
local groundMax = 340
local groundLevel = screenHeight 
local speed = 1

--loop to generate ground
for a = 1, 20, 1 do
	isDone = false

	--chose ground texture
	numGen = math.random(2)
	local newBlock
	if (numGen == 1 and isDone == false) then
		newBlock = display.newImageRect("images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png",40,40)
		isDone = true
	end
	if (numGen == 2 and isDone == false) then
		newBlock = display.newImageRect("images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png",40,40)
		isDone = true
	end

	--assign block id
	newBlock.name = ("block" .. a)
	newBlock.id = a

	--set block position based on its id
	newBlock.x = (a * 40) - 40
	newBlock.y = groundLevel
	blocks:insert(newBlock)
end


--[[local function update(event)
	updateBackgrounds()
	updateBlocks()
	--speed = speed + .05
end]]--

function updateBlocks()
	for a =1, blocks.numChildren, 1 do
		if (a > 1) then
			newX = (blocks[a - 1]).x + 40
		else
			newX = (blocks[20]).x + 40 - speed
		end
		if ((blocks[a]).x < -80) then
			(blocks[a]).x, (blocks[a]).y = newX, groundLevel
		else
			(blocks[a]):translate(speed * -1,0)
		end
	end
end

function updateBackgrounds()
	--far bg movement
	backgroundfar.x = backgroundfar.x - (speed / 55)

	--near bg movement
	backgroundnear1.x = backgroundnear1.x - (speed / 5)
	-- if the sprite has moved off screen move it to other side
	if (backgroundnear1.x < -239) then
		backgroundnear1.x = 760
	end

	backgroundnear2.x = backgroundnear2.x - (speed / 5)
	if (backgroundnear2.x < -239) then
		backgroundnear2.x = 760
	end
end

timer.performWithDelay(1,update,-1)
