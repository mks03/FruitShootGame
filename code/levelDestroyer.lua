
LevelDestroyer = {

	destroy = function(doMagnet,newArrow)
		Runtime:removeEventListener("enterFrame", doMagnet )
		Runtime:removeEventListener("enterFrame", newArrow )
		timer.cancel( _fruitId )
		timer.cancel( _powerId )
		Accelerate.terminate()
		Snow.terminate()
		--TimeBonus.terminate()
		ArrowBonus.terminate()
		--KnifeCut.terminate()
		Zoom.terminate()
		DoubleScore.terminate()
		ArrowSplit.terminate()
		
		timer.performWithDelay(1000,function() storyboard.gotoScene( "gameOverScreen", "fade", 500 ) end)
									
	end,
	gameReset = function(parentGroup,childGroup)
		local background = display.newImage(childGroup,"images/background" .. "_menu" .. ".jpg",display.viewableContentWidth/2 , display.viewableContentHeight/2 )
		local background = display.newImage(childGroup,"images/black.png",display.viewableContentWidth/2 , display.viewableContentHeight/2 )
		local background = display.newImage(parentGroup,"images/game_over.png",display.viewableContentWidth/2 , display.viewableContentHeight/2 )
		local score = display.newText(parentGroup,"1000",550,230,native.systemFont,20)
		local highScore = display.newText(parentGroup,"5000",220,230,native.systemFont,20)
		
		score.text = _gameScore
		highScore.text = ScoreBox:retrieve(_gameMode)
		
		local homeBtn = display.newImage(parentGroup,"images/home_icon.png",515,379)
		local restartBtn = display.newImage(parentGroup,"images/restart_icon.png",267,379)
		
		return homeBtn,restartBtn
		
	end

}