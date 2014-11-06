
local animState = "init"
local timerID 
local animOver


	TimeBonus = { 
	
	start = function(x,y)
		print("state",animState)
		if 	animState == "init" or animState == "stopped" then
			animState = "ongoing"
			
			--local doubleArrow1 = display.newImage(group,"images/arrow3.png",-50,200)
			--local doubleArrow2 = display.newImage(group,"images/arrow3.png",-50,480)
			--transition.to(doubleArrow1,{time = 1000,x = display.contentWidth/2 - 250 , y = display.contentHeight/2 + 100, alpha = 0.3 ,onComplete = function() doubleArrow1:removeSelf(); doubleArrow1 = nil  end })
			--transition.to(doubleArrow2,{time = 1000,x = display.contentWidth/2 - 250 , y = display.contentHeight/2 + 100, alpha = 0.3,onComplete = function() doubleArrow2:removeSelf(); doubleArrow2 = nil  end })
			
			TimerFunctions.clockUpdate(10)
				local function bonusArrows(event)
					local doubleArrow1 = display.newImage(group,"images/arrow3.png",x,y)
					Animations.arrowUp.start(doubleArrow1,100,450)
					
				end
			
			
			function animOver(event)
				TimeBonus.stop()
				_isTimeBonus = false
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
	
			if animState ~= "init" then
				timer.cancel(timerID)
				animOver()
			end
	end

}