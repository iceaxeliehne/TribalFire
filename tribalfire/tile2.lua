
local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth


function displayObjectInit(params)
	local t = display.newImageRect(params.image,40,40)
	t.x = params.x
	t.y = params.y
	t.state = params.state
	t.collisionIndex = params.collisionIndex
	--change to 0 to disable touch
	t.touchState = 1
	t:addEventListener( "touch", tileTouch )
	t.collisionState = 0
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
					--tooManyTiles = 1
				end
			end
		elseif tiles[i].state =='scrolling' then
			tiles[i].x = tiles[i].x -1
			if tiles[i].x <= 150 and tiles[i].collisionState == 0 then
				tiles[i].collisionState = 1
				collisionHandler(tiles[i])
			end
		end
		if tiles[i].testForCollision == 1 then
			collisionTest(tiles[i])
		end
	end
end


function tileTouch(event)
	if event.target.touchState == 1 then
		print('touch state = 1')
		if event.phase == "began" then
			print('hit')
		elseif event.phase == "moved" then
			event.target.x = event.x
			event.target.y = event.y
		elseif event.phase == "ended" then
			event.target.touchState = 0
			event.target.state = 'scrolling'
			--tilesInHand = tilesInHand - 1
			updateTetris()
		end
	end
end

function collisionHandler(t)
	preCollision(t)
end

function updateTetris()
	for i=1, tiles.numChildren, 1 do
		if tiles[i].state == 'static' then
			tiles[i].state = 'slider'
			tilesInHand = 1
		end
	end
end