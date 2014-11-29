
local screenHeight = display.viewableContentHeight
local ground = screenHeight - 36

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
			collisionState = 0
		}
	}
}