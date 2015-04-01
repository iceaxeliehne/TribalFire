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
ground = screenHeight - 53
local delay = 0
-- character assets
characterSheet = graphics.newImageSheet( "images/ninja/pixel guy test.png", { width=64, height=64, numFrames=3 } )
enemySheet = graphics.newImageSheet( "images/ninja/pexel enemy test.png", { width=64, height=64, numFrames=3 } )

character = {
	{
		--image sheet
		spriteSheet = characterSheet,
		--sprite sequences
		sequences = {
			name = "walking",
			frames = {1}
		},
		xPosition = 100,
		yPosition = ground,
		state = 'walking',
		jumpFrom = 0,
		update = function() 
			if player.grab and player.grab ~= 0 then
				player.item = PlayerItemInit(tTable[player.grab])
				player.grab = 0
			elseif player.state == 'walking' then
				local number = math.sin(delay)
				--print("number = " .. number)
				delay = delay + (speed/10)
				if delay >= 6.5 then
					delay = delay - (2*math.pi)
				end
				--print("delay = " .. delay)
				--change angle to adjust stride
				local angle = 30 * number
				--print("angle = " .. angle)
				farLeg.rotation = angle
				nearLeg.rotation = -angle
				farArm.rotation = -angle
				if player.item then
					nearArm.rotation = -90
				else
					nearArm.rotation = angle
				end
				return
			end
		end
	},
	{
		--leg
		--image sheet
		spriteSheet = characterSheet,
		--sprite sequences
		sequences = {
			name = "walking",
			frames = {2}
		},
		xPosition = 97,
		yPosition = ground + 14,
		state = 'walking',
		jumpFrom = 0,
		update = function() 
		end
	},
	{
		--arm
		--image sheet
		spriteSheet = characterSheet,
		--sprite sequences
		sequences = {
			name = "walking",
			frames = {3}
		},
		xPosition = 96,
		yPosition = ground - 7,
		state = 'walking',
		jumpFrom = 0,
		update = function() 
		end
	}
}

badies = {
		--bady one
	{	
		--bady 1 body
		spriteSheet = enemySheet,
		sequences = {
			name = "walking",
			frames = {1}
		},
		state = "falling",
		badyIndex = 1,
		health = 1,
		hitPoints =1,
		update = function(i)
			if displayedbadies[i].state and displayedbadies[i].state == 'falling' then
				for j=i-2,i+2 do
					displayedbadies[j].y = displayedbadies[j].y + 3
				end
				if displayedbadies[i].y >= ground then
					displayedbadies[i].y = ground
					displayedbadies[i-2].y = ground+18
					displayedbadies[i-1].y = ground-6
					displayedbadies[i+1].y = ground+18
					displayedbadies[i+2].y = ground-6
					displayedbadies[i].state = 'walking'
					print("bady fall test")
				end
			elseif displayedbadies[i].state and displayedbadies[i].state == 'walking' then
				for j=i-2,i+2 do
					displayedbadies[j].x = displayedbadies[j].x -1
				end
				local number = math.sin(delay)
				local angle = 30 * number
				--print("angle = " .. angle)
				displayedbadies[i-2].rotation = angle
				displayedbadies[i+1].rotation = -angle
				displayedbadies[i-1].rotation = -angle
				displayedbadies[i+2].rotation = angle
				return
			end
		end,
		engage = function(i)
			if player.item then
				if player.timer >= 10 then	
					player.item.rotation = player.item.rotation + 5
				else
					player.item.rotation = player.item.rotation - 3
				end
			end
			player.timer = player.timer + 1
			if player.timer == 40 then
				battle(i)
				return true
			end
		end,
		limbs = {
			{
				--limb 1 legs
				sequences = {
					name = "walking",
					frames = {2}
				},
				xPosition = 0,
				yPosition = 18
			},
			{
				--limb 2 arms
				sequences = {
					name = "walking",
					frames = {3}
				},
				xPosition = 4,
				yPosition = -6
			}
		}	
	}
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
			badyIndex = 1,
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
		},
		{
			--tile 4 stick/sword
			image = 'images/stick.png',
			tIndex = 4,
			angle = 135,
			hitPoints = 1,
			preCollision = function(t,i) 
				if t.preCollisionState == 0 then
					t.preCollisionState = 1
				end
				print("precollision test")
			end,
			sideCollision = function(t,i) 
				if player.item then
					return
				else
					tiles:remove(i)
					print("get sword")
					player.grab = 4
				end
				return true
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

compatability[1] = {4,3,0,0}
compatability[2] = {3,4,0,0}
compatability[3] = {0,0,3,0}
compatability[4] = {0,0,0,0}

