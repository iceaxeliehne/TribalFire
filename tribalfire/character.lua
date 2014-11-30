local screenHeight = display.viewableContentHeight
ground = screenHeight - 50

-- A sprite sheet with a green dude
local ninjasheet = graphics.newImageSheet( "images/ninja/complete.png", { width=64, height=64, numFrames=16 } )

local delay = 0


-- play 15 frames every 500 ms
local ninjasequence = {
  { name="running", start=1, count=6, time=500 },
  { name="jumping", frames={ 9 }}
}
player = display.newSprite( ninjasheet, ninjasequence )

-- local player = display.newImage("images/ninja/n3.png")
player.x = 100
player.y = ground
player.state = 'walking'
player.jumpFrom = 0

player:play()

 local playerYell = audio.loadStream("sounds/yell.mp3")


function updatePlayer()
	if player.state == 'walking' then
		return
	elseif player.state == 'jumpUp' then
		player.jumpFrom = player.y 
		player.state = 'jumpingUp'
    	player:setSequence("jumping")
	  	player:play()
	  	audio.play(playerYell)
	elseif player.state == 'jumpingUp' then
		--change value for jumping speed
		player.y = player.y - 5
		--change value for jump height
		if player.y < player.jumpFrom - 100 then
			player.state = 'hovering'
		end
	elseif player.state == 'hovering' then
		delay = delay + 1
		if delay == 60 then
			player.state = 'jumpingDown'
			delay = 0
		end
	elseif player.state == 'jumpingDown' then
		-- change value for falling speed
		player.y = player.y + 5
		if player.y >= ground then
			player.y = ground
			player.state = 'walking'
      player:setSequence("running")
      player:play()
			
		end
	--add player states here
	end
end

function playerJump()
	player.state = 'jumpUp'
end

--<<<<<<< HEAD
--timer.performWithDelay( 1000, playerJump, 1 )
--=======
--timer.performWithDelay( 1000, playerJump, 1 )
-->>>>>>> 0bf29eb356d340cdba75e44355a41f0668f4642b
