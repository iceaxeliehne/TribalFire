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


local screenHeight = display.viewableContentHeight
ground = screenHeight - 50

-- A sprite sheet with a green dude
--local ninjasheet = graphics.newImageSheet( "images/ninja/complete.png", { width=64, height=64, numFrames=16 } )

-- delay used for hover time in jump
local delay = 0


function playerInit(params)
	local player = display.newSprite(params.spriteSheet, params.sequences )

	-- local player = display.newImage("images/ninja/n3.png")
	player.x = params.xPosition
	player.y = params.yPosition
	player.state = params.state
	player.jumpFrom = params.jumpFrom

	--player:play()
	return player
end

--add characters/objects to scene here
farLeg = playerInit(character[2])
farArm = playerInit(character[3])
player = playerInit(character[1])
player.health = 1
player.timer = 0
nearLeg = playerInit(character[2])
nearArm = playerInit(character[3])

function PlayerItemInit(params)
    local item = display.newImageRect(params.image,40,40)
    item.rotation = -20
    item.x = 110
    item.y = ground - 8
    item.hitPoints = params.hitPoints
    return item
end

-- contains code for animating each state for the character
function updatePlayer()
	for i = 1, #character do
		character[i].update()
	end
end
