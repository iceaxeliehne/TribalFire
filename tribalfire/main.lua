-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth
print(screenHeight)
print(screenWidth)
display.setStatusBar(display.HiddenStatusBar)

local assets = require('assets')
local backgrounds = require('backgrounds')
local character = require('character')
local tile = require('tile2')
local gameover = require('gameover')
--local platform = require('platform')

delayCount = 0
--number of tiles in the hand
tilesInHand = 1
tooManyTiles = 0

local tetrisHand = display.newRect(screenWidth/2,30,screenWidth+100,60)
tetrisHand:setFillColor(0)

tiles = display.newGroup()

--local test = platformClass:new(level.tiles.tile2)

--test:activate()

local function update(event)
  updateBackgrounds()
  updateBlocks()
  updatePlayer()
  updateTiles()
  if tooManyTiles == 0 then
    tileDelay()
  else
    gameOver()
  end 

end

Runtime:addEventListener( "enterFrame", update )

function generateTiles()
  --local n = math.random(2)
  local t = platformClass:new(level.tiles.tile2)
  t:activate()
  
end

function tileDelay()
  delayCount = delayCount + 1
  if delayCount == 200 then
    displayObjectInit(level.tiles.tile2)
    delayCount = 0
  end
end

--timer.performWithDelay(5000,generateTiles,6)

-- start audio
backgroundMusic = audio.loadStream("sounds/escapeloop.mp3")
gameoverSong = audio.loadStream("sounds/gameover-low.mp3")
playerYell = audio.loadStream("sounds/yell.mp3")

backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }) 

-- audio.stop( backgroundMusicChannel )                                                                                                             fadein   =5000 })

