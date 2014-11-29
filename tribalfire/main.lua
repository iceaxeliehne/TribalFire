-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth

image.x = screenWidth / 2
image.y = screenHeight / 2

display.setStatusBar(display.HiddenStatusBar)

local backgrounds = require(backgrounds)
local speed = 5

