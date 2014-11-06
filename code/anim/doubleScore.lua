
local powerIndicator
local Particles
local animState = "init"
local timerID
local redo 
local animOver
local tempScoreBar
local tempDoubleScoreText
local tempGroup
local doubleEmitter

	DoubleScore = { 
	
	start = function(grp,grpEmitter)
		print("state",animState)
		if 	animState == "init" or animState == "stopped" then
			animState = "ongoing"
				tempGroup = display.newGroup()
				group:insert(tempGroup)
				Particles = require("anim.lib_particle_candy")
				_tempDoubleScore = 0
				tempScoreBar = display.newImage(grp,"images/double_score_bar.png", _scoreBar.x , 50)
				tempScoreBar:scale(0.5,0.5)
				tempDoubleScoreText = display.newText(_tempDoubleScore,tempScoreBar.x,tempScoreBar.y,native.systemFont,30)
				tempDoubleScoreText:setTextColor(0,0,0)
				-- CREATE EMITTERS (NAME, SCREENW, SCREENH, ROTATION, ISVISIBLE, LOOP)
				--Particles.CreateEmitter("E4", screenW*0.5, 0, 180, false, true)
				Particles.CreateEmitter("E4", tempScoreBar.x, tempScoreBar.y, 180, false, true)
				
				-- DEFINE PARTICLE TYPE PROPERTIES
				local Properties 				= {}
				Properties.imagePath			= "anim/double_star.png"
				Properties.imageWidth			= 32	-- PARTICLE IMAGE WIDTH  (newImageRect)
				Properties.imageHeight			= 32	-- PARTICLE IMAGE HEIGHT (newImageRect)
				Properties.velocityStart		= 30	-- PIXELS PER SECOND
				Properties.velocityVariation	= 80
				Properties.directionVariation	= 270
				Properties.alphaStart			= 1		-- PARTICLE START ALPHA
				Properties.fadeInSpeed			= 0.5	-- PER SECOND
				Properties.fadeOutSpeed			= -1.5	-- PER SECOND
				Properties.fadeOutDelay			= 800	-- WHEN TO START FADE-OUT
				Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
				Properties.scaleVariation		= 1
				Properties.scaleOutDelay		= 600
				Properties.scaleOutSpeed		= -1.0
				--Properties.scaleInSpeed			= 0.25
				Properties.weight				= 0.01	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
				Properties.colorStart			= {0,1,0}
				--Properties.colorChange			= {-0.25,0.3,-0.15}
				Properties.rotationChange		= 30	-- ROTATION CHANGE PER SECOND
				Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
				Properties.emissionRadius		= 0	-- SIZE / RADIUS OF EMISSION SHAPE
				Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
				Properties.lifeTime				= 1300  -- MAX. LIFETIME OF A PARTICLE
				Properties.useEmitterRotation	= false	--INHERIT EMITTER'S CURRENT ROTATION
				Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
				Particles.CreateParticleType ("doubleStarsUp", Properties)
				
				-- DEFINE PARTICLE TYPE PROPERTIES
				local Properties 				= {}
				Properties.imagePath			= "anim/double_star.png"
				Properties.imageWidth			= 32	-- PARTICLE IMAGE WIDTH  (newImageRect)
				Properties.imageHeight			= 32	-- PARTICLE IMAGE HEIGHT (newImageRect)
				Properties.velocityStart		= -40	-- PIXELS PER SECOND
				Properties.velocityVariation	= -70
				Properties.directionVariation	= 200
				Properties.alphaStart			= 0.5		-- PARTICLE START ALPHA
				Properties.fadeInSpeed			= 0.5	-- PER SECOND
				Properties.fadeOutSpeed			= -1.5	-- PER SECOND
				Properties.fadeOutDelay			= 900	-- WHEN TO START FADE-OUT
				Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
				Properties.scaleVariation		= 0.75
				Properties.scaleOutDelay		= 600
				Properties.scaleOutSpeed		= -1.0
				--Properties.scaleInSpeed			= 0.25
				Properties.weight				= 0.01	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
				Properties.colorStart			= {0,1,0}
				--Properties.colorChange			= {-0.25,0.3,-0.15}
				Properties.rotationChange		= 40	-- ROTATION CHANGE PER SECOND
				Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
				Properties.emissionRadius		= 0	-- SIZE / RADIUS OF EMISSION SHAPE
				Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
				Properties.lifeTime				= 1300  -- MAX. LIFETIME OF A PARTICLE
				Properties.useEmitterRotation	= false	--INHERIT EMITTER'S CURRENT ROTATION
				Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
				Particles.CreateParticleType ("doubleStarsDown", Properties)
			
			grpEmitter:insert(Particles.GetEmitter("E4"))
			grpEmitter:insert(tempScoreBar)
			grpEmitter:insert(tempDoubleScoreText)
			
			powerIndicator = display.newImage(grp,"images/doublep.png",display.contentCenterX,50)
			transition.from(powerIndicator,{time = 1000,alpha = 0,y = -54 })
			Animations.indicatorShift.positive(grp)
			
			transition.to(tempScoreBar,{time = 500 , y = tempScoreBar.y + 68 ,xScale = 1,yScale = 1 ,onComplete = function()
										
											Particles.GetEmitter("E4").x = tempScoreBar.x
											Particles.GetEmitter("E4").y = tempScoreBar.y - 10
				
				
										end})
			
				Particles.AttachParticleType("E4", "doubleStarsUp" , 3, 99999,0)
				Particles.AttachParticleType("E4", "doubleStarsDown" , 3, 99999,0)

				-- TRIGGER THE EMITTERS
				Particles.StartEmitter("E4")
				doubleEmitter = Particles.GetEmitter("E4")
				
				function redo( event )
					--Particles.SetParticleProperty("doubleStars", "colorStart" , {math.random()*30, math.random()*20, math.random()*15})
					local tempColor ={math.random(), math.random() , math.random()}
					--Particles.SetParticleProperty("doubleStarsUp", "colorStart" , tempColor)
					local tempColor ={math.random(), math.random() , math.random()}
					--Particles.SetParticleProperty("doubleStarsDown", "colorStart" , tempColor)
					-- UPDATE PARTICLES
					if tempScoreBar and tempDoubleScoreText then
						tempScoreBar:toFront()
						tempDoubleScoreText.y = tempScoreBar.y + 20
						tempDoubleScoreText:toFront()
						_scoreBar:toFront()
						_scoreText:toFront()
					end
					Particles.Update()
						
				
				end
			 
				 Runtime:addEventListener("enterFrame",redo)
			
			function animOver(event)
			
			--Runtime:removeEventListener("enterFrame",redo)
				if animState ~= "stopped" then
					transition.to(powerIndicator,{time = 1000,alpha = 0,y = -54, onComplete = function() TransitionFunctions.removeFromTree(powerIndicator) ;	
												Animations.indicatorShift.negative(grp)					
												end})
					_tempDoubleScore = _tempDoubleScore * 2
					transition.to(tempDoubleScoreText,{time = 300,xScale = 0,yScale = 0,onComplete = function()
													tempDoubleScoreText.text = _tempDoubleScore
													tempDoubleScoreText.xScale= 1
													tempDoubleScoreText.yScale= 1 
													_gameScore = _gameScore + _tempDoubleScore 
													print("SCORE" , _gameScore,_tempDoubleScore)
													transition.to(tempScoreBar,{delay = 100,time = 500,y = 50,xScale = 0.5,yScale = 0.5,  onComplete = function()
																tempScoreBar:removeSelf()
																tempScoreBar = nil														
																		end})
													transition.to(tempDoubleScoreText,{delay = 100,time = 500,y = 50,xScale = 0.5,yScale = 0.5,  onComplete = function()
																			tempDoubleScoreText:removeSelf()
																			tempDoubleScoreText = nil
																			_scoreText.text = _gameScore 
																			if ScoreBox:storeIfHigher( _gameMode, _gameScore ) then
																				_highScoreText.text = _gameScore
																			end
																		end})
													
													end})
					
						DoubleScore.stop()
						_isDoubleScore = false
				end	
			end
			
			timerID =  timer.performWithDelay(12500,animOver)
		elseif animState == "ongoing" then
				print("cancel")
				timer.cancel(timerID)
				timerID = timer.performWithDelay(12500,animOver)	 
		end		

		return tempDoubleScoreText
	end,

	stop = function()
			
			Particles.StopEmitter("E4");
			timer.performWithDelay(1700,function()
			accelerateEmitter = nil
			Particles.ClearParticles("E4")
			Particles.DeleteEmitter("E4")
			Runtime:removeEventListener( "enterFrame", redo )
			end)
		animState = "stopped" 
		
		
	end,
	terminate = function()
		
			if animState == "ongoing"  then
				timer.cancel(timerID)
				animOver()
			end
	end

}