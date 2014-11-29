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

local tiles = display.newGroup()

local function update(event)
	updateBackgrounds()
	updateBlocks()
	updatePlayer()
	--speed = speed + .05
end

local test = platformClass:new(level.tiles.tile1)
test:activate()

Runtime:addEventListener( "enterFrame", update )