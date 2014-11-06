

local screenW = display.contentWidth
local screenH = display.contentHeight
local Particles
local redo 
local gameOverEmitterUp
local gameOverEmitterDown

	GameOverAnim = { 
	
	start = function(grp)
				Particles = require("anim.candy")

				-- CREATE EMITTERS (NAME, SCREENW, SCREENH, ROTATION, ISVISIBLE, LOOP)
				Particles.CreateEmitter("E5", screenW*0.5, screenH*0.4, 0, false, false)
				Particles.CreateEmitter("E6", screenW*0.5, screenH*0.4, 0, false, false)

				-- DEFINE PARTICLE TYPE PROPERTIES
				local Properties 				= {}
				Properties.imagePath			= "anim/snow3.png"
				Properties.imageWidth			= 80	
				Properties.imageHeight			= 80	
				Properties.velocityStart		= -400	
				Properties.velocityVariation	= 200
				Properties.directionVariation	= 180
				Properties.alphaStart			= 0		
				Properties.alphaVariation		= .50		
				Properties.fadeInSpeed			= 2.0	
				Properties.fadeOutSpeed			= -1.0	
				Properties.fadeOutDelay			= 1200	
				Properties.scaleStart			= 0.15	
				Properties.scaleVariation		= 0.2
				Properties.colorStart			= {0,0,0}
				--Properties.scaleInSpeed			= 0.25
				Properties.xReference			= 0.5
				Properties.weight				= 0.0
				Properties.rotationVariation	= 360
				Properties.rotationChange		= 90
				Properties.emissionShape		= 0		
				Properties.killOutsideScreen	= false	
				Properties.lifeTime				= 3000  
				Properties.useEmitterRotation	= false	
				Properties.blendMode			= "add"
				Particles.CreateParticleType ("FairyDustDown", Properties)


				local Properties 				= {}
				Properties.imagePath			= "anim/snow3.png"
				Properties.imageWidth			= 80	
				Properties.imageHeight			= 80	
				Properties.velocityStart		= 100	
				Properties.velocityVariation	= 220
				Properties.directionVariation	= 280
				Properties.alphaStart			= 0		
				Properties.alphaVariation		= 0.35		
				Properties.fadeInSpeed			= 2.0	
				Properties.fadeOutSpeed			= -1.0	
				Properties.fadeOutDelay			= 1000	
				Properties.scaleStart			= 0.15	
				Properties.scaleVariation		= 0.2
				Properties.colorStart			= {0,0,0}
				--Properties.scaleInSpeed			= 0.25
				Properties.weight				= 0
				Properties.rotationVariation	= 360
				Properties.rotationChange		= 90
				Properties.emissionShape		= 0
				Properties.emissionRadius		= 240	-- SIZE / RADIUS OF EMISSION SHAPE		
				Properties.killOutsideScreen	= false	
				Properties.lifeTime				= 3000  
				Properties.useEmitterRotation	= false	
				Properties.blendMode			= "add"
				Particles.CreateParticleType ("FairyDustUp", Properties)

				-- FEED EMITTERS (EMITTER NAME, PARTICLE TYPE NAME, EMISSION RATE, DURATION, DELAY)
				Particles.AttachParticleType("E5", "FairyDustDown" , 25, 999999,0) 
				Particles.AttachParticleType("E6", "FairyDustUp" , 25, 999999,0) 
				
				gameOverEmitterUp = Particles.GetEmitter("E6")
				gameOverEmitterDown = Particles.GetEmitter("E5")
			
				
				grp:insert(gameOverEmitterUp)
				grp:insert(gameOverEmitterDown)
				transition.from(gameOverEmitterDown,{time =700,alpha = 0})
				transition.from(gameOverEmitterUp,{time =700,alpha = 0})
				
				-- TRIGGER THE EMITTERS
				Particles.StartEmitter("E5")
				Particles.StartEmitter("E6")
				function redo( event )
					-- UPDATE PARTICLES
					Particles.SetParticleProperty("FairyDustDown", "colorStart", {math.random(10)/10,math.random(10)/10,math.random(10)/10})
					Particles.SetParticleProperty("FairyDustUp", "colorStart", {math.random(10)/10,math.random(10)/10,math.random(10)/10})
					Particles.Update()
				end
			 
				--timer.performWithDelay( 33, redo, 0 )
				Runtime:addEventListener( "enterFrame", redo )
				
				
	end,

	stop = function()
			--Particles.CleanUp()
			--timer.cancel(timerID)

			gameOverEmitterDown = nil
			gameOverEmitterUp = nil
			Particles.ClearParticles("E5")
			Particles.ClearParticles("E6")
			Particles.DeleteEmitter("E5")
			Particles.DeleteEmitter("E6")
			Runtime:removeEventListener( "enterFrame", redo )
	end,
	
	cleanUp = function()
		Particles.CleanUp()
	end

}