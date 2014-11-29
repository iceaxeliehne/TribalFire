--backgrounds 

local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth


-- adds image centered at x,y co-ords
local backbackground = display.newImage("images/background.png")
backbackground.x = 240
backbackground.y = 160

local backgroundfar = display.newImage("images/bgfar1.png")
backgroundfar.x = 480
backgroundfar.y = 160

local backgroundnear1 = display.newImage("images/bgnear2.png")
backgroundnear1.x = 240
backgroundnear1.y = 160

local backgroundnear2 = display.newImage("images/bgnear2.png")
backgroundnear2.x = 760
backgroundnear2.y = 160

--group to hold blocks
local blocks = display.newGroup()

--ground position
local groundMin = 420
local groundMax = 340
local groundLevel = groundMin
local speed = 1

--loop to generate ground
for a = 1, 8, 1 do
	isDone = false

	--chose ground texture
	numGen = math.random(2)
	local newBlock
	print (numGen)
	if (numGen == 1 and isDone == false) then
		newBlock = display.newImage("images/ground1.png")
		isDone = true
	end
	if (numGen == 2 and isDone == false) then
		newBlock = display.newImage("images/ground2.png")
		isDone = true
	end

	--assign block id
	newBlock.name = ("block" .. a)
	newBlock.id = a

	--set block position based on its id
	newBlock.x = (a * 79) - 79
	newBlock.y = groundLevel
	blocks:insert(newBlock)
end


local function update(event)
	updateBackgrounds()
	updateBlocks()
	--speed = speed + .05
end

function updateBlocks()
	for a =1, blocks.numChildren, 1 do
		if (a > 1) then
			newX = (blocks[a - 1]).x + 79
		else
			newX = (blocks[8]).x + 79 - speed
		end
		if ((blocks[a]).x < -40) then
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
