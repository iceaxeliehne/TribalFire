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
displayedbadies = display.newGroup()

function baddiesInit(xPos,yPos,params)
    print("bady init test")
    for i=1,#params.limbs do
        local enemyLimb = display.newSprite(params.spriteSheet, params.limbs[i].sequences)
        enemyLimb.x = xPos + params.limbs[i].xPosition
        enemyLimb.y = yPos + params.limbs[i].yPosition
        displayedbadies:insert(enemyLimb)
    end
    local enemyBody = display.newSprite(params.spriteSheet, params.sequences )
    enemyBody.x = xPos
    enemyBody.y = yPos
    enemyBody.state = params.state
    enemyBody.badyIndex = params.badyIndex
    enemyBody.collisionState = 0
    enemyBody.health = params.health
    enemyBody.hitPoints = params.hitPoints
    displayedbadies:insert(enemyBody)
    for i=1,#params.limbs do
        local enemyLimb = display.newSprite(params.spriteSheet, params.limbs[i].sequences)
        enemyLimb.x = xPos + params.limbs[i].xPosition
        enemyLimb.y = yPos + params.limbs[i].yPosition
        displayedbadies:insert(enemyLimb)
    end
end

function updateBaddies()
    for i=1, displayedbadies.numChildren do
        print("disp badies # = " .. i)
        --print("#disp badi = " .. #displayedbadies)
        if displayedbadies[i].badyIndex then

            --print("update bady test = " .. displayedbadies[i].badyIndex)
            badies[displayedbadies[i].badyIndex].update(i)
            if displayedbadies[i].x <= 155 and displayedbadies[i].collisionState == 0 then
                displayedbadies[i].collisionState = 0
                badies[displayedbadies[i].badyIndex].engage(i)
                return true
            end
        end
    end
end

function battle(i)
    print('baddie index =' .. i)
    print('baddie num children = ' .. displayedbadies.numChildren)
    if player.item then
        print('bady health =' .. displayedbadies[i].health)
        displayedbadies[i].health = displayedbadies[i].health - player.item.hitPoints
        print('bady health =' .. displayedbadies[i].health)
        if displayedbadies[i].health == 0 then
            print('defeat test')
            for j = i+2,i-2,-1 do
                print('j =' .. j)
                displayedbadies:remove(j)
            end
            player.item.rotation = -20
            player.timer = 0
            return true
        end
    end
    print("whoops too far")
    player.health = player.health - displayedbadies[i].hitPoints
    if player.health <= 0 then
        gameOver()
    end
end
