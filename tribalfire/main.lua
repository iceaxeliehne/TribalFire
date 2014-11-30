-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
gameStatus = "Running"

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
local button = require('restart')


setUpAndArmGameOverButton()

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
  if (gameStatus == "Running") then
    updateBackgrounds()
    updateBlocks()
    updatePlayer()
    updateTiles()
    if tooManyTiles == 0 then
      tileDelay()
    else
      gameOver()
    end 
  else if (gameStatus == "Resetting") then
      if (not audio.isChannelPlaying( theGameoverSongChannel )) then
         display.remove(gameoverpic)
         audio.rewind(backgroundMusic)
         audio.play( backgroundMusic, { channel=backgroundMusicChannel, loops=-1, fadein=5000 }) 
         display.remove(tiles)
         tiles = display.newGroup()
         tilesInHand = 1
         tooManyTiles = 0
         gameStatus = "Running"
      end
  end
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
backgroundMusicChannel = 1
theGameoverSongChannel = 2

audio.play( backgroundMusic, { channel=backgroundMusicChannel, loops=-1, fadein=5000 }) 


-- audio.stop( backgroundMusicChannel )                                                                                                             fadein   =5000 })

