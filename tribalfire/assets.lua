
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
	print('pre-collision')
	print(player.y)
	print(ground)
	print('t.y = '..t.y)
	if player.y == ground then
		if t.y <= (player.y+ 100) and t.y >= (player.y-50) then
			print('test second jump')
			player.state = 'jumpUp'
			if t.y <= screenHeight - 100 then
				t.testForCollision = 1
			end
		else
			t.testForCollision = 1
		end
	else
		t.testForCollision = 1
	end
end

function preCollision(t)
	--t.testForCollision = 1
	print('test pre collision')
	print(t.collisionIndex)
	--local index = t.collisionIndex
	preCollisions[t.collisionIndex](t)
end



-- collision function for tile 1
collisions[1] = function (t,upOrDown)
	local above = player.y >= t.y and player.x >= (t.x - 40) and player.x <= (t.x + 40)
	local side = t.x <= 132 and player.y >= (t.y - 20) and player.y <= (t.y + 20)
	local below = player.y <= t.y and player.x >= (t.x - 40) and player.x <= (t.x + 40)
	if side then
		if player.y < t.y then
			if (t.y - player.y) >= compareValues(t.x,player.x) then
				ground = t.y - 52
				print('set ground to '..ground)
				groundTile = t
			else
				print('side from above')
				gameOver()
			end
		elseif t.y < player.y  then
			if (player.y - t.y) >= compareValues(t.x,player.x) then
				player.state = 'jumpingDown'
			else
				print('side from below')
				gameOver()
			end
		else
			print('side')
			gameOver()
		end
	elseif above then
		ground = t.y - 52
		print('set ground to '..ground)
		groundTile = t	
	elseif below then
		player.state = 'jumpingDown'
	end
end

function compareValues(a,b)
	if a >=b then
		return a - b
	else
		return b - a
	end
end
	

function collisionTest(t)
	if t.x <= 48 then
		t.testForCollision = 0
		return
	end
	local side = 132 >= t.contentBounds.xMin 
	local up = player.contentBounds.yMax >= t.contentBounds.yMin and player.contentBounds.yMin <= t.contentBounds.yMin
	local down = player.contentBounds.yMin <= t.contentBounds.yMax and player.contentBounds.yMin >= t.contentBounds.yMin
	if (side and down) then
		collisions[t.collisionIndex](t,'down')
	elseif (side and up) then
		collisions[t.collisionIndex](t,'up')
	end
end