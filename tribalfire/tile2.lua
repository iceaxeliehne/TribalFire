
local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth


function displayObjectInit(params)
	local t = display.newImageRect(params.image,40,40)
	t.x = params.x
	t.y = params.y
	t.state = params.state
	tiles:insert(t)
end

function updateTiles()
	for i=1,tiles.numChildren,1 do
		if tiles[i].state == 'slider' then
			tiles[i].x = tiles[i].x + 1
			if tiles[i].x >= ((screenWidth + 60) - (tilesInHand * 43)) then
				tilesInHand = tilesInHand + 1
				tiles[i].state = 'static'
				setStaticTile(tiles[i])
				if tilesInHand == 15 then
					tooManyTiles = 1
				end
			end
		elseif tiles[i].state =='scrolling' then
			tiles[i].x = tiles[i].x -1
			if tiles[i].x <= 150 and tiles[i].collisionState == 0 then
				tiles[i].collisionState = 1
				collisionHandler(tiles[i])
			elseif tiles[i].x <= -50 then
				display.remove( tiles[i] )
				tiles[i]= nil
			end
		end
	end
end

function setStaticTile(t)
	t:addEventListener( "touch", tileTouch )
end

function tileTouch(event)
	if event.phase == began then
		print('hit')
	elseif event.phase == moved then
		self.x = event.x
		self.y = event.y
	elseif event.phase == ended then
		self.state = 'scrolling'
	end
end

--[[
if self.state == 'scrolling' then
		self.t.x = self.t.x - 1
		if self.t.x <= 150 and self.collisionState == 0 then
			self.collisionState = 1
			self:collisionHandler()
		end
	elseif self.state == 'slider' then
		self.t.x = self.t.x + 1
		if self.t.x >= (screenWidth - 60) then
			handCounter = handCounter +1
			self.state = 'static'
		end
	end
end
	]]--