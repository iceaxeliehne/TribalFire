
local screenHeight = display.viewableContentHeight


level ={
	tiles = {
		--[[
		tileExample = {
			image = 'images/tilesets/tileExample.png',
			tIndex = tile number,
			preCollision = function(t) 
				if t.preCollisionState == 0 then
					t.preCollisionState = 1
				end
				put stuff here
			end,
			sideCollsion = function(t) 
				put stuff here
			end,
			aboveCollision = function(t) 
				put stuff here
			end,
			belowCollision = function(t) 
				put stuff here
			end
		}
		]]--
		{
			-- tile 1 ground 
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png',
			tIndex = 1,
			preCollision = function(t) 
				if t.preCollisionState == 0 then
					t.preCollisionState = 1
					if player.y == ground then
						player.state = 'jumpUp'
					end
				end
				
			end,
			sideCollision = function(t) 
				print('side collision test')
			end,
			aboveCollision = function(t) 
				print('above collision test')
			end,
			belowCollision = function(t) 
				print('below collision test')
			end
		}
	}
}

--holds data on what tile is currently in save slots
slotTiles = {}
--holds info on which tiles can be crafted in the save slots 
compatability = {}
--[[each element in compatability is an array of recepies for when two tiles combine.
compatability[1] = {} each element of the array indexed at 1 holds finctions for when the tile of index 1 is dragged onto 
another tile. eg. dragging 1 onto 5 is deturmined by running compatability[1][5] while dragging 5 onto 1 is
compatability[5][1]. each element will hold either nil for when the two tiles cannot combine or the tIndex of the tile produced
]]--

compatability[1] = {0}


