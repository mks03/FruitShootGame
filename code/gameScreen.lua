require("levelBuilder")
require("fruitCreate")
require("powerCreate")
require("arrowCreate")

local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true



function scene:createScene(event)
group = nil
group = self.view
print("EVENt",event.params.mode)
_gameMode = event.params.mode
if _gameMode == "kidMode" then _gameMode = "arcade" end
LevelBuilder.new(_gameMode,group)
 --group:insert(_powerGroup)
	
--	timer.performWithDelay(1200,function(event)
	--				value = _currentPower
		--			FruitCreate.new(group,200,400,value) 
			--		end,15 )		

FruitCreate.new(group,200,400)
					
_powerId = timer.performWithDelay(math.random(7000,20000),function(event)
						PowerCreate.new(group,200,400)
					end )
					
					
					
ArrowCreate.new(group,_gameMode)

	_allEmitters.alpha = 0
	timer.performWithDelay(1000,function() transition.to(_allEmitters,{time =1000,alpha = 1}) end )

end

function scene:enterScene(event)
	print("destroy")
end


function scene:exitScene(event)
	print("exitttttt")
	transition.to(_allEmitters,{time = 1000,alpha = 0})
end

function scene:destroyScene(event)
	print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene