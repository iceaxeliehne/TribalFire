
function gameOver()
  gameStatus = "GameOver"
  -- adds image centered at x,y co-ords
  gameoverpic = display.newImage("images/gameover2.png", display.contentCenterX, display.contentCenterY)
  audio.stop(backgroundMusicChannel)
  theGameoverSongChannel = audio.play(gameoverSong)
  --print( "gameoverpic is ")
  --print( gameoverpic )
end

