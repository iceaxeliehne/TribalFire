
local tile = require('tile')

local platformClass = tileClass:new(t = {})

function platformClass:collisionHandler()
	playerJump()
end

