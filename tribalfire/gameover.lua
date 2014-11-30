
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

