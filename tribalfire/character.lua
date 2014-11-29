
local player = display.newImage()
player.x = 
player.y = 
player.state = 'walking'
player.jumpFrom = 0

function updatePlayer()
	if player.state == 'walking' then
		return
	elseif player.state == 'jump' then
		player.jumpFrom = player.y 
		player.state = 'jumping'
	elseif player.state == 'jumping' then
		--change value for jumping speed
		player.y = player.y + 5
		--change value for jump height
		if player.y > player.jumpFrom + 20
			player.state = 'walking'
		end
	--add player states here
	end
end