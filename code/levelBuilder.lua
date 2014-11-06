require("timerFunctions")

LevelBuilder = {

	new = function(gameMode,grp)
		_arrowCount = 10
		_gameScore = 0
		_highScore = ScoreBox:retrieve(gameMode)
		--local background = display.newImage(grp,"images/background" .. gameMode .. ".png",display.viewableContentWidth/2 , display.viewableContentHeight/2 )
		local background = display.newImage(grp,"images/bg" .. "2" .. ".jpg",display.viewableContentWidth/2 , display.viewableContentHeight/2 )
		local tree = display.newImage(grp,"images/tree.png",display.viewableContentWidth - 137  , display.viewableContentHeight/2 )
		_scoreBar = display.newImage(grp,"images/score_bar.png", 85 , 50)
		_scoreBar.x = _scoreBar.contentWidth / 2 + 30
		_scoreText = display.newText(grp,_gameScore, _scoreBar.x + 30, 50,native.systemFont,score_textSize)
		
		_highScoreBar = display.newImage(grp,"images/high_score_bar.png", display.viewableContentWidth/2 , 50)
		_highScoreText = display.newText(grp,_highScore, _highScoreBar.x + 10, 50,native.systemFont,score_textSize)
		
		_arrowBar = display.newImage(grp,"images/arrow_bar.png", 85 , 50)
		_arrowBar.x = display.viewableContentWidth - (_arrowBar.contentWidth / 2) - 30
		
		if gameMode == "arcade" then
			_arrowText = display.newText(grp,_arrowCount, _arrowBar.x + 30, 50,native.systemFont,score_textSize)
		elseif gameMode == "timeMode" then
			_clock = display.newText(grp,"01:00", _arrowBar.x + 30, 50, native.systemFont, score_textSize)
			_clockId = timer.performWithDelay(1000,TimerFunctions.countdown,60)
		end
		
	end,

}