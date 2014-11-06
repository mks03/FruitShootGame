

local screenW = display.contentWidth
local screenH = display.contentHeight
local snowBg
local powerIndicator
local Particles
local animState = "init"
local timerID = nil
local redo 
local animOver
local snowEmitter

	Snow = { 
	
	start = function(mode,grp,grpEmitter)
		print("state",animState)
		if 	animState == "init" or animState == "stopped" then
			
					animState = "ongoing"
					if mode == "timeMode" then
						timer.pause( _clockId )
					end
					Particles = require("anim.lib_particle_candy")
					-- CREATE EMITTERS (NAME, SCREENW, SCREENH, ROTATION, ISVISIBLE, LOOP)
					Particles.EnableDebug(false)
					Particles.CreateEmitter("E1", screenW*0.5, 0, 180, false, true)

					-- DEFINE PARTICLE TYPE PROPERTIES
					local Properties 				= {}
					Properties.imagePath			= "anim/snow5.png"
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
					Particles.CreateParticleType ("BigSnow", Properties)

					local Properties 				= {}
					Properties.imagePath			= "anim/snow2.png"
					Properties.imageWidth			= 64	-- PARTICLE IMAGE WIDTH  (newImageRect)
					Properties.imageHeight			= 64	-- PARTICLE IMAGE HEIGHT (newImageRect)
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
					Particles.CreateParticleType ("SmallSnow", Properties)

					-- DEFINE PARTICLE TYPE PROPERTIES
					local Properties 				= {}
					Properties.imagePath			= "anim/smoke.png"
					Properties.imageWidth			= 256	-- PARTICLE IMAGE WIDTH  (newImageRect)
					Properties.imageHeight			= 256	-- PARTICLE IMAGE HEIGHT (newImageRect)
					Properties.velocityStart		= 0		-- PIXELS PER SECOND
					Properties.alphaStart			= 0		-- PARTICLE START ALPHA
					Properties.fadeInSpeed			= 0.20	-- PER SECOND
					Properties.fadeOutSpeed			= -0.5	-- PER SECOND
					Properties.fadeOutDelay			= 2000	-- WHEN TO START FADE-OUT
					Properties.scaleStart			= 1.0	-- PARTICLE START SIZE
					Properties.scaleVariation		= 1.5	-- RANDOM SCALE VARIATION
					Properties.rotationVariation	= 360	-- RANDOM ROTATION
					Properties.rotationChange		= 10	-- ROTATION CHANGE PER SECOND
					Properties.weight				= 0.02	-- PARTICLE WEIGHT (>0 FALLS DOWN, <0 WILL RISE UPWARDS)
					Properties.emissionShape		= 1		-- 0 = POINT, 1 = LINE, 2 = RING, 3 = DISC
					Properties.emissionRadius		= 100	-- LENGTH OF EMISSION LINE
					Properties.killOutsideScreen	= false	-- PARENT LAYER MUST NOT BE NESTED OR ROTATED! 
					Properties.lifeTime				= 4000  -- MAX. LIFETIME OF A PARTICLE
					Particles.CreateParticleType ("Smoke", Properties)

					
					snowBg = display.newImage(group,"images/snow_bg.png",display.contentCenterX,display.contentCenterY)
					transition.from(snowBg,{time = 700,alpha = 0 })
					
					
					powerIndicator = display.newImage(grp,"images/freezep.png",display.contentCenterX,50)
					transition.from(powerIndicator,{time = 1000,alpha = 0,y = -54 })
					
					Animations.indicatorShift.positive(grp)
					
					
					-- FEED EMITTERS (EMITTER NAME, PARTICLE TYPE NAME, EMISSION RATE, DURATION, DELAY)
					Particles.AttachParticleType("E1", "SmallSnow" , 8, 99999,0) 
					Particles.AttachParticleType("E1", "BigSnow" , 3, 99999,0) 
					Particles.AttachParticleType("E1", "Smoke", 2, 99999,0) 
					
					snowEmitter = Particles.GetEmitter("E1")
					grpEmitter:insert(snowEmitter)
					
					-- TRIGGER THE EMITTERS
					Particles.StartEmitter("E1")
					
					function redo( event )

						-- UPDATE PARTICLES
						Particles.Update()
					
					end
				 
				 timer.performWithDelay( 33, redo, 0 )
				--Runtime:addEventListener( "enterFrame", redo )
				
				function animOver(event)
					transition.to(snowBg,{time = 2000,alpha = 0, onComplete = TransitionFunctions.removeFromTree })
					transition.to(powerIndicator,{time = 1000,alpha = 0,y = -54, onComplete = function() TransitionFunctions.removeFromTree(powerIndicator) ;	
										Animations.indicatorShift.negative(grp)					
										end})
					
					--Animations.indicatorShift.negative(grp)
					
					
					if mode == "timeMode" then
						timer.resume( _clockId )
					end
					Snow.stop()
					_isFreeze = false
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
			Particles.StopEmitter("E1");
			timer.performWithDelay(1000,function()
			accelerateEmitter = nil
			Particles.ClearParticles("E1")
			Particles.DeleteEmitter("E1")
			end)
		animState = "stopped"
		
	end,
	
	terminate = function()
	
			if animState == "ongoing" then
				timer.cancel(timerID)
				animOver()
			end
	end

}