
	beat = { new = function(grp)
	
		grp.x = display.contentCenterX
		grp.y = display.contentCenterY + 180
	
	beatContract = function()
		
		
		 transition.to( grp, {time = 1000, xScale = 0.8 , yScale= 0.8,transition=easing.inOutQuad, tag="stop", onComplete = beatExpand })
		
	end 
	beatExpand = function()
		
		print("1" , grp)
		transition.to( grp, {time = 1000, xScale = 1 , yScale= 1 ,transition=easing.inOutQuad,tag="stop" , onComplete = beatContract})
		
	end 
	transition.cancel("stop")
	beatContract()
end,
	stop = function()
		transition.cancel("stop")
		
	end

}