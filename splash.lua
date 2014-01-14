----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local w = display.viewableContentWidth
local h = display.viewableContentHeight

local white = { 255, 255, 255 }
local black = { 0, 0, 0 }

local texts = {}

-- Call the main scene
local function callMainScene( event )
	print("end scene")
	storyboard.gotoScene( "landing" )
end

local function transitionCompleted( event )
	transition.to( texts[1], { time = 1000, delay = 1000, alpha = 0 } )
	transition.to( texts[2], { time = 1000, delay = 2000, alpha = 1 } )
	transition.to( texts[2], { time = 1000, delay = 3400, alpha = 0 } )

	timer.performWithDelay(4000, callMainScene, 1)
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local lsize = 80
	local fontSize = 36

	print("splash created")

	local t1 = display.newText("polygala", w / 2, h * .45, "Infinity", fontSize)
	t1:setTextColor( 254, 254, 254 )
	t1:setReferencePoint( display.TopCenterReferencePoint )
	t1.x = w / 2
	t1.alpha = 0

	local logoWidth = 100

	local t2 = display.newImageRect("polygala_logo.png", logoWidth, logoWidth )
	t2:setFillColor( 254, 254, 254 )
	t2.x = w / 2; t2.y = h / 2
	t2.alpha = 0

	texts[ #texts + 1 ] = t1
	texts[ #texts + 1 ] = t2	

	for i,v in ipairs(texts) do
		group:insert( texts[ i ] )
	end


end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	transition.to( texts[1], { time = 600, delay = 600, alpha = 1, onComplete = transitionCompleted } )


	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	for i = 1, #texts, 1 do
		transition.to( texts[i], { time = 600, delay = 0, alpha = 0 } )
	end 
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	

	
end


-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene