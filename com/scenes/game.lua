-----------------------------------------------------------------------------------------
--
-- game.lua
-- main game 
-----------------------------------------------------------------------------------------
-- Requires
local bscript = require "scripts.bscr"
local uscript = require "scripts.untscr" 
local composer = require "composer"

-- Initialize Scene
local scene = composer.newScene()
local gameLoopTimer
local isBuilding = false
local willBuild = nil
local menu = nil

-- Create Display Groups
local objectTable = {}
local backGroup  = display.newGroup()
local unitGroup  = display.newGroup()
local buildGroup = display.newGroup()
local menuGroup = display.newGroup()

-- Load Background
local background = display.newImageRect(backGroup, "assets/background.png", 800, 1400)
background.x = display.contentCenterX
background.y = display.contentCenterY
background.name = "background"
table.insert(objectTable, background)


local function setTouchOffsets(event)	-- Set offsets for screen movement
	for i, obj in pairs(objectTable) do	-- Loop through object table
		if obj ~= nil then
		obj.touchOffsetX = event.x - obj.x
		obj.touchOffsetY = event.y - obj.y
		end
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

local function selectObject(event)	-- Function to select objects
	if isBuilding == true then return end
	
	local castleChecked = false
	
	for i, obj in pairs(objectTable) do	-- Check if object is tapped on
		if obj ~= nil and obj.name ~= "background" then
			local xmin = obj.x - obj.contentWidth/2
			local xmax = obj.x + obj.contentWidth/2
			local ymin = obj.y - obj.contentHeight/2
			local ymax = obj.y + obj.contentHeight/2
			
			local xcheck = event.x > xmin and event.x < xmax
			local ycheck = event.y > ymin and event.y < ymax
			
			
			if xcheck and ycheck then
				
				
			else
				
			end
		end 
	end
	
end

Runtime:addEventListener("tap", selectObject)

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

function scene:create(event)	-- Runs on scene creation but before on screen
	local castle = uscript.spawnBuilding(display.contentCenterX, display.contentCenterY, "castle", buildGroup, objectTable)
	table.insert(objectTable, castle)
end

function scene:show(event)	-- Runs when scene is on screen
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
	elseif phase == "did" then
		gameLoopTimer = timer.performWithDelay(5, gameLoop, -1)
	end
end

function scene:hide(event)	-- Runs when scene will be hidden

end

function scene:destroy(event)	-- Runs when scene is destroyed

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene