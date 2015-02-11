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


function gameOver()
  if (gameStatus == "Running") then
    gameStatus = "GameOver"
    print (gameStatus)
    -- adds image centered at x,y co-ords
    gameoverpic = display.newImage("images/gameover2.png", display.contentCenterX, display.contentCenterY)
    audio.stop(backgroundMusicChannel)
    audio.play(gameoverSong,{channel=theGameoverSongChannel})
  end
end

