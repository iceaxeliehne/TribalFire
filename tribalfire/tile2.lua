
local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth

-- initiate tile for display
function displayObjectInit(params)
	local t = display.newImageRect(params.image,40,40)
	t.x = -25
	t.y = 35
	-- state can be 'slider','static', 'scrolling', 'falling'
	t.state = params.state
	-- collision index sends to unique functions for tile collisions
	t.collisionIndex = params.collisionIndex
	--change to 0 to disable touch
	t.touchState = 1
	t:addEventListener( "touch", tileTouch )
	-- pre collision state checks wether the character has reacted to the approaching tile
	t.preCollisionState = 0
	-- collision state checks if colision function has run. 0 = can collide, 1 = has collided
	t.collisionState = 0
	-- testForCollision if 1 will check for collision with player
	t.testForCollision = 0
	tiles:insert(t)
end

function updateTiles()
	for i=1,tiles.numChildren,1 do
		if tiles[i].state == 'slider' then
			tiles[i].x = tiles[i].x + 1
			if tiles[i].x >= ((screenWidth + 60) - (tilesInHand * 43)) then
				tilesInHand = tilesInHand + 1
				tiles[i].state = 'static'
				tiles[i].touchState = 1
				if tilesInHand == 15 then
					tooManyTiles = 1
				end
			end
		elseif tiles[i].state =='scrolling' then
			tiles[i].x = tiles[i].x -1
			if tiles[i].x <= 155 and tiles[i].collisionState == 0 then
				tiles[i].preCollisionState = 1
				tiles[i].testForCollision = 1
				preCollisions[tiles[i].collisionIndex](tiles[i])
			end
		elseif tiles[i].state == 'falling' then
			tiles[i].y = tiles[i].y +3
			if tiles[i].y >= ground + 12 then
				tiles[i].y = ground + 12
				tiles[i].state = 'scrolling'
			end
		end
		if tiles[i].testForCollision == 1 then
			collisionTest(tiles[i])
		end
	end
	if groundTile then
		--print("test ground tile")
		--print(groundTile.x)
		if groundTile.x <= 48 then
			ground = screenHeight - 50
			player.state = 'jumpingDown'
			groundTile = false
		end
	end
end


function tileTouch(event)
	if event.target.touchState == 1 then
		print('touch state = 1')
		if event.phase == "began" then
			print('hit')
		elseif event.phase == "moved" then
			if event.x <= 200 then
				event.target.x = 200
			else
				event.target.x = event.x
			end
			if event.y >= screenHeight - 50 then
				event.target.y = ground
			else
				event.target.y = event.y
			end
		elseif event.phase == "ended" then
			event.target.touchState = 0
			if event.target.y <= ground then
				event.target.state = "falling"
			else
				event.target.state = 'scrolling'
			end
			--tilesInHand = tilesInHand - 1
			updateTetris()
		end
	end
end


function updateTetris()
	for i=1, tiles.numChildren, 1 do
		if tiles[i].state == 'static' then
			tiles[i].state = 'slider'
			tilesInHand = 1
		end
	end
end

function collisionTest(t)
	if t.x <= 48 then
		t.testForCollision = 0
		return
	elseif t.contentBounds.xMin <= player.contentBounds.xMax then
		if t.contentBounds.yMin > player.contentBounds.yMax then
			--player is above tile
			aboveCollision[t.collisionState](t)
		elseif t.contentBounds.yMax < player.contentBounds.yMin then
			--player is below tile
			--belowCollision[t.collisionState](t)
		else
			-- player is colliding from the side
			t.collisionState = 1
			collisions[t.collisionIndex](t)
		end
	end
end