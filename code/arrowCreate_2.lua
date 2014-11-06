require("collision")
require("twinArrow")
require("timerFunctions")
require("anim.arrowSplit")
require("levelDestroyer")

ArrowCreate = {

	new = function(grp,level)
		
					
					
			local ballBody = { density=0.85, friction=0.2, bounce=0.5 }
			--

			--create bow

			local bow = display.newImage(grp, "bow.png", 0, 0, true )
			bow.x = display.contentWidth / 2 - 250
			bow.y = display.contentHeight / 2 + 100


			-- Create arrow
			local arrow = display.newImage( grp,"images/arrow3.png" )
			--arrow:scale(0.4,0.4)
			arrow.x = display.contentWidth/2 - 250
			arrow.y = display.contentHeight/2 + 100
			physicsArrow.addBody( arrow,ballBody  )
			arrow.isBullet = true
			
			--arrow.linearDamping = 0.3
			--arrow.angularDamping = 0.8
			arrow.isBullet = true -- force continuous collision detection, to stop really fast shots from passing through other balls
			arrow.color = "white"
			arrow.bodyType = "kinematic"
			arrow.myName = "arrow"
			--arrow.count = _arrowCount
			arrow.fruitsHit = 0
			arrow.level = level
			print("arrow gravity",arrow.gravityScale)
			
			
			local tip = display.newRect( 0, 0, 1, 1 )
			physicsArrow.addBody( tip, "dynamic", { density = 10, friction=0.5 } )

			tip.x = arrow.x + arrow.width/2
			tip.y = arrow.y
			tip.alpha = 0
			physicsArrow.addBody(tip)



			local turner = display.newRect( 0, 0, 21, 21 )
			turner.x = display.contentWidth/2
			turner.y = display.contentHeight/2
			turner:setFillColor (0, 0, 204, 50)
			turner.isSensor = true

			myJoint10 = physicsArrow.newJoint( "weld", arrow, tip, arrow.x+30,arrow.y )

			
			

				line_up = nil
				line_down = nil
				myLine = nil
			-- Shoot the arrow, using a visible force vector
			
			
			
			local function getTrajectoryPoint( startingPosition, startingVelocity, n )

				--velocity and gravity are given per second but we want time step values here
				local t = 1/display.fps --seconds per time step at 60fps
				local stepVelocity = { x=t*startingVelocity.x, y=t*startingVelocity.y }  --b2Vec2 stepVelocity = t * startingVelocity
				local stepGravity = { x=t*0, y=t*9 }  --b2Vec2 stepGravity = t * t * m_world
				return {
					x = startingPosition.x + n * stepVelocity.x + 0.25 * (n*n+n) * stepGravity.x,
					y = startingPosition.y + n * stepVelocity.y + 0.25 * (n*n+n) * stepGravity.y
					}  --startingPosition + n * stepVelocity + 0.25 * (n*n+n) * stepGravity
			end

			local prediction = display.newGroup() ; prediction.alpha = 0.2

			local function updatePrediction( event )

				display.remove( prediction )  --remove dot group
				prediction = display.newGroup() ; prediction.alpha = 0.4  --now recreate it
				grp:insert(prediction)
				local startingVelocity = { x = -(arrow.x - bow.x)*32 , y = -(arrow.y - bow.y)*25 }
				
				for i = 1,20 do --for (int i = 0; i < 180; i++)
					local s = { x=event.xStart, y=event.yStart }
					local trajectoryPosition = getTrajectoryPoint( s, startingVelocity, i ) -- b2Vec2 trajectoryPosition = getTrajectoryPoint( startingPosition, startingVelocity, i )
					local circ = display.newCircle( prediction, trajectoryPosition.x, trajectoryPosition.y, 5 )
				end
			end
			
			
			
			local function arrowShot( event )
					local t = event.target
			 
					local phase = event.phase
					if "began" == phase then
					
								if (myLine) then
									myLine.parent:remove(myLine)
									line_up.parent:remove(line_up)
									line_down.parent:remove(line_down) 
								end
							display.getCurrentStage():setFocus( t )
							t.isFocus = true
							arrow.bodyType = "kinematic"

							-- Stop current arrow motion, if any
							--t:setLinearVelocity( 0, 0 )
							--t.angularVelocity = 0
							arrow:setLinearVelocity( 0, 0 )
							arrow.angularVelocity = 0
							arrow.x = t.x 
							arrow.y = t.y
							
							
							line_up = display.newLine(grp,t.x  - (t.contentWidth / 2 * math.cos(bow.rotation * (math.pi/180) ) ),t.y - (t.contentHeight / 2 * math.sin(bow.rotation * (math.pi/180) ) ),bow.x  + (bow.height /2 * math.sin(bow.rotation * (math.pi/180) ) ) ,bow.y - (bow.height /2 * math.cos(bow.rotation * (math.pi/180) ) ) )
							line_down = display.newLine(grp,t.x - (t.contentWidth / 2 * math.cos(bow.rotation * (math.pi/180) ) ),t.y - (t.contentHeight / 2 * math.sin(bow.rotation * (math.pi/180) )),bow.x  - (bow.height /2 * math.sin(bow.rotation * (math.pi/180) ) ),bow.y +  (bow.height /2 * math.cos(bow.rotation * (math.pi/180) ) ))
							myLine = display.newLine(grp,0,0,1,1)	
							
							
							
					elseif t.isFocus then
							if "moved" == phase  then
				
								
								
								if (myLine) then
									myLine.parent:remove(myLine)
									line_up.parent:remove(line_up)
									line_down.parent:remove(line_down) 
								end
								
								arrow.bodyType = "kinematic"
					
								-- get distance 
								dX = bow.x-arrow.x						------Thank canupa.com from the forums for the-----
								dY = bow.y-arrow.y 						------------arrow rotating with touch--------------
								-- calculate rotation						--------------------------------------
								--arrow.rotation = math.atan2(dY, dX)/(math.pi/180);    
								bow.rotation = math.atan2(dY, dX)/(math.pi/180); 
								--print(bow.rotation)
								if bow.rotation > 77  then
									bow.rotation = 77
								elseif bow.rotation < -77 then 
									bow.rotation = -77
								end
								arrow.rotation = bow.rotation
								
								line_up = display.newLine(grp,t.x  - (t.contentWidth / 2 * math.cos(bow.rotation * (math.pi/180) ) ),t.y - (t.contentHeight / 2 * math.sin(bow.rotation * (math.pi/180) ) ),bow.x  + (bow.height /2 * math.sin(bow.rotation * (math.pi/180) ) ) ,bow.y - (bow.height /2 * math.cos(bow.rotation * (math.pi/180) ) ) )
								line_down = display.newLine(grp,t.x - (t.contentWidth / 2 * math.cos(bow.rotation * (math.pi/180) ) ),t.y - (t.contentHeight / 2 * math.sin(bow.rotation * (math.pi/180) )),bow.x  - (bow.height /2 * math.sin(bow.rotation * (math.pi/180) ) ),bow.y +  (bow.height /2 * math.cos(bow.rotation * (math.pi/180) ) ))
								myLine = display.newLine(grp,0,0,1,1)
								 
								
									-- Boundary for the arrow when grabbed			
									local bounds = event.target.stageBounds;
									bounds.xMax = bow.x - 100;
									bounds.yMax = bow.y + 100;
									if(event.y > bounds.yMax ) then
										event.y = bow.y + 50;
									else
										--print("nothing")
									end
									if(event.x < bounds.xMax) then
										event.x = bow.x - 50;
									else
										--print("nothing")
										-- Do nothing
									end	
									arrow.x = event.x 
									arrow.y = event.y
									
									--updatePrediction(event)
			 
			 
							elseif "ended" == phase or "cancelled" == phase then
									
									if _isArrowSplit then
										local obj1,obj2 = TwinArrow.new(grp,arrow,300,700)
										obj1:addEventListener( "preCollision",Collision.arrowPreCollision )
										obj2:addEventListener( "preCollision",Collision.arrowPreCollision )
									end
									display.getCurrentStage():setFocus( nil )
									t.isFocus = false
									  tempRotation = math.abs(t.rotation)							--------------------------------------
											   
									-- Strike the arrow!
									arrow.bodyType = "dynamic"
									--print(t.x,t.y)
									if(t.x > 65) then
										arrow:setLinearVelocity( -(arrow.x - bow.x)*32, -(arrow.y - bow.y)*25, arrow.x, arrow.y )
									else
										arrow:applyForce( -(arrow.x - bow.x)*24, -(arrow.y - bow.y)*25, arrow.x, arrow.y )
									end
								
								if arrow.level == "arcade" then
									_arrowCount = _arrowCount - 1
									_arrowText.text = _arrowCount
								end
								
								arrow:removeEventListener( "touch", arrowShot )
								bow:removeEventListener( "touch", arrowShot )
							end
					end
			 
					-- Stop further propagation of touch event
					return true
			end
			 
			 function moveBow( event )
				bow.rotation = event.target.rotation
			end
			 
			arrow:addEventListener( "touch", arrowShot )
			bow:addEventListener( "touch", arrowShot )
			bow:addEventListener( "touch", moveBow )

			function distance( a, b )
				local width, height = b.x-a.x, b.y-a.y
				return math.sqrt( width*width + height*height )
			end


			local tmax = distance( {x=0,y=0}, {x=display.contentWidth,y=display.contentHeight} )
			local strength = 1000 --The smaller the number the more force the magnet has
			local magnet = nil

			function touch( event )
				if (event.phase == "began" or event.phase == "moved") then
					magnet = event
				else
					magnet = nil
				end
			end

			function doMagnet( event )
						turner.y = 270
						local dist = distance( turner, tip )
						
						local power = tmax/dist / strength
						
						local xmove = (turner.x-tip.x) * power
						local ymove = (turner.y-tip.y + 20) * power
						
						tempRotation = math.abs(arrow.rotation)
						if arrow.rotation < 0 then
							if arrow.rotation < tempRotation then
							
								tip:applyForce( 0, 0.7 , tip.x ,tip.y )
								--print("this",tempRotation,arrow.rotation)
								else
								--print("that",tempRotation,arrow.rotation)
								tip:applyForce( 0, -1.5 , tip.x ,tip.y )
							end
						else
							--print("that",tempRotation,arrow.rotation)
								tip:applyForce( 0, -0.7 , tip.x ,tip.y )
							
							
						end	
						
						--removing object/ fruits that are go beyond 1000 pixels in Y axis 
						
						for i=1,grp.numChildren do 
							--print(i)
							if grp[i] ~=nil and grp[i].y > 1000 then  
								grp[i]:removeSelf()
								grp[i] = nil
							end

						end
			end

			function newArrow(event)

				local function arrowReset()
						print(arrow.fruitsHit)
							arrow.fruitsHit = 0
							arrow.anchorX = 0.5
							
							bow.rotation = 0
							arrow.rotation = 0						--------------------------------------
							
							arrow.x = display.contentWidth/2 - 250
							arrow.y = display.contentHeight/2 + 100
							tip.x = arrow.x + arrow.width/2
							tip.y = arrow.y
							arrow.bodyType = "kinematic"
							   arrow:setLinearVelocity( 0, 0 )
								arrow.angularVelocity = 0
							   tip:setLinearVelocity( 0, 0 )
								tip.angularVelocity = 0
							
							arrow:addEventListener( "touch", arrowShot )
							bow:addEventListener( "touch", arrowShot )	
							if _arrowCount == 0 then
								arrow:removeEventListener( "touch", arrowShot )
								bow:removeEventListener( "touch", arrowShot )
								LevelDestroyer.destroy(doMagnet,newArrow)
								--LevelBuilder.gameOver()
								storyboard.gotoScene( "gameOverScreen", "fade", 1000 )
							end	
									if (myLine) then
										myLine.parent:remove(myLine)
										line_up.parent:remove(line_up)
										line_down.parent:remove(line_down) 
									end
									
								line_up = display.newLine(grp,arrow.x  - (arrow.contentWidth / 2 * math.cos(bow.rotation * (math.pi/180) ) ),arrow.y - (arrow.contentHeight / 2 * math.sin(bow.rotation * (math.pi/180) ) ),bow.x  + (bow.height /2 * math.sin(bow.rotation * (math.pi/180) ) ) ,bow.y - (bow.height /2 * math.cos(bow.rotation * (math.pi/180) ) ) )
								line_down = display.newLine(grp,arrow.x - (arrow.contentWidth / 2 * math.cos(bow.rotation * (math.pi/180) ) ),arrow.y - (arrow.contentHeight / 2 * math.sin(bow.rotation * (math.pi/180) )),bow.x  - (bow.height /2 * math.sin(bow.rotation * (math.pi/180) ) ),bow.y +  (bow.height /2 * math.cos(bow.rotation * (math.pi/180) ) ))
								myLine = display.newLine(grp,0,0,1,1)
				
				
				end
			
				if(arrow ~= nil) then
					--if(arrow.y > display.contentHeight + 100 or arrow. x > display.contentWidth + 100) then
					if(arrow.y > display.contentHeight + 100 or arrow. x > display.contentWidth + 100) then
						if arrow.level == "arcade" and _arrowCount >= 0 then
							arrowReset()
						else
							arrowReset()
						end
					end	
				end	


			end
	
	
		
	Runtime:addEventListener( "enterFrame", doMagnet )
	Runtime:addEventListener( "enterFrame", newArrow )
	arrow:addEventListener( "preCollision",Collision.arrowPreCollision )
	tip:addEventListener( "collision",Collision.tipPreCollision )
		print(grp)
	end,

}