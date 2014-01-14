----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local w = display.viewableContentWidth
local h = display.viewableContentHeight

local dw = display.pixelWidth
local dh = display.pixelHeight

local white = { 255, 255, 255 }
local black = { 0, 0, 0 }

local items = {}

-- Create blinking function
function blink ( obj )
	if ( obj.alpha == 1 ) then		
		transition.to( obj, { time = 2000, alpha = 0, onComplete = blink })
	else
		transition.to( obj, { time = 2000, alpha = 1, onComplete = blink })
	end
end

function nextScene ( event )
	storyboard:gotoScene("mainmenu")
end

function goToMain ( event )
	if ( event.phase == "began" ) then
		print("going to main menu")
		
		for i,v in ipairs(items) do
			transition.to( items[i], { time = 2000, delay = 1000, alpha = 0 } )
		end

		transition.to( event.target, { time = 2000, rotation = 90, y = -30, onComplete = nextScene } )
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local title = display.newText("unlight", w / 2, w / 2, "Infinity", 72)
	local touch = display.newText("touch to start", w / 2, 300, "Infinity", 24)
	local q = display.newImage("block.png")

	title:setTextColor( 254, 254, 254 )
	touch:setTextColor( 254, 254, 254 )
	q:setFillColor( 254, 254, 254 )

	items[ #items + 1 ] = title
	items[ #items + 1 ] = touch
	items[ #items + 1 ] = q

	for i,v in ipairs(items) do
		group:insert(items[i])
	end
	
	title.x = w / 2; title.y = h * .3; title.alpha = 0;
	touch.x = w / 2; touch.y = h * .6; touch.alpha = 0;
	q.x = w / 2; q.y = h / 2; q.alpha = 0;


end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	for i,v in ipairs(items) do
		transition.to( items[i], { time = 600, delay = 600, alpha = 1 } )
	end

	blink(items[2])

	items[3]:addEventListener( "touch", goToMain )
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print("exiting scene")
	local group = self.view

	for i,v in ipairs(items) do
		transition.to( items[i], { time = 600, delay = 600, alpha = 0 } )
	end	

end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().

---------------------------------------------------------------------------------

return scene