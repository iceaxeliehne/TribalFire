
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
collisions = {}
preCollisions = {}

-- pre-collision function for tile 1
preCollisions[1] =  function (t)
	if player.y == ground then
		if t.y <= (ground+ 64) and t.y >= (ground-20) then
			playerJump()
		else
			t.testForCollision = 1
		end
	else
		t.testForCollision = 1
	end
end

function preCollision(t)
	
	print('test pre collision')
	print(t.collisionIndex)
	--local index = t.collisionIndex
	preCollisions[t.collisionIndex](t)
end



-- collision function for tile 1
collisions[1] = function (t)

end
	

function collisionTest(t)
	if t.x <= 48 then
		t.testForCollision = 0
		return
	end
	local side = 132 >= t.contentBounds.xMin 
	local up = player.contentBounds.yMax >= t.contentBounds.yMin and player.contentBounds.yMin <= t.contentBounds.yMin
	local down = player.contentBounds.yMin <= t.contentBounds.yMax and player.contentBounds.yMin >= t.contentBounds.yMin
	print(side and up or down)
end