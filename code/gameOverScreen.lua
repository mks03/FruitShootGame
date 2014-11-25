
require("anim.gameOverAnim")

local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true

local gameOverGroup = nil
local restartBtn
local homeBtn
local goHome
local score
local highScore
local restart
local background
local childGroup


local function onKeyEvent(event)
	
		local phase = event.phase
			
		if event.phase=="up" and event.keyName=="back" then
			storyboard.gotoScene("modeScreen", "fade", 500 )
			return true
		end
		return false
	end

function scene:createScene(event)
    
    print("createScene")
    gameOverGroup = self.view
    childGroup = nil
    childGroup = display.newGroup()
    gameOverGroup:insert(childGroup)
    --childGroup.alpha = 0
    timer.performWithDelay(1000,function() GameOverAnim.start(childGroup)  end )
    homeBtn,restartBtn = LevelDestroyer.gameReset(gameOverGroup,childGroup)
    local channel = SoundManager.play("sound/game_over.mp3");
    
end

function scene:enterScene(event)
    print("enterScene")
    
    if(math.random(3) == 2) then
        ads.show( "interstitial", { x=0, y=display.contentHeight - 60, appId="ca-app-pub-2883837174861368/8733901931" }) 
    else
        ads.show( "banner", { x=0, y=display.contentHeight - 60, appId="ca-app-pub-2883837174861368/1489836731" } )
    end
    
    function goHome()
        local channel = SoundManager.play("sound/selection.wav");
        storyboard.gotoScene( "menu", "fade", 500 )
    end
    
    function restart()
	local channel = SoundManager.play("sound/selection.wav");
	local custom =
        {
            mode = _gameMode
        }
        storyboard.gotoScene( "gameScreen",{ effect = "fade", time =  500 ,params = custom} )
    end
    
    homeBtn:addEventListener("tap",goHome)
    Runtime:addEventListener( "key", onKeyEvent )
    restartBtn:addEventListener("tap",restart)
end


function scene:exitScene(event)
    transition.to(childGroup,{time = 700,alpha = 0})
    
    homeBtn:removeEventListener("tap",goHome)
    Runtime:removeEventListener( "key", onKeyEvent )
    restartBtn:removeEventListener("tap",restart)
    GameOverAnim.stop()
    
end

function scene:destroyScene(event)
    
    homeBtn:removeSelf()
    restartBtn:removeSelf()
    homeBtn = nil 
    restartBtn = nil
    
    print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene