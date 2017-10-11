-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local bscript = require("bscr")
local uscript = require("untscr")

-- Initialize Variables
local gameLoopTimer

-- Create Display Groups
local objectTable = {}
local backGroup  = display.newGroup()
local unitGroup  = display.newGroup()
local buildGroup = display.newGroup()

-- Load Background
local background = display.newImageRect(backGroup, "assets/background.png", 800, 1400)
background.x = display.contentCenterX
background.y = display.contentCenterY
table.insert(objectTable, background)

local function setTouchOffsets(event)
	for i, obj in pairs(objectTable) do
		obj.touchOffsetX = event.x - obj.x
		obj.touchOffsetY = event.y - obj.y
	end
end

local function updatePositions(event, xmov, ymov)	-- Update position of objects
	for i, obj in pairs(objectTable) do
		local xmov = event.x - obj.touchOffsetX
		local ymov = event.y - obj.touchOffsetY
		obj.x = xmov
		obj.y = ymov
	end
end

local function updateDisplay()	--	Update display with new positions
	-- STUB
end

-- Temp function to spawn on tap
local function tapBuild(event)
	local newBuild = uscript.spawnBuilding(event.x, event.y, "red", buildGroup)
	table.insert(objectTable, newBuild)
end

background:addEventListener("tap", tapBuild)

local function dragBackground(event)	-- Move background on drag
	local background = event.target
	local phase = event.phase
	
	if "began" == phase then
		display.currentStage:setFocus(background)
		setTouchOffsets(event)
		
	elseif "moved" == phase then
		local xmovcheck = event.x - background.touchOffsetX
		local ymovcheck = event.y - background.touchOffsetY
		updatePositions(event)		
		
	elseif "ended" == phase then
		display.currentStage:setFocus(nil)
	end
	
	return true
end

background:addEventListener("touch", dragBackground)

local function gameLoop()	-- Main Game Loop

end

gameLoopTimer = timer.performWithDelay(5, gameLoop, -1)