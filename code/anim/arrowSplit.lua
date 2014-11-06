
local animState = "init"
local timerID 
local animOver
local powerIndicator

	ArrowSplit = { 
	
	start = function(grp)
		if 	animState == "init" or animState == "stopped" then
			animState = "ongoing"
			local doubleArrow1 = display.newImage(group,"images/arrow.png",-50,200)
			local doubleArrow2 = display.newImage(group,"images/arrow.png",-50,480)
			
			transition.to(doubleArrow1,{time = 1000,x = display.contentWidth/2 - 250 , y = display.contentHeight/2 + 100, alpha = 0.3 ,onComplete = TransitionFunctions.removeFromTree   })
			transition.to(doubleArrow2,{time = 1000,x = display.contentWidth/2 - 250 , y = display.contentHeight/2 + 100, alpha = 0.3,onComplete = TransitionFunctions.removeFromTree   })
			powerIndicator = display.newImage(grp,"images/splitp.png",display.contentCenterX,50)
				transition.from(powerIndicator,{time = 1000,alpha = 0,y = -54 })
				
				Animations.indicatorShift.positive(grp)
			
			function animOver(event)
				transition.to(powerIndicator,{time = 1000,alpha = 0,y = -54, onComplete = function() TransitionFunctions.removeFromTree(powerIndicator) ;	
										Animations.indicatorShift.negative(grp)					
										end})
				 ArrowSplit.stop()
				 _isArrowSplit = false
			end
			
			timerID =  timer.performWithDelay(12500,animOver)
			
		elseif animState == "ongoing" then
				print("cancel")
				timer.cancel(timerID)
				timerID = timer.performWithDelay(12500,animOver)	 
		end			
	end,

	stop = function()
			
		animState = "stopped" 
		
		local doubleArrow1 = display.newImage(group,"images/arrow.png",display.contentWidth/2 - 250,display.contentHeight/2 + 100)
		local doubleArrow2 = display.newImage(group,"images/arrow.png",display.contentWidth/2 - 250,display.contentHeight/2 + 100)
		
		transition.to(doubleArrow1,{time = 1000,x = -50 , y = 200, alpha = 0.3,onComplete = TransitionFunctions.removeFromTree   })
		transition.to(doubleArrow2,{time = 1000,x = -50 , y = 480, alpha = 0.3,onComplete = TransitionFunctions.removeFromTree   })
		
		
	end,
	terminate = function()
		
			if animState == "ongoing" then
				timer.cancel(timerID)
				animOver()
			end
	end

}