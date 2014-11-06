

local screenW = display.contentWidth
local screenH = display.contentHeight
local snowBg 
local powerIndicator
local Particles
local animState = "init"
local timerID = nil
local redo 
local animOver
local zoomEmitter

	Zoom = { 
	
	start = function(grp,grpEmitter)
		print("state",animState)
		if 	animState == "init" or animState == "stopped" then
				animState = "ongoing"
					
				Particles = require("anim.lib_particle_candy")
				-- CREATE EMITTERS (NAME, SCREENW, SCREENH, ROTATION, ISVISIBLE, LOOP)
				Particles.CreateEmitter("E3", screenW*0.5, 0, 180, false, true)

				-- DEFINE PARTICLE TYPE PROPERTIES
				local Properties 				= {}
				Properties.imagePath			= "anim/stars.png"
				Properties.imageWidth			= 16	-- PARTICLE IMAGE WIDTH  (newImageRect)
				Properties.imageHeight			= 16	-- PARTICLE IMAGE HEIGHT (newImageRect)
				Properties.velocityStart		= 50	-- PIXELS PER SECOND
				Properties.velocityVariation	= 50
				Properties.directionVariation	= 180
				Properties.alphaStart			= 0		-- PARTICLE START ALPHA
				Properties.fadeInSpeed			= 0.5	-- PER SECOND
				Properties.fadeOutSpeed			= -1.5	-- PER SECOND
				Properties.fadeOutDelay			= 3500	-- WHEN TO START FADE-OUT
				Properties.scaleStart			= 0.5	-- PARTICLE START SIZE
				Properties.scaleVariation		= 0.5
				--Properties.scaleInSpeed			= 0.25
				Properties.weight				= 0.03	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
				Properties.rotationChange		= 30	-- ROTATION CHANGE PER SECOND
				Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
				Properties.emissionRadius		= 240	-- SIZE / RADIUS OF EMISSION SHAPE
				Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
				Properties.lifeTime				= 6000  -- MAX. LIFETIME OF A PARTICLE
				Properties.useEmitterRotation	= false	--INHERIT EMITTER'S CURRENT ROTATION
				Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
				Particles.CreateParticleType ("BigFlakes", Properties)

				local Properties 				= {}
				Properties.imagePath			= "anim/stars2.png"
				Properties.imageWidth			= 16	-- PARTICLE IMAGE WIDTH  (newImageRect)
				Properties.imageHeight			= 16	-- PARTICLE IMAGE HEIGHT (newImageRect)
				Properties.velocityStart		= 50	-- PIXELS PER SECOND
				Properties.velocityVariation	= 50
				Properties.directionVariation	= 180
				Properties.alphaStart			= 0		-- PARTICLE START ALPHA
				Properties.fadeInSpeed			= 1.5	-- PER SECOND
				Properties.fadeOutSpeed			= -1.0	-- PER SECOND
				Properties.fadeOutDelay			= 3500	-- WHEN TO START FADE-OUT
				Properties.scaleStart			= 0.25	-- PARTICLE START SIZE
				Properties.scaleVariation		= 1.0
				Properties.scaleInSpeed			= 0.25
				Properties.weight				= 0.01	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
				Properties.rotationChange		= 15	-- ROTATION CHANGE PER SECOND
				Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
				Properties.emissionRadius		= 240	-- SIZE / RADIUS OF EMISSION SHAPE
				Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
				Properties.lifeTime				= 6000  -- MAX. LIFETIME OF A PARTICLE
				Properties.useEmitterRotation	= false	--INHERIT EMITTER'S CURRENT ROTATION
				Properties.blendMode			= "add" -- SETS BLEND MODE ("add" OR "normal", DEFAULT IS "normal")
				Particles.CreateParticleType ("SmallFlakes", Properties)

				
				
				snowBg = display.newImage(group,"images/zoom_bg.png",display.contentCenterX,display.contentCenterY)
				transition.from(snowBg,{time = 700,alpha = 0 })
				
				powerIndicator = display.newImage(grp,"images/zoomp.png",display.contentCenterX,50)
				transition.from(powerIndicator,{time = 1000,alpha = 0,y = -54 })
				ArrowCreate.toFront()
				Animations.indicatorShift.positive(grp)
				
				-- FEED EMITTERS (EMITTER NAME, PARTICLE TYPE NAME, EMISSION RATE, DURATION, DELAY)
				Particles.AttachParticleType("E3", "SmallFlakes" , 8, 99999,0) 
				Particles.AttachParticleType("E3", "BigFlakes" , 3, 99999,0) 
				zoomEmitter = Particles.GetEmitter("E3")
				grpEmitter:insert(zoomEmitter)
				
				-- TRIGGER THE EMITTERS
				Particles.StartEmitter("E3")
				
				function redo( event )

					-- UPDATE PARTICLES
					Particles.Update()
				
				end
			 
				
				Runtime:addEventListener( "enterFrame", redo )
				
				function animOver(event)
					transition.to(snowBg,{time = 2000,alpha = 0, onComplete = TransitionFunctions.removeFromTree })
					transition.to(powerIndicator,{time = 1000,alpha = 0,y = -54, onComplete = function() TransitionFunctions.removeFromTree(powerIndicator) ;	
										Animations.indicatorShift.negative(grp)					
										end})
					
					
					--Animations.indicatorShift.negative(grp)
					
					Zoom.stop()
					_isZoom = false
				end
				
			timerID	= timer.performWithDelay(12500,animOver)
		elseif animState == "ongoing" then
			print("cancel")
			timer.cancel(timerID)
			timerID = timer.performWithDelay(12500,animOver)
		end			
	end,

	stop = function()
	
			Particles.StopEmitter("E3");
			timer.performWithDelay(1700,function()
			accelerateEmitter = nil
			Particles.ClearParticles("E3")
			Particles.DeleteEmitter("E3")
			Runtime:removeEventListener( "enterFrame", redo )
			end)
		Runtime:removeEventListener( "enterFrame", redo )
		animState = "stopped"
		
	end,
	
	terminate = function()
	
			if animState ~= "init" then
				timer.cancel(timerID)
				animOver()
			end
	end

}