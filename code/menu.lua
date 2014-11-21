local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true

local bgImage
local bgMode

local leaderBoard
local bgGroup
local adBalloon
local adDress
local bgLogo
local rateApp
local ad2048
local adNum
local adSpace
local adSpell
local adArr = {}


function scene:createScene(event)
    
    bgGroup = self.view
    bgImage = display.newImage(bgGroup,"images/background_menu.jpg",display.contentCenterX,display.contentCenterY)
    
    
    bgMode = display.newImage(bgGroup,"images/mode.png",display.contentCenterX,display.contentCenterY + 90)
    
	--[[
	adNum = math.random(1,5)
	adBalloon = display.newImage(bgGroup,"images/ad_balloon.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	adBalloon.isVisible = false
	adDress = display.newImage(bgGroup,"images/ad_dress.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	adDress.isVisible = false
	ad2048 = display.newImage(bgGroup,"images/ad_2048.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	ad2048.isVisible = false
	adSpell = display.newImage(bgGroup,"images/ad_spell.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	adSpell.isVisible = false
	adSpace = display.newImage(bgGroup,"images/ad_space.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	adSpace.isVisible = false
	
	adArr = {adBalloon,adDress,ad2048,adSpell,adSpace}
	
	adArr[adNum].isVisible = true
    ]]--
    
end

function scene:enterScene(event)
    
    local channel = SoundManager.play("sound/menu.mp3",{channel=1, loops=-1});
    
    local function goMode(event)
        local target = event.target
        local bounds = target.contentBounds
        
        if event.phase == "began" then
            target:scale(1.25,1.25)
            display.getCurrentStage():setFocus( target )
            self.isFocus = true
        elseif self.isFocus then
            
            if event.phase == "moved" then
            elseif event.phase == "ended" or event.phase == "cancelled" then
                if(event.x > bounds.xMin  and event.x < bounds.xMax) then
                    if  (event.y > bounds.yMin  and event.y < bounds.yMax) then
                        
                        SoundManager.play("sound/selection.wav")
                        storyboard.gotoScene( "modeScreen", {effect="fade", time=700,params={param1 = channel} })
                    end
                end
                target:scale(0.8,0.8)
                display.getCurrentStage():setFocus( nil )
                target.isFocus = false
            end
        end
        
    	return true
    end
    
    
    
    
    local function goBalloon(event)
        if event.phase == "began" then
            system.openURL("amzn://apps/android?p=com.cappoapps.balloonpop" )
        end
    end
    local function goDress(event)
        if event.phase == "began" then
            system.openURL("amzn://apps/android?p=com.cappoapps.dressup" )
        end	
    end
    local function goSpell(event)
        if event.phase == "began" then
            system.openURL("amzn://apps/android?p=com.cappoapps.spell_the_word" )
        end	
    end
    local function goSpace(event)
        if event.phase == "began" then
            system.openURL("amzn://apps/android?p=com.cappoapps.spacejam" )
        end	
    end
    local function go2048(event)
        if event.phase == "began" then
            system.openURL("amzn://apps/android?p=com.cappoapps.pro2048" )
        end	
    end
    
    
    bgMode:addEventListener("touch",goMode)
    
	--[[
	adDress:addEventListener("touch", goDress)
	adBalloon:addEventListener("touch", goBalloon)
	ad2048:addEventListener("touch", go2048)
	adSpell:addEventListener("touch", goSpell)
	adSpace:addEventListener("touch", goSpace)
    ]]--
end


function scene:exitScene(event)
    
    
end

function scene:destroyScene(event)
    print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene