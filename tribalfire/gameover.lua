
function gameOver()
  -- adds image centered at x,y co-ords
  local gameoverpic = display.newImage("images/gameover2.png", display.contentCenterX, display.contentCenterY)
  audio.stop(backgroundMusicChannel)
  audio.play(gameoverSong, {channel = 3, loops=0})
end

