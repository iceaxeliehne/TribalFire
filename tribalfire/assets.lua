
local screenHeight = display.viewableContentHeight
local ground = screenHeight - 36

level ={
	tiles = {
		tile1 = {
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png',
			x = 500,
			y = ground,
			state = 'scrolling',
			collisionState = 0
		},
		tile2 = {
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png',
			x = -25,
			y = 45,
			state = 'slider',
			collisionState = 0
		}
	}
}