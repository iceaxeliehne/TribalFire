--[[    {TribalFire}
    Copyright (C) {2015}  {Isaac Lynnah}

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]--


local screenHeight = display.viewableContentHeight
local screenWidth = display.viewableContentWidth

-- initiate tile for display
function displayObjectInit(params)
	local t = display.newImageRect(params.image,40,40)
	t.x = -25
	t.y = 35
	if params.angle then
		t.rotation = params.angle
	end
	-- state can be 'slider','static', 'scrolling', 'falling'
	t.state = 'slider'
	-- collision index sends to unique functions for tile collisions
	t.tIndex = params.tIndex
	--change to 0 to disable touch
	if params.badyIndex then
		print("badyIndex test")
		t.badyIndex = params.badyIndex
	end
	t.touchState = 0
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
	--print(tiles.numChildren)
	for i = 1, tiles.numChildren do
		--print("test")
		if tiles[i].state == 'slider' then
			tiles[i].x = tiles[i].x + 3
			if tiles[i].x >= ((screenWidth - 74) - (tilesInHand * 43)) then
				tilesInHand = tilesInHand + 1
				tiles[i].state = 'static'
				if tilesInHand == 2 then
					tiles[i].touchState = 1
				elseif tilesInHand == 12 then
					tooManyTiles = 1
				end
			end
		elseif tiles[i].state =='scrolling' then
			tiles[i].x = tiles[i].x -1
			if tiles[i].x <= - 200 then
				print('tile remove test')
				--table.insert(deleteTiles,tiles[i])
				--print(#deleteTiles)
				tiles:remove(i)
				return
			elseif tiles[i].x <= 155 and tiles[i].collisionState == 0 then
				tiles[i].collisionState = 1
				--tiles[i].preCollisionState = 1
				tiles[i].testForCollision = 1
				tTable[tiles[i].tIndex].preCollision(tiles[i])
			end
		elseif tiles[i].state == 'falling' then
			tiles[i].y = tiles[i].y +3
			if tiles[i].y >= ground + 12 then
				tiles[i].y = ground + 12
				tiles[i].state = 'scrolling'
			end
		end
		if tiles[i].testForCollision == 1 then
			if collisionTest(tiles[i],i) then
				return
			end
		end
	end
	if groundTile then
		--print("test ground tile")
		--print(groundTile.x)
		if groundTile.x <= 48 then
			--print('ground tile test')
			ground = screenHeight - 50
			player.state = 'jumpingDown'
			groundTile = false
		end
	end
end


function tileTouch(event)
	if event.target.touchState == 1 then
		--print('touch state = 1')
		if event.phase == "began" then
			print('began touch')
			if event.target.state == 'saved' then
				tileUnsave(event.target,event)
			end
			--print('hit')
		elseif event.phase == "moved" then
			if event.target.state == 'saved' then
				return
			end
			testTileSave(event.target,event)
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
			if event.target.state == 'saved' then
				return
			end 
			if event.target.state ~= 'saved' then
				event.target.touchState = 0
			end
			resetSlotColor()
			tileSave(event.target,event)
			if event.target.state ~= 'saved' and event.target.y <= ground then
				print("bady test est falling")
				if event.target.badyIndex then
					print("test bady spawn")
					baddiesInit(event.target.x,event.target.y,badies[event.target.badyIndex])
					event.target:removeSelf()
				else
					event.target.state = "falling"
				end
			elseif event.target.state ~= 'saved' then
				event.target.state = 'scrolling'
			end
			--tilesInHand = tilesInHand - 1
			updateTetris()
		end
	end
end


function updateTetris()
	tilesInHand = 1
	for i=1, tiles.numChildren, 1 do
		if tiles[i].state == 'static' then
			tiles[i].state = 'slider'
		end
	end
end

function collisionTest(t,i)
	if t.x <= 48 then
		t.testForCollision = 0
		return
	elseif t.orientation then 
		if t.orientation == 'above' then
			if t.contentBounds.yMin <= player.contentBounds.yMax then
				return tTable[t.tIndex].aboveCollision(t,i)
			end
		elseif t.orientation == 'below' then
			if t.contentBounds.yMax <= player.contentBounds.yMin then
				return tTable[t.tIndex].belowCollision(t,i)
			end
		end
	elseif t.contentBounds.xMin <= player.contentBounds.xMax then
		if t.contentBounds.yMin >= player.contentBounds.yMax then
			--player is above tile
			t.orientation = 'above'
			--aboveCollision[t.collisionState](t)
		elseif t.contentBounds.yMax <= player.contentBounds.yMin then
			--print('below collision call test')
			--player is below tile
			t.orientation = 'below'
			--belowCollision[t.collisionState](t)
		elseif t.contentBounds.xMin <= (player.contentBounds.xMax - 50) then
			-- player is colliding from the side
			--print('side collision call test')
			t.collisionState = 1
			return tTable[t.tIndex].sideCollision(t,i)
		end
	end
end

function testTileSave(t,event)
	if event.y <= 51 then
		if event.x >= screenWidth-93 then
			--print('greenlight')
			if event.x <= screenWidth-50 then
				--print(compatabilityTest(3,t))
				if compatabilityTest(3,t) then
					slots[3]:setStrokeColor(0,1,0)
				else
					slots[3]:setStrokeColor(1,0,0)
				end
			elseif event.x <= screenWidth-7 then
				if compatabilityTest(2,t) then
					slots[2]:setStrokeColor(0,1,0)
				else
					slots[2]:setStrokeColor(1,0,0)
				end
			else
				if compatabilityTest(1,t) then
					slots[1]:setStrokeColor(0,1,0)
				else
					slots[1]:setStrokeColor(1,0,0)
				end
			end
		end
	end
end

function tileSave(t,event)
	if event.y <= 51 then
		if event.x >= screenWidth-93 then
			if event.x <= screenWidth-50 then
				tileSavePrt2(t,event,3,screenWidth-70)
			elseif event.x <= screenWidth-7 then
				tileSavePrt2(t,event,2,screenWidth-27)
			else
				tileSavePrt2(t,event,1,screenWidth+16)
			end
		end
	end
end

function tileSavePrt2(t,event,slot,xPosition)
	if compatabilityTest(slot,t) then
		if slotTiles[slot] == nil then
			t.touchState = 1
			t.state = 'saved'
			t.x = xPosition
			t.y = 35
			--slotTiles[slot] = t.tIndex
			slotTiles[slot] = t
			print('slot 3 save')
		else
			local newTileIndex = compatability[t.tIndex][slotTiles[slot].tIndex]
			displayObjectInit(tTable[newTileIndex])
			print('tiles numb = ' .. tiles.numChildren)
			tiles[tiles.numChildren].state = 'saved'
			tiles[tiles.numChildren].x = xPosition
			tiles[tiles.numChildren].y = 35
			tiles[tiles.numChildren].touchState = 1
			slotTiles[slot]:removeSelf()
			slotTiles[slot] = tiles[tiles.numChildren]
			t:removeSelf()
		end
	end
end

function tileUnsave(t,event)
	if event.y <= 51 then
		if event.x >= screenWidth-93 then
			if event.x <= screenWidth-50 then
				t.state = 'static'
				slotTiles[3] = nil
			elseif event.x <= screenWidth-7 then
				t.state = 'static'
				slotTiles[2] = nil
			else
				t.state = 'static'
				slotTiles[1] = nil
			end
		end
	end
end

-- NOTE! check this function this does not seem right!
function compatabilityTest(slot,t)
	--print("compatability")
	--print('slot =' .. slot)
	--print("slotTiles[slot] = " .. slotTiles[slot])
	--print("t.tIndex =" .. t.tIndex)
	--print("compatability = " .. compatability[t.tIndex][slotTiles[slot].tIndex])
	if slotTiles[slot] == nil or compatability[t.tIndex][slotTiles[slot].tIndex] ~= 0 then
		--print("slotTiles[slot] = " .. slotTiles[slot])
		--print("compatability = true")
		return true
	else
		--print("compatability = false") 
		return false
	end
end