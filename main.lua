-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local script = require(".bscr")

-- Initialize Variables
local gameLoopTimer

-- Create Display Groups
local backGroup = display.newGroup()
local unitGroup = display.newGroup()
local buildGroup = display.newGroup()

-- Load Background
local background = display.newImageRect(backGroup, "assets/background.png", 800, 1400)
background.x = display.contentCenterX
background.y = display.contentCenterY

local function updatePositions()	-- Update position of objects
	-- STUB
end

local function updateDisplay()	--	Update display with new positions
	-- STUB
end

local function dragBackground(event)	-- Move background on drag
	local background = event.target
	local phase = event.phase
	
	if ("began" == phase) then
		display.currentStage:setFocus(background)
		background.touchOffsetX = event.x - background.x
		background.touchOffsetY = event.y - background.y
		
	elseif ("moved" == phase) then	
		background.x = event.x - background.touchOffsetX
		background.y = event.y - background.touchOffsetY
		
	elseif ("ended" == phase) then
		display.currentStage:setFocus(nil)
	end
	
	return true
end

background:addEventListener("touch", dragBackground)

local function gameLoop()	-- Main Game Loop

end

gameLoopTimer = timer.performWithDelay(5, gameLoop, -1)