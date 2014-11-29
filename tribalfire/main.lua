-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth

display.setStatusBar(display.HiddenStatusBar)

local assets = require('assets')
local backgrounds = require('backgrounds')
local character = require('character')
local tile = require('tile')
--local platform = require('platform')

handCounter = 1

tiles = {}

local tetrisHand = display.newRect(screenWidth/2,30,screenWidth+100,60)
tetrisHand:setFillColor(0)


--local test = platformClass:new(level.tiles.tile2)
--test:activate()

local function update(event)
	updateBackgrounds()
	updateBlocks()
	updatePlayer()
	updateTiles()
end


function updateTiles()
	for k,v in ipairs(tiles) do
		v:tileUpdate()

	end
end

Runtime:addEventListener( "enterFrame", update )

function generateTiles(event)
	local n = math.random(2)
	local t = platformClass:new(level.tiles.tile2)
	t:activate()
	tiles[#tiles + 1] = t
end

timer.performWithDelay(1000,generateTiles,6)

-- start audio
local backgroundMusic = audio.loadStream("sounds/escapeloop.mp3")
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }) 

-- audio.stop( backgroundMusicChannel )                                                                                                             fadein   =5000 })



