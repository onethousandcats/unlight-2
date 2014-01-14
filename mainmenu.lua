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

function goToSettings ( event )
	if ( event.phase == "began" ) then
		print("going to settings")
		
		local i = #items

		for i,v in ipairs(items) do

			if ( i > 1 ) then
				transition.to( items[i], { time = 4000, delay = 1000, alpha = 0 })
			else 
				transition.to( items[i], { time = 4000, delay = 1000, alpha = 0, onComplete = storyboard:gotoScene("settings") } )
			end

			i = i - 1

		end

	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	local head = display.newImage("block.png")		
	group:insert( head , true )
	head.x = w / 2; head.y = 120; head.alpha = 0;
	head:setFillColor( 254, 254, 254 )

	local cont = display.newText("continue", w / 2, 230, "Infinity", 36)
	group:insert( cont , true )
	cont.x = w / 2; cont.y = 210; cont.alpha = 0;
	cont:setTextColor( 254, 254, 254 )
		
	local new = display.newText("new game", w / 2, 230, "Infinity", 36)
	group:insert( new , true )
	new.x = w / 2; new.y = cont.y + 50; new.alpha = 0;
	new:setTextColor( 254, 254, 254 )

	local tut = display.newText("tutorial", w / 2, 300, "Infinity", 36)
	group:insert( tut , true )
	tut.x = w / 2; tut.y = new.y + 50; tut.alpha = 0;
	tut:setTextColor( 254, 254, 254 )

	local settings = display.newText("settings", w / 2, 300, "Infinity", 36)		
	group:insert( settings , true )
	settings.x = w / 2; settings.y = tut.y + 50; settings.alpha = 0;
	settings:setTextColor( 254, 254, 254 )

	items[ #items + 1 ] = head
	items[ #items + 1 ] = new
	items[ #items + 1 ] = tut
	items[ #items + 1 ] = settings

	items[ #items + 1 ] = cont

end

local function rotateConst ( )
	items[1].rotation = items[1].rotation + 3
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	for i,v in ipairs(items) do
		transition.to( items[i], { time = 600, delay = 600, alpha = 1 } )
	end

	Runtime:addEventListener( "enterFrame", rotateConst )

	--add button listeners

	items[4]:addEventListener( "touch", goToSettings )
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
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
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene