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

-- delay counter for tile gereation
delayCount = 0
--number of tiles in the hand
tilesInHand = 1
-- triggers game over state
tooManyTiles = 0

--address of tile table
tTable = level.tiles
-- group to hold on screen tiles
tiles = display.newGroup()

-- update objects runs for each frame
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
         for i=1,3,1 do
            slotTiles[i] = 0 
         end
         gameStatus = "Running"
      end
    end
  end
end

Runtime:addEventListener( "enterFrame", update )

-- generates tile into the slider.
-- NOTE! currently only triggers tile2. whith additional tiles this function will need to randomly choose wich tile to spawn
function tileDelay()
  delayCount = delayCount + 1
  if delayCount == 200 then
    displayObjectInit(tTable[1])
    delayCount = 0
  end
end

-- start audio
backgroundMusic = audio.loadStream("sounds/escapeloop.mp3")
gameoverSong = audio.loadStream("sounds/gameover-low.mp3")
playerYell = audio.loadStream("sounds/yell.mp3")
backgroundMusicChannel = 1
theGameoverSongChannel = 2

audio.play( backgroundMusic, { channel=backgroundMusicChannel, loops=-1, fadein=5000 }) 


-- audio.stop( backgroundMusicChannel )                                                                                                             fadein   =5000 })

