
local animState = "init"
local timerID 
local animOver
local timerIdArrow
local powerIndicator

	KnifeCut = {
		start = function(grp)
		
			
			if 	animState == "init" or animState == "stopped" then
				animState = "ongoing"
					powerIndicator = display.newImage(grp,"images/ferocep.png",display.contentCenterX,50)
					transition.from(powerIndicator,{time = 1000,alpha = 0,y = -54 })
					Animations.indicatorShift.positive(grp)
				local function tempArrow(event)	
					local ballBody = { density=0.85, friction=0.2, bounce=0.5 }
				
					-- Create arrow
					local arrow = display.newImage( group,"images/Swallow_Fire.png" )
					arrow.x = math.random(150,700)
					arrow.y = -100
					arrow.rotation = 70
					arrow.anchorX = 0.96
					
					physicsArrow.addBody( arrow,ballBody  )
					--arrow.isSensor = true 
					
					arrow.isBullet = true -- force continuous collision detection, to stop really fast shots from passing through other balls
					arrow.color = "white"
					arrow.bodyType = "kinematic"
					arrow.myName = "knife"
					arrow.fruitsHit = 0
					
					transition.to(arrow,{time = 800,x = arrow.x + math.random(100,150), y = 480, onComplete = TransitionFunctions.removeFromTree  })
					arrow:addEventListener( "preCollision",Collision.knifePreCollision )
				end
				
				timerIdArrow = timer.performWithDelay(130,tempArrow,0)
				function animOver(event)
					transition.to(powerIndicator,{time = 1000,alpha = 0,y = -54, onComplete = function() TransitionFunctions.removeFromTree(powerIndicator) ;	
										Animations.indicatorShift.negative(grp)	
										
										if _arrowCount == 0 then
											LevelDestroyer.destroy(doMagnet,newArrow)
										end
										end})
					timer.cancel(timerIdArrow)
					animState = "stopped"
					-- _isArrowSplit = false
				end
				
				timerID =  timer.performWithDelay(5000,animOver)
				
		elseif animState == "ongoing" then
				timer.cancel(timerID)
				timerID = timer.performWithDelay(5000,animOver)
		end	 
						
	end,

	stop = function()
		
		
	end,
	
	getState = function()
		return animState
	end,
	
	terminate = function()
	
			if animState == "ongoing"  then
				--timer.cancel(timerID)
				animOver()
			end
	end

}