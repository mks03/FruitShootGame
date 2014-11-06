

local screenW = display.contentWidth
local screenH = display.contentHeight
local snowBg 
local Particles
local animState = "init"
local timerID = nil
local redo 
local animOver
local powerIndicator
local accelerateEmitter

	Accelerate = { 
	
	start = function(grp,grpEmitter)
		print("state",animState)
		if 	animState == "init" or animState == "stopped" then
				animState = "ongoing"
				Particles = require("anim.lib_particle_candy")
				-- CREATE EMITTERS (NAME, SCREENW, SCREENH, ROTATION, ISVISIBLE, LOOP)
				Particles.CreateEmitter("E2", screenW*0.5, 480, 180, false, true)

				-- DEFINE PARTICLE TYPE PROPERTIES
				local Properties 				= {}
				Properties.imagePath			= "anim/stars.png"
				Properties.imageWidth			= 16	-- PARTICLE IMAGE WIDTH  (newImageRect)
				Properties.imageHeight			= 16	-- PARTICLE IMAGE HEIGHT (newImageRect)
				Properties.velocityStart		= -70	-- PIXELS PER SECOND
				Properties.velocityVariation	= -120
				Properties.directionVariation	= 180
				Properties.alphaStart			= 0.2		-- PARTICLE START ALPHA
				Properties.alphaVariation		= 0.4
				Properties.alphaMax				= 0.5
				--Properties.fadeInSpeed			= 0.5	-- PER SECOND
				Properties.fadeOutSpeed			= -1.5	-- PER SECOND
				Properties.fadeOutDelay			= 3500	-- WHEN TO START FADE-OUT
				Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
				Properties.scaleVariation		= 0.5
				--Properties.scaleInSpeed			= 0.25
				Properties.weight				= -0.03	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
				Properties.colorStart			= {0,1,0}
				Properties.colorChange			= {0.3,0.25,0.45}
				Properties.rotationChange		= 30	-- ROTATION CHANGE PER SECOND
				Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
				Properties.emissionRadius		= 240	-- SIZE / RADIUS OF EMISSION SHAPE
				Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
				Properties.lifeTime				= 6000  -- MAX. LIFETIME OF A PARTICLE
				Properties.useEmitterRotation	= false	--INHERIT EMITTER'S CURRENT ROTATION
				Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
				Particles.CreateParticleType ("BigStar", Properties)

				
				local Properties 				= {}
				Properties.imagePath			= "anim/stars.png"
				Properties.imageWidth			= 16	-- PARTICLE IMAGE WIDTH  (newImageRect)
				Properties.imageHeight			= 16	-- PARTICLE IMAGE HEIGHT (newImageRect)
				Properties.velocityStart		= -80	-- PIXELS PER SECOND
				Properties.velocityVariation	= -120
				Properties.directionVariation	= 180
				Properties.alphaStart			= 0.2		-- PARTICLE START ALPHA
				Properties.alphaVariation		= 0.4
				Properties.alphaMax				= 0.5
				--Properties.fadeInSpeed			= 0.5	-- PER SECOND
				Properties.fadeOutSpeed			= -1.5	-- PER SECOND
				Properties.fadeOutDelay			= 3500	-- WHEN TO START FADE-OUT
				Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
				Properties.scaleVariation		= 0.5
				--Properties.scaleInSpeed			= 0.25
				Properties.weight				= -0.03	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
				Properties.colorStart			= {0,0,1}
				Properties.colorChange			= {0.2,0.15,0.25}
				Properties.rotationChange		= 30	-- ROTATION CHANGE PER SECOND
				Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
				Properties.emissionRadius		= 240	-- SIZE / RADIUS OF EMISSION SHAPE
				Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
				Properties.lifeTime				= 6000  -- MAX. LIFETIME OF A PARTICLE
				Properties.useEmitterRotation	= false	--INHERIT EMITTER'S CURRENT ROTATION
				Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
				Particles.CreateParticleType ("SmallStar", Properties)
				
				local Properties 				= {}
				Properties.imagePath			= "anim/stars.png"
				Properties.imageWidth			= 16	-- PARTICLE IMAGE WIDTH  (newImageRect)
				Properties.imageHeight			= 16	-- PARTICLE IMAGE HEIGHT (newImageRect)
				Properties.velocityStart		= -70	-- PIXELS PER SECOND
				Properties.velocityVariation	= -150
				Properties.directionVariation	= 180
				Properties.alphaStart			= 0.2		-- PARTICLE START ALPHA
				Properties.alphaVariation		= 0.4
				Properties.alphaMax				= 0.5
				--Properties.fadeInSpeed			= 0.5	-- PER SECOND
				Properties.fadeOutSpeed			= -1.5	-- PER SECOND
				Properties.fadeOutDelay			= 3500	-- WHEN TO START FADE-OUT
				Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
				Properties.scaleVariation		= 0.5
				--Properties.scaleInSpeed			= 0.25
				Properties.weight				= -0.03	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
				Properties.colorStart			= {1,0,0}
				Properties.colorChange			= {0.2,0.25,0.35}
				Properties.rotationChange		= 30	-- ROTATION CHANGE PER SECOND
				Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
				Properties.emissionRadius		= 240	-- SIZE / RADIUS OF EMISSION SHAPE
				Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
				Properties.lifeTime				= 6000  -- MAX. LIFETIME OF A PARTICLE
				Properties.useEmitterRotation	= false	--INHERIT EMITTER'S CURRENT ROTATION
				Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
				Particles.CreateParticleType ("MediumStar", Properties)

				
				
			
				snowBg = display.newRect(group,display.contentCenterX,display.contentCenterY,800,480)
				snowBg:setFillColor( 0, 0, 0 )
				snowBg.alpha = 0.5
				transition.from(snowBg,{time = 700,alpha = 0 })
				powerIndicator = display.newImage(grp,"images/acceleratep.png",display.contentCenterX,50)
				transition.from(powerIndicator,{time = 1000,alpha = 0,y = -54 })
				Animations.indicatorShift.positive(grp)
				
				ArrowCreate.toFront()
				-- FEED EMITTERS (EMITTER NAME, PARTICLE TYPE NAME, EMISSION RATE, DURATION, DELAY)
				Particles.AttachParticleType("E2", "SmallStar" ,4, 99999,0) 
				Particles.AttachParticleType("E2", "BigStar" , 4, 99999,0) 
				Particles.AttachParticleType("E2", "MediumStar" , 4, 99999,0) 

				
				-- TRIGGER THE EMITTERS
				Particles.StartEmitter("E2")
				accelerateEmitter = Particles.GetEmitter("E2")
				_allEmitters:insert(accelerateEmitter)
				
				function redo( event )

					-- UPDATE PARTICLES
					Particles.Update()
				
				end
			 
				 --timer.performWithDelay( 33, redo, 0 )
				Runtime:addEventListener( "enterFrame", redo )
				
				function animOver(event)
					transition.to(snowBg,{time = 2000,alpha = 0, onComplete = TransitionFunctions.removeFromTree })
					transition.to(powerIndicator,{time = 1000,alpha = 0,y = -54, onComplete = function() TransitionFunctions.removeFromTree(powerIndicator) ;
										
										Animations.indicatorShift.negative(grp)					
										end})
					Accelerate.stop()
					_isAccelerate = false
				end
				
				timerID = timer.performWithDelay(12500,animOver)
		elseif animState == "ongoing" then
			print("cancel")
			timer.cancel(timerID)
			timerID = timer.performWithDelay(12500,animOver)
		end			
	end,

	stop = function()
			--Particles.CleanUp()
			
			--timer.cancel(timerID)
			Particles.StopEmitter("E2");
			timer.performWithDelay(1000,function()
			accelerateEmitter = nil
			Particles.ClearParticles("E2")
			Particles.DeleteEmitter("E2")
			Runtime:removeEventListener( "enterFrame", redo )
			end)
			animState = "stopped"
		
	end,
	
	terminate = function()
			if animState ~= "init" then
				timer.cancel(timerID)
				animOver()
			end
			--Runtime:removeEventListener( "enterFrame", redo )
	end

}