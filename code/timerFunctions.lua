require("transitionFunctions")


local maxTime = 60
local timeLeft = 60

TimerFunctions = {

	updateArrowPath = function(event)
		local params = event.source.params
		local shooter = params.myParam2  -- arrow or knife
		local target = params.myParam1   -- fruit
		local tempRotation = params.myParam3   -- fruit
		local grp = target.parent
		--print(event.count)
		if shooter ~= nil then
			if target.x < 740 or shooter.myName == "knife" then
				if shooter.y ~= nil and shooter.y < display.contentHeight then
					target.x = shooter.x + 10
					target.y = shooter.y
					target.rotation = (shooter.rotation - tempRotation)
					
					--target:toFront()
				else
					timer.cancel(event.source)
					target:removeSelf()
					target = nil
				end
				
			else
				local treeArrow = display.newImage(grp,"images/arrow.png")
				treeArrow:scale(0.9,0.9)
				treeArrow.x = target.x 
				treeArrow.y = target.y
				treeArrow.anchorX = 0.9
				target:toFront()
				treeArrow.rotation = shooter.rotation
				transition.to(target,{time = 8000,alpha = 0, onComplete =  TransitionFunctions.removeFromTree })
				transition.to(treeArrow,{time = 8000,alpha = 0, onComplete =  TransitionFunctions.removeFromTree })
				timer.cancel(event.source)
			end
		else
			
		end
		
	end,
	countdown = function(event)
	
		
		if event.name == "timer" then
			--maxTime = 60
			local mins
			local secs
			timeLeft = maxTime - event.count
			--print(timeLeft,maxTime,event.count)
			if(timeLeft>59) then
				mins = timeLeft / 60
				secs = timeLeft % 60
				_clock.text = math.modf(mins) .. " : " .. secs
			else
				_clock.text = "00 : " .. tostring(timeLeft)
			end
			
			if(timeLeft <= 10 and timeLeft % 2 == 0)then
				_clock:setFillColor(255,0,0)
			else
				_clock:setFillColor(255,255,255)
			end
			clockId = event.source
			count = event.count
			if event.count == maxTime then
				if KnifeCut.getState() == "ongoing" then
					
				else
						LevelDestroyer.destroy(doMagnet,newArrow)
				end

			end
	
			
		end
		
	end,
	
	clockUpdate = function(bonus)
	
			local mins
			local secs
			timer.cancel(clockId)
			maxTime = timeLeft + bonus
			
			if(maxTime>59) then
				mins = maxTime / 60
				secs = maxTime % 60
				_clock.text = math.modf(mins) .. " : " .. secs
			else
				_clock.text = "00 : " .. tostring(maxTime)
			end
			_clock:setFillColor(255,255,255)
			if(timeLeft <= 10 and timeLeft % 2 == 0)then
				_clock:setFillColor(255,0,0)
			else
				_clock:setFillColor(255,255,255)
			end
			clockId = timer.performWithDelay(1000,TimerFunctions.countdown,maxTime)
		
	end
	
	

}