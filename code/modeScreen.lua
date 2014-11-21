local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true


local screenGroup
local channel
function scene:createScene(event)

	local modeGroup = self.view
	
	local slideView = require("slideView")
	
	local myImages = {
		"images/TimeMode.png",
		"images/KidMode.png",
		"images/Arcade.png",
		--"images/game.png"
		}
		
	screenGroup = slideView.new( myImages , "images/bg2.jpg")
	modeGroup:insert(screenGroup)
end

function scene:enterScene(event)

	local params = event.params
	channel = params.param1
	print("destroy")
end


function scene:exitScene(event)
	
	
end

function scene:destroyScene(event)
	SoundManager.stop(channel)
	print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene