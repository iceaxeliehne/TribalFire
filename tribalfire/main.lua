-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


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