
	Animations = { 
		beat = { 
			start = function(grp)
		
				Animations.beat.stop()
				beatContract = function()
					
					
					 transition.to( grp, {time = 800, xScale = 1 , yScale= 1,transition=easing.inOutQuad, tag="stop" })
					
				end 
				beatExpand = function()
					
					--print(grp.xScale)
					transition.to( grp, {time = 800, xScale = 1.3   , yScale= 1.3 ,transition=easing.inOutQuad,tag="stop" , onComplete = beatContract})
					
				end 
				beatExpand()
			end,
			stop = function()
				transition.cancel("stop")
			end
			
		
		},
		
	bigInvisible = { 
		start = function(grp)
		 transition.to( grp, {time = 500,xScale = grp.xScale + 0.2 ,yScale = grp.yScale + 0.2 , transition=easing.inOutQuad, tag="up",onComplete = function()
																			
																			transition.to( grp, {time = 1000,xScale = 0,yScale = 0,onComplete = function() 
																				grp:removeSelf() 
																				grp = nil
																				end })
																			
																			end
																			})
		
	end,
		stop = function()
			transition.cancel("up")
			
		end

	},
	
	oneUp = { 
		start = function(grp,xVal,yVal)
			local tempScore = _gameScore 
			if(grp ~= nil)then
			 transition.to( grp, {time = 1500, x= xVal, y = yVal, alpha = 0.3, transition=easing.outQuad, tag="up",onComplete = function() 
                                    grp:removeSelf() 
                                    grp = nil
                                  --[  local channel = SoundManager.play("sound/point.mp3");
                                    audio.setMaxVolume( 0.25, { channel=channel } )
                                    audio.setVolume( 0.15, { channel=channel } )--]
                                    _scoreText.text = tempScore 
                                    Animations.beat.start(_scoreText)
                                    if ScoreBox:storeIfHigher( _gameMode, _gameScore ) then
                                            _highScoreText.text = _gameScore
                                    end
                            end})
			end
	end,
		stop = function()
			transition.cancel("up")
		
	end

	},
	
	DoubleUp = { 
		start = function(grp,score,scoreText,xVal,yVal)
			local tempScore = score 
			scoreText.text = tempScore 
			if(grp ~= nil)then
			 transition.to( grp, {time = 1500, x= xVal, y = yVal, alpha = 0.3, transition=easing.linear, tag="up",onComplete = function() 
					grp:removeSelf() 
					grp = nil
					--scoreText.text = tempScore 
					--Animations.beat.start(scoreText)
					end})
			end
	end,
		stop = function()
			transition.cancel("up")
		
	end

	},
	
	arrowUp = { 
		start = function(grp,xVal,yVal,isPower)
		local count = nil
			if(grp ~= nil)then
				grp:scale(0.8,0.8)

				
				if event ~= nil then 
					if event.count==1 then
						_arrowCount = _arrowCount + 1
						count = _arrowCount
					else
						timer.performWithDelay(1000,function()
						_arrowCount = _arrowCount + 1
						count = _arrowCount
					end)
					end
					
				else	
					_arrowCount = _arrowCount + 1
					count = _arrowCount
				end
			 transition.to( grp, {time = 1000, x= xVal, y = yVal, alpha = 0.4,xScale = 0.2,yScale = 0.2, transition=easing.outQuad, tag="up",onComplete = function() 
						grp:removeSelf() 
						grp = nil
						_arrowText.text = count
					end})
			end
	end,
		stop = function()
			transition.cancel("up")
		
	end

	},
	
	
	indicatorShift = {
	
		positive = function(grp)
		
			grp:toFront()
			if grp.numChildren >= 1 then
						local total = grp.numChildren
					--	local center = math.modf(total/2) +1
						
						local center =  math.modf(total * 0.5) + 1
						for i = 1,grp.numChildren do
							if total % 2 == 0 then
									local diff	= grp[i].contentWidth 
									
								
								transition.to(grp[i],{time = 300,x = display.contentCenterX + (i - center + 0.5) * diff  })
								print("modes",i,center)
							else
							
								--local sel[i] = display.newCircle(0,0,10)
								transition.to(grp[i],{time = 300,x = display.contentCenterX + (i - center) * grp[i].contentWidth  })
							end
						end	
						
						--[[
						if total % 2 == 0 then
							for i = 1,grp.numChildren do
								center = math.modf(total/2) 
								
								if i <= center then
								--print("first",i,center)
									center = center + 1
								end
									--transition.to(grp[i],{time = 200,x = display.contentCenterX + ( grp[i].contentWidth / 2 * (i - center) ) })
									transition.to(grp[i],{time = 300,x = display.contentCenterX + ( grp[i].contentWidth / 2  * (i - center) ) })
							end
						else
							for i = 1,grp.numChildren do
								transition.to(grp[i],{time = 300,x = display.contentCenterX + ( grp[i].contentWidth  * (i - center) ) })
							end
						end
						]]--
			end
		end,
		
		negative = function(grp)
			if grp.parent  ~= nil and grp then
				grp:toFront()
				if grp.numChildren >= 1 then
							local total = grp.numChildren
							local center = math.modf(total/2) + 1
							
							
							local center =  math.modf(total * 0.5) + 1
							for i = 1,grp.numChildren do
								if total % 2 == 0 then
										local diff	= grp[i].contentWidth 
										
									
									transition.to(grp[i],{time = 300,x = display.contentCenterX + (i - center + 0.5) * diff  })
									print("modes",i,center)
								else
								
									--local sel[i] = display.newCircle(0,0,10)
									transition.to(grp[i],{time = 300,x = display.contentCenterX + (i - center) * grp[i].contentWidth  })
								end
							end	
							
							--[[
							if total % 2 == 0 then
								for i = 1,grp.numChildren do
									center = math.modf(total/2) 
									
									if i <= center then
									print("first",i,center)
										center = center + 1
									else
									print("second",i,center)
										center = center - 1
									end
										--transition.to(grp[i],{time = 200,x = display.contentCenterX + ( grp[i].contentWidth / 2 * (i - center) ) })
										transition.to(grp[i],{time = 300,x = display.contentCenterX + ( 50  * (i - center) ) })
								end
							else
								for i = 1,grp.numChildren do
									transition.to(grp[i],{time = 300,x = display.contentCenterX + ( grp[i].contentWidth / 2 * (i - center) ) })
								end
							end
							]]--
				end
			else
				grp = nil
			end
		
	end
	}
	

}