require("collision")


function endTransition(event)
		
			transition.cancel(event)
			event:removeSelf()
			event = nil
end

function rotateFruit(obj)
		obj.rotation = obj.rotation
		transition.to( obj, { rotation = obj.rotation + 360,time = 2500, onComplete=rotateFruit } )
	end

function forceCalc(val,size)
			local FX,FY
			if _isFreeze then
				local multiplier = 1
					if _isZoom then
						multiplier = 1.68
					end
				
				if size == "small" then
					FX = math.random(-60,90)
					FY = math.random(-600,-350) * multiplier
					
				elseif size == "medium" then
					FX = math.random(-150,150)
					FY = math.random(-1550,-900) * multiplier
				else
					FX = math.random(-200,200)
					FY = math.random(-2300,-1400) * multiplier
				
				end	
				
			elseif val == "zoom" then
				if size == "small" then
					FX = math.random(-150,200)
					FY = math.random(-2600,-1400)
					--FY = -2350
					
				elseif size == "medium" then
					FX = math.random(-350,500)
					FY = math.random(-5600,-3600)
				else
					FX = math.random(-700,900)
					FY =  math.random(-9000,-5600)
					--FY =  -9000
				
				end
			
			else
				if size == "small" then
					FX = math.random(-80,100)
					--FY = -1300
					FY = math.random(-1300,-750)
					
				elseif size == "medium" then
					FX = math.random(-300,300)
					FY = math.random(-3100,-2000)
					--FY = -3100
				else
					FX = math.random(-500,600)
					FY =  math.random(-5300,-3400)
					--FY =  -5300
				
				end
				
			
			end
			return FX,FY
end
local fruits = {"blueberry","cherry","lemon","rasberry","strawberry","apple","banana","bluemelon","grape","greenapple","greenapple2","orange","orange2","peach","pear","coconut","pineapple","pomi","watermelon"}
local fruitsPoints = {30,30,30,30,30,20,20,20,20,20,20,20,20,20,20,10,10,10,10}
local fruitsSize = {"small","medium","large"}


FruitCreate = {

	new = function(grp,x,y)
	
		 
		local physicsData = (require "shapedefs").physicsData(1.0)
		if _isZoom then
			physicsData = (require "shapedefs").physicsData(1.3)
		end
		--print("shape",physicsData,physicsData2)
		local fruitImg
		local num = math.random(#fruits)
		local fruitName = fruits[num]
		local fruitGap = math.random(600,1200)
		local forceX,forceY
		physics.setGravity( 0, 9 )
		
		x,y = math.random(350,650),math.random(480,480)
		fruitImg = display.newImage(grp,"fruits/" .. fruitName .. ".png",x,y)
		fruitImg.name = fruitName
		fruitImg.type = "fruits"
		fruitImg.score = fruitsPoints[num]
		fruitImg.outLine = false
		if num < 6 then
			fruitImg.size = "small"
		elseif num < 16 then
			fruitImg.size = "medium"
		else
			fruitImg.size = "large"
		end	
		physics.addBody( fruitImg, "dynamic",physicsData:get(fruitName))
		
		--print(fruitImg.name,fruitImg.mass)
		
		forceX,forceY = forceCalc("normal",fruitImg.size)
		
			if _isZoom then
				fruitImg:scale(1.3,1.3)
				fruitGap = math.random(500,1000)
				forceX,forceY = forceCalc("zoom",fruitImg.size)
				if _isZoomStart then
					Zoom.start(_powerGroup,_allEmitters)
					_isZoomStart = false
				end
			end
			
			if _isFreeze then
				
				fruitImg.outline = true
				--physics.setGravity( 0, 2 )
				fruitImg.gravityScale = 0.22
				fruitGap = math.random(500,900)
				forceX,forceY = forceCalc("freeze",fruitImg.size)
				if _isFreezeStart then
					Snow.start(_gameMode,_powerGroup,_allEmitters)
					_isFreezeStart = false
				end
			end
			
			if _isAccelerate then
				fruitGap = math.random(150,400)
				if _isAccelerateStart then
					Accelerate.start(_powerGroup,_allEmitters)
					_isAccelerateStart = false
				end
			
			end
		
				
			fruitImg:applyForce( forceX, forceY, fruitImg.x, fruitImg.y )
		
		--[[transition.to( fruitImg, { y = math.random(100,300), x = fruitImg.x + math.random(-100,100), time=math.random(3000,5000) ,onComplete = function() 
		
									
									transition.to( fruitImg, { y = display.viewableContentHeight , x = fruitImg.x + math.random(-100,100), time=math.random(3000,4000), onComplete = function() 
												fruitImg:removeSelf(); fruitImg = nil
											end} ) 
									end } )
		--]]		
		rotateFruit(fruitImg)
		function abc(event)
			--print(event.name)
		end
		
		
		fruitImg:addEventListener( "preCollision",Collision.fruitPreCollision )
		-- Generates fruits by using FruitCreate recursively
		_fruitId = timer.performWithDelay(fruitGap,function(event)
							--value = _currentPower
						FruitCreate.new(group,200,400)
					
					end )
		
		return fruitImg
	end,
	
}