-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth

--local image = {}
--local image.x = screenWidth / 2
--local image.y = screenHeight / 2

display.setStatusBar(display.HiddenStatusBar)

local assets = require('assets')
local backgrounds = require('backgrounds')
local character = require('character')
local tile = require('tile')
--local platform = require('platform')

tiles = display.newGroup()

local test = platformClass:new(level.tiles.tile1)

test:activate()

local function update(event)
	updateBackgrounds()
	updateBlocks()
	updatePlayer()
	updateTiles()
end

function updateTiles()
	test:tileUpdate()
end



Runtime:addEventListener( "enterFrame", update )