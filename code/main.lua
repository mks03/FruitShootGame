require("animations")
require("anim.knifeCut")
require("anim.doubleScore")
require("anim.arrowBonus")
require("anim.timeBonus")
require("anim.snow")
require("anim.zoom")
require("anim.accelerate")
require("soundManager")

ads = require("ads")
storyboard = require "storyboard"
physics = require("physics")
-- physics.setDrawMode( "hybrid" )
physicsArrow = require("physics")
require("ice")

ads.init( "admob", "ca-app-pub-2883837174861368/1489836731")
physics.start()
physicsArrow.start()
--physics.setDrawMode( "hybrid" ) -- overlays collision outlines on normal Corona objects
physics.setGravity( 0, 9 )
physicsArrow.setGravity( 0, 9 )

--Global Variables
_currentPower = ""
_gameScore = 0
_scoreText = nil
_scoreBar = nil
_arrowBar = nil
_tempDoubleScore = 0  -- score for animtio in double score 

score_textSize = 22

_arrowText = nil
_arrowCount = 10
_highScoreBar = nil
_highScoreText = nil
_isFreeze = false
_isZoom = false
_isAccelerate = false
_isDoubleScore = false
_isArrowSplit = false
_isArrowBonus = false
_isTimeBonus = false

_isFreezeStart = false
_isZoomStart = false
_isAccelerateStart = false
_isDoubleScoreStart = false
_isArrowSplitStart = false
_powerGroup = display.newGroup()  -- group where all powers with the plank comes
_allEmitters = display.newGroup()  --group for all emitters

_gameMode = "arcade"    --kidMode,timeMode,arcade
_clock = nil  --clock for time mode
_clockId = nil	-- timer id for clock
_fruitId = nil  -- timer id for fruit
_powerId = nil  -- timer id for power


	ScoreBox = ice:loadBox( "ScoreBox" )
	ScoreBox:storeIfNew( "arcade", 0 )
	ScoreBox:storeIfNew( "timeMode", 0 )
	ScoreBox:enableAutomaticSaving()



storyboard.gotoScene( "menu", "fade", 1000 )