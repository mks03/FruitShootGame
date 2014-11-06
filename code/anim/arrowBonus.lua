
local animState = "init"
local timerID 
local animOver


	ArrowBonus = { 
	
	start = function(x,y)
		print("state",animState)
		if 	animState == "init" or animState == "stopped" then
			animState = "ongoing"
			
			
				local function bonusArrows(event)
					local doubleArrow1 = display.newImage(group,"images/arrow.png",x,y)
					Animations.arrowUp.start(doubleArrow1,_arrowText.x,_arrowText.y,event)
					local channel = SoundManager.play("sound/arrow_add.mp3");

				end
			

				timer.performWithDelay(200,bonusArrows,5)
			
			function animOver(event)
				ArrowBonus.stop()
				_isArrowBonus = false
			end
			
			timerID =  timer.performWithDelay(1000,animOver)
		elseif animState == "ongoing" then
				print("cancel")
				timer.cancel(timerID)
				timerID = timer.performWithDelay(1000,animOver)	 
		end			
	end,

	stop = function()
			
		animState = "stopped" 
		
		
	end,
	terminate = function()
	
			if animState == "ongoing"  then
				timer.cancel(timerID)
				animOver()
			end
	end

}