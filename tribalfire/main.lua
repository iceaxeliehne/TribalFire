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

tiles = display.newGroup()

local test = platformClass:new(level.tiles.tile1)

test:activate()

local function update(event)
	updateBackgrounds()
	updateBlocks()
	updatePlayer()
	updateTiles()
end

local tetrisHand = display.newRect(screenWidth/2,30,screenWidth+100,60)
tetrisHand:setFillColor(0)

function updateTiles()
	test:tileUpdate()
end



Runtime:addEventListener( "enterFrame", update )
