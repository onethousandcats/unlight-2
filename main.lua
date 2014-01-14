-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

local storyboard = require "storyboard"

local w = display.viewableContentWidth
local h = display.viewableContentHeight

local dw = display.pixelWidth
local dh = display.pixelHeight

currentInfo = system.pathForFile( "current.txt" )

local cur = io.open( currentInfo, "r" )

local info = {}

for line in cur:lines() do 
	info[ #info + 1 ] = line
end

io.close(cur)

local savedLvl = tonumber(info[1])
lvl = 1
local tutLvl = 1
local theme = info[2]

local g = graphics.newGradient(
	{ 133, 215, 199 },
	{ 77, 144, 208 },
	"down"
)

if ( theme == "dark" ) then
	g = graphics.newGradient(
		{ 142, 23, 0 },
		{ 255, 166, 50 },
		"up"
	)
end

background = display.newRect(0, 0, dw, dh)
background:setFillColor(g)
background.x = dw/2; background.y = dh/2
background.width = dw; background.height = dh;

local frame = {
	container = display.newRect( 0, 0, w, h ),
	reflectX = true,
}

local alphaDec = .01
local numParticles = 40
local particleFile = "particle.png"

local display_stage = display.getCurrentStage()
display_stage:insert( background )
display_stage:insert( storyboard.stage )

--add particles
for i=1, numParticles do
	
	local particle = display.newImage( particleFile )
	
	particle.x = math.random( 1, w )
	particle.y = h + math.random( 5, 400 )
	
	particle.vx = math.random( -3, 3 )
	particle.vy = math.random( -10, -1 )
	
	frame[ #frame + 1 ] = particle

	display_stage:insert( particle )

end

function frame:enterFrame( event )
	
	for _,p in ipairs( frame ) do
		
		local newAlpha = p.alpha - alphaDec
		
		p:translate( p.vx, p.vy )
		
		if (p.alpha > 0 and p.y < h ) then
			p.alpha = newAlpha
		end
		
		if (p.y < 0) then
			p.y = h + 50
			p.x = math.random( 1, w )
			p.vx = math.random( -3, 3 )
			p.vy = math.random( -10, -1 )
			p.alpha = 1
		end
		
	end

end

Runtime:addEventListener( "enterFrame", frame )

-- load splash
storyboard.gotoScene( "splash" )


