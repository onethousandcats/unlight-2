----------------------------------------------------------------------------------
--
-- settings.lua
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

function scene:createScene( event )
	local group = self.view

	local head = display.newImage("block.png")		
	group:insert( head , true )
	head.x = w / 2; head.y = 120; head.alpha = 0;
	head:setFillColor( 254, 254, 254 )

	local theme = display.newText("theme", w / 2, 230, "Infinity", 36)
	group:insert( theme , true )
	theme.x = w / 2; theme.y = 210; theme.alpha = 0;
	theme:setTextColor( 254, 254, 254 )
		
	local sounds = display.newText("sounds", w / 2, 230, "Infinity", 36)
	group:insert( sounds , true )
	sounds.x = w / 2; sounds.y = theme.y + 50; sounds.alpha = 0;
	sounds:setTextColor( 254, 254, 254 )

	local ret = display.newText("return", w / 2, 300, "Infinity", 36)
	group:insert( ret , true )
	ret.x = w / 2; ret.y = sounds.y + 50; ret.alpha = 0;
	ret:setTextColor( 254, 254, 254 )

	items[ #items + 1 ] = head
	items[ #items + 1 ] = theme
	items[ #items + 1 ] = sounds
	items[ #items + 1 ] = ret

end

local function rotateConst ( )
	items[1].rotation = items[1].rotation + 3
end

local function changeTheme ( event )
	if ( event.phase == "began" ) then

		if (theme == "light") then
			theme = "dark"

			g = graphics.newGradient(
				{ 142, 23, 0 },
				{ 255, 166, 50 },
				"up"
			)

			background:setFillColor(g)

		else
			theme = "light"

			g = graphics.newGradient(
				{ 133, 215, 199 },
				{ 77, 144, 208 },
				"down"
			)

			background:setFillColor(g)
		end

		background:setFillColor(g)

		--record theme in log
		local f = io.open( currentInfo, "w" )
		f:write( lvl, "\n" )
		f:write( theme )

		io.close( f )
		f = nil

	end
end

function scene:enterScene( event )
	local group = self.view
	
	for i,v in ipairs(items) do
		transition.to( items[i], { time = 600, delay = 600, alpha = 1 } )
	end

	Runtime:addEventListener( "enterFrame", rotateConst )

	items[2]:addEventListener("touch", changeTheme )

end


function scene:exitScene( event )
	local group = self.view
	

end


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