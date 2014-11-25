local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true


local screenGroup
local channel

  local function onKeyEvent(event)

        local phase = event.phase

        if event.phase=="up" and event.keyName=="back" then
            storyboard.gotoScene("menu", "fade", 500 )
            return true
        end
        return false
    end

function scene:createScene(event)

	local modeGroup = self.view
	
	local slideView = require("slideView")
	
	local myImages = {
		"images/TimeMode.png",
		"images/KidMode.png",
		"images/Arcade.png",
		--"images/game.png"
		}
		
	screenGroup = slideView.new( myImages , "images/background_menu.jpg")
	modeGroup:insert(screenGroup)
end

function scene:enterScene(event)

	local params = event.params
	channel = params.param1
	print("destroy")
	Runtime:addEventListener( "key", onKeyEvent )
end


function scene:exitScene(event)
	
	
	Runtime:removeEventListener( "key", onKeyEvent )
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