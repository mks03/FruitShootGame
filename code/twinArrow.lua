
TwinArrow = {

	new = function(grp,realArrow,x,y)
	
		local arrow1 = display.newImage( grp,"images/arrow.png" )
		physicsArrow.addBody( arrow1,{ density=0.85, friction=0.2, bounce=0.5 }  )
		arrow1.x = realArrow.x
		arrow1.y = realArrow.y - 80
		arrow1.fruitsHit = 0
		arrow1.rotation = realArrow.rotation
		
		local arrow2 = display.newImage( grp,"images/arrow.png" )
		physicsArrow.addBody( arrow2,{ density=0.85, friction=0.2, bounce=0.5 }  )
		arrow2.x = realArrow.x
		arrow2.y = realArrow.y + 80
		arrow2.fruitsHit = 0
		arrow2.rotation = realArrow.rotation
		
		function update(event)
			if (realArrow.x < display.contentWidth  and realArrow.x > 0 ) and (realArrow.y < display.contentHeight and realArrow.y > -20 ) then
				
					arrow1.x = realArrow.x
					arrow1.y = realArrow.y - 80
					arrow1.rotation = realArrow.rotation
					arrow2.x = realArrow.x
					arrow2.y = realArrow.y + 80
					arrow2.rotation = realArrow.rotation
			else
				print("Delete Arrow")
				arrow1:removeSelf()
				arrow1 = nil
				arrow2:removeSelf()
				arrow2 = nil
				Runtime:removeEventListener("enterFrame",update)
			end
		end
		
		Runtime:addEventListener("enterFrame",update)
		return arrow1,arrow2
	end,
	
}