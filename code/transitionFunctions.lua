
TransitionFunctions = {

	removeFromTree = function(event)
			print(event,event.x,event.parent)
		if event.parent ~= nil and event then
			print(event)
			event:removeSelf()		
			event = nil
		end	
	end,
	
}