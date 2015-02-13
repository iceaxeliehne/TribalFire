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
local delay = 0
-- character assets

character = {
	{
		--image sheet
		spriteSheet = graphics.newImageSheet( "images/ninja/complete.png", { width=64, height=64, numFrames=16 } ),
		--sprite sequences
		sequences = {
  			{ name="running", start=1, count=6, time=500 },
  			{ name="jumping", frames={ 9 }}
		},
		xPosition = 100,
		yPosition = ground,
		state = 'walking',
		jumpFrom = 0,
		update = function() 
			if player.state == 'walking' then
				return
			elseif player.state == 'jumpUp' then
				player.jumpFrom = player.y 
				player.state = 'jumpingUp'
		    	player:setSequence("jumping")
			  	player:play()
			  	--audio.play(playerYell, {channel = 2, loops=0})
			elseif player.state == 'jumpingUp' then
				--change value for jumping speed
				player.y = player.y - 5
				--change value for jump height
				if player.y < player.jumpFrom - 100 then
					player.state = 'hovering'
				end
			elseif player.state == 'hovering' then
				--print("hovering test")
				delay = delay + 1
				--change value for hover time
				if delay == 60 then
					--print('delay test')
					player.state = 'jumpingDown'
					delay = 0
				end
			elseif player.state == 'jumpingDown' then
				--print(ground)
				-- change value for falling speed
				player.y = player.y + 3
				if player.y >= ground then
					player.y = ground
					player.state = 'walking'
		      		player:setSequence("running")
		      		player:play()
				end
			--add player states here
			end
		end
	},
}


--tile assets
level ={
	tiles = {
		--[[
		tileExample = {
			image = 'images/tilesets/tileExample.png',
			tIndex = tile number,
			preCollision = function(t,i) 
				if t.preCollisionState == 0 then
					t.preCollisionState = 1
				end
				print("precollision test")
			end,
			sideCollision = function(t,i) 
				print("side collision test")
			end,
			aboveCollision = function(t,i) 
				print("above collision test")
			end,
			belowCollision = function(t,i) 
				print("below collision test")
			end
		}
		]]--
		{
			-- tile 1 ground 
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png',
			tIndex = 1,
			preCollision = function(t,i) 
				if t.preCollisionState == 0 then
					t.preCollisionState = 1
					if player.y == ground then
						player.state = 'jumpUp'
					end
				end
				
			end,
			sideCollision = function(t,i) 
				print('side collision test')
			end,
			aboveCollision = function(t,i) 
				print('above collision test')
			end,
			belowCollision = function(t,i) 
				print('below collision test')
			end
		},
		{
			-- tile 2 gem
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_50.png',
			tIndex = 2,
			preCollision = function(t,i) 
				if t.preCollisionState == 0 then
					t.preCollisionState = 1
				end
			end,
			sideCollision = function(t,i) 
				tiles:remove(i)
				print('10 points!!!!!!')
				return true
			end,
			aboveCollision = function(t,i) 
				print('above collision test')
			end,
			belowCollision = function(t,i) 
				print('below collision test')
			end
		},
		{
			--tile 3 bady
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_51.png',
			tIndex = 3,
			preCollision = function(t,i) 
				if t.preCollisionState == 0 then
					t.preCollisionState = 1
				end
				print("precollision test")
			end,
			sideCollision = function(t,i) 
				print("side collision test")
			end,
			aboveCollision = function(t,i) 
				print("above collision test")
			end,
			belowCollision = function(t,i) 
				print("below collision test")
			end
		}
	}
}

--holds data on what tile is currently in save slots
slotTiles = {nil,nil,nil}
--holds info on which tiles can be crafted in the save slots 
compatability = {}
--[[each element in compatability is an array of recepies for when two tiles combine.
compatability[1] = {} each element of the array indexed at 1 holds finctions for when the tile of index 1 is dragged onto 
another tile. eg. dragging 1 onto 5 is deturmined by running compatability[1][5] while dragging 5 onto 1 is
compatability[5][1]. each element will hold either nil for when the two tiles cannot combine or the tIndex of the tile produced
]]--

compatability[1] = {0,3,0}
compatability[2] = {3,0,0}
compatability[3] = {0,0,3}

