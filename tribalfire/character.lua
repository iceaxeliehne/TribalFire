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

	player:play()
	return player
end

--add characters/objects to scene here
player = playerInit(character[1])


-- contains code for animating each state for the character
function updatePlayer()
	for i = 1, #character do
		character[1].update()
	end
end
