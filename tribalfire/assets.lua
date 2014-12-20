
local screenHeight = display.viewableContentHeight


level ={
	tiles = {
		tile1 = {
			-- tile 1 ground 
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png',
			x = 500,
			y = ground,
			state = 'slider',
			collisionState = 0
		},
		tile2 = {
			-- tile 2 ground (clone of tile 1)
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png',
			x = -25,
			y = 35,
			state = 'slider',
			collisionState = 0,
			collisionIndex = 1
		}
	}
}

--holds data on what tile is currently in save slots
slotTiles = {}
--holds info on which tiles can be joined in the save slots 
compatability = {}
-- holds functions that allow character to anticipate actions before colliding with the object. indexed by tile collision index
preCollisions = {}
-- holds function for side on collisions with tile
collisions = {}
-- holds functions called when the character is above the tile
aboveCollision = {}
-- holds functions called when character is below the tile
belowCollision ={}

-- pre-collision function for tile 1
preCollisions[1] =  function (t)
	--print('pre collision call test')
	if t.preCollisionState == 0 then
		t.preCollisionState = 1
		if player.y == ground then
			player.state = 'jumpUp'
		end
	end
end

-- collision function for tile 1
collisions[1] = function (t)
	print("collision call test")
	--gameOver()
end

aboveCollision[1] = function (t)

	--ground = ground - 40
	--groundTile = t
end

function compatabilityTest(slot,t)
	if slotTiles[slot] == 1 and compatibility[slotTiles[slot]][t.collisionIndex] == 0 then
		slots[slot]:setStrokeColor(1,0,0)
	else 
		slots[slot]:setStrokeColor(0,1,0)
	end
end