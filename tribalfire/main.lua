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

local backgrounds = require('backgrounds')
local character = require('character')


local function update(event)
	updateBackgrounds()
	updateBlocks()
	updatePlayer()
	--speed = speed + .05
end

Runtime:addEventListener( "enterFrame", update )