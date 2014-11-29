
local screenHeight = display.viewableContentHeight
local ground = screenHeight - 50
local delay = 0

local player = display.newImage("images/ninja/n3.png")
player.x = 100
player.y = ground
player.state = 'walking'
player.jumpFrom = 0

function updatePlayer()
	if player.state == 'walking' then
		return
	elseif player.state == 'jumpUp' then
		player.jumpFrom = player.y 
		player.state = 'jumpingUp'
	elseif player.state == 'jumpingUp' then
		--change value for jumping speed
		player.y = player.y - 5
		--change value for jump height
		if player.y < player.jumpFrom - 100 then
			player.state = 'hovering'
		end
	elseif player.state == 'hovering' then
		delay = delay + 1
		if delay == 10 then
			player.state = 'jumpingDown'
		end
	elseif player.state == 'jumpingDown' then
		-- change value for falling speed
		player.y = player.y + 5
		if player.y >= ground then
			player.y = ground
			player.state = 'wlaking'
		end
	--add player states here
	end
end

function playerJump()
	player.state = 'jumpUp'
end

--timer.performWithDelay( 1000, playerJump, 1 )