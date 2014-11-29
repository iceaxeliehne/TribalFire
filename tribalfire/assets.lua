
local screenHeight = display.viewableContentHeight
local ground = screenHeight - 50

level ={
	tiles = {
		tile1 = {
			image = 'images/tilesets/PlatformTiles_brownNature_ByEris_0_64/tile_00.png',
			x = 300,
			y = ground,
			state = 'scrolling'
		}
	}
}