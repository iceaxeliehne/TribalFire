-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--[[    {TribalFire}
    Copyright (C) {2015}  {Isaac Lynnah}

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]--



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
tilesUpdate = 0
-- table that holds tiles to be deleted at end of frame
deleteTiles = {}

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
            slotTiles[i] = nil 
         end
         gameStatus = "Running"
      end
    end
  end
end

Runtime:addEventListener( "enterFrame", update )

-- generates tile into the slider.
-- 
function tileDelay()
  delayCount = delayCount + 1
  if delayCount == 200 then
    tilesUpdate = 1
    num = math.random(1,2)
    displayObjectInit(tTable[num])
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

