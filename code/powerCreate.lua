require("collision")

function rotatepower(obj)
    obj.rotation = obj.rotation
    transition.to( obj, { rotation = obj.rotation + 360,time = 2000, onComplete=rotatepower } )
end

local powers = {"freeze","zoom","accelerate","doubleScore","arrowSplit","knifeCut","arrowBonus","timeBonus"}
local powersPoitns = {}
PowerCreate = {
    
    new = function(grp,x,y)
        
        if _gameMode == "arcade" then
            powers = {"accelerate","doubleScore","arrowBonus"}
        elseif _gameMode == "timeMode" then
            powers = {"accelerate","doubleScore","timeBonus"}
        end
        local physicsData = (require "shapedefs").physicsData(1.0)
        local powerImg
        local num = math.random(3)
        local powerName = powers[num]
        local powerGap = math.random(7000,25000)
        x,y = math.random(320,700),math.random(400,400)
        powerImg = display.newImage(grp,"powerFruits/" .. powerName .. ".png",x,y)
        powerImg.name = powerName
        powerImg.type = "powers"
        
        physics.addBody( powerImg, "dynamic",physicsData:get("coconut"))
        
        
        --powerImg:applyForce( math.random(-600,600), math.random(-3500,-2500), powerImg.x, powerImg.y )
        powerImg:applyForce( 0, math.random(-4500,-2000), powerImg.x, powerImg.y )
        
        rotatepower(powerImg)
        
        powerImg:addEventListener( "preCollision",Collision.fruitPreCollision )
        
        _powerId = timer.performWithDelay(powerGap,function(event)
            --value = _currentPower
            PowerCreate.new(group,200,400)
            
        end )
        
        return powerImg
    end,
    
}