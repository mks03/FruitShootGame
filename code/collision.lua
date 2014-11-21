

local tempDoubleScoreText

Collision = {
    
    fruitPreCollision = function(event)
        --print(event,event.contact)
        if event.contact ~= nil then
            event.contact.isEnabled = false
        end
        
    end,
    
    
    arrowPreCollision = function(event)
        
        local target = event.other
        local shooter = event.target
        shooter.anchorX = 0.8
        target.isSensor = true
        
        --print(target.myName)
        --event.contact.isEnabled = false
        Collision.check(shooter,target)
	
    end,
    
    knifePreCollision = function(event)
        
        local target = event.other
        local shooter = event.target
        --shooter.anchorX = 1
        --target.isSensor = true
        --print(target.myName)
        if event.contact ~= nil and target.myName == "arrow" then
            event.contact.isEnabled = false
        else
            target.isSensor = true
            Collision.check(shooter,target)			
        end
        --event.contact.isEnabled = false
	
    end,
    
    tipPreCollision = function(event)
        event.contact.isEnabled = false
        
	
    end,
    
    check = function(shooter,target)
	
	
        if target.name ~= nil then
            local function removePhysics(event)
                if target ~= nil then
                    physics.removeBody( target )
                end
            end
            timer.performWithDelay(1,removePhysics)
            transition.cancel(target)
            shooter.fruitsHit = shooter.fruitsHit + 1 
            
            if shooter.fruitsHit == 2 and shooter.level == "arcade" then
                --_arrowCount = _arrowCount + 1
                local  scoreAnim = display.newImage("images/arrow.png",target.x,target.y)
                Animations.arrowUp.start(scoreAnim,_arrowText.x,_arrowText.y)
            end
            
            
            
            
            if target.type == "fruits" then
                local channel = SoundManager.play("sound/fruit_pop.mp3");
                
                local localScore = nil
                if _isDoubleScore then
                    localScore = shooter.fruitsHit * (target.score)
                    _tempDoubleScore = _tempDoubleScore + localScore
                    --local  scoreAnim = display.newImage("images/1.png",target.x,target.y)
                    tempDoubleScoreText.text = _tempDoubleScore
                    --Animations.DoubleUp.start(scoreAnim,_tempDoubleScore,tempDoubleScoreText,200,150)
                else
                    if shooter.fruitsHit < 5 then
                        localScore = math.pow(2,shooter.fruitsHit - 1) * target.score 
                    else
                        localScore = math.pow(2,4) * target.score
                    end
                    _gameScore = _gameScore + localScore
                    local  scoreAnim = display.newImage(group,"images/scores/" .. localScore .. ".png",target.x,target.y)
                    Animations.oneUp.start(scoreAnim,_scoreText.x,_scoreText.y)
                end
                
                target:toFront()
                local tm = timer.performWithDelay( 10, TimerFunctions.updateArrowPath,0 )
                tm.params = { myParam1 = target , myParam2 = shooter, myParam3 = shooter.rotation}
            else
                local power = target.name
                print(power)
                if power == "freeze" then
                    _isFreeze = true
                    _isFreezeStart = true
                elseif power == "zoom" then
                    _isZoom = true
                    _isZoomStart = true
                elseif power == "accelerate"	then
                    _isAccelerate = true
                    _isAccelerateStart = true
                elseif power == "doubleScore" then
                    _isDoubleScore = true
                    _isDoubleScoreStart = true
                    tempDoubleScoreText = DoubleScore.start(_powerGroup,_allEmitters)
                    print(tempDoubleScore,tempDoubleScoreText)
                elseif power == "arrowSplit" then
                    _isArrowSplit = true
                    _isArrowSplitStart = true
                elseif power == "knifeCut" then
                    KnifeCut.start(_powerGroup,_allEmitters)
                elseif power == "arrowBonus" then
                    ArrowBonus.start(target.x,target.y)
                elseif power == "timeBonus" then
                    TimeBonus.start(target.x,target.y)
                    
                end
                
                target:removeSelf()
                target = nil
                print(_currentPower)
                if _isArrowSplit then
                    if _isArrowSplitStart then
                        ArrowSplit.start(_powerGroup,_allEmitters)
                        _isArrowSplitStart = false
                    end
                end
            end
        else 
            --print("Aroow problem")
        end
	
	
    end
    
    
    
}