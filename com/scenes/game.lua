-----------------------------------------------------------------------------------------
--
-- game.lua
-- main game 
-----------------------------------------------------------------------------------------
-- Requires
local bscript = require "scripts.bscr"
local uscript = require "scripts.untscr"
local ui = require "scenes.ui"
local fogscript = require "scripts.fow"
local composer = require "composer"

-- Initialize Scene
gold = 1000
objectTable = {}
globalMenuTable = {}
local fogTable = {}
local scene = composer.newScene()
local gameLoopTimer
local goldui
local dayCount = 1
local hourCount = 0
local minCount = 0

-- Create Display Groups
backGroup  = display.newGroup()
unitGroup  = display.newGroup()
buildGroup = display.newGroup()
fogGroup = display.newGroup()
menuGroup = display.newGroup()

-- Load Background
local function loadBackground()
	background = display.newImageRect(backGroup, "assets/background.png", 800, 1400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background.name = "background"
	background.type = "background"
	table.insert(objectTable, background)
end

local function dayTick()	-- Event on the day change
	if gold < 9999 then
		gold = gold + 100
	end
end

local function setTouchOffsets(event)	-- Set offsets for screen movement
	for i, obj in pairs(objectTable) do	-- Loop through object table
		if obj.name ~= "buildmenu" and obj ~= nil then
			obj.touchOffsetX = event.x - obj.x
			obj.touchOffsetY = event.y - obj.y
		end
	end
end

local function updatePositions(event, xMov, yMov)	-- Update position of objects
	for i, obj in pairs(objectTable) do
		if obj.name ~= "buildmenu" and obj ~= nil then
			local xMov = event.x - obj.touchOffsetX
			local yMov = event.y - obj.touchOffsetY
			obj.x = xMov
			obj.y = yMov
		end
	end
end

local function deselectObjects(event)	-- Loop through all objects to deselect
	for i, obj in pairs(objectTable) do
		if obj ~= nil and obj.name ~= "background" then
			if obj.name == "buildmenu" then
				globalMenuTable = uscript.deselectFunctions(obj, globalMenuTable)
			elseif obj.selected == true then
				uscript.deselectFunctions(obj, globalMenuTable)
			end
		end
	end
end

local function selectObject(event)	-- Function to select objects
	for i, obj in pairs(objectTable) do	-- Check if object is tapped on
		if obj ~= nil and obj.name ~= "background" then
			local xMin = obj.x - obj.contentWidth/2
			local xMax = obj.x + obj.contentWidth/2
			local yMin = obj.y - obj.contentHeight/2
			local yMax = obj.y + obj.contentHeight/2
			
			local xCheck = event.x > xMin and event.x < xMax
			local yCheck = event.y > yMin and event.y < yMax
			-- print("object: " .. obj.name)
			-- print("xMin: " .. xMin .. ", xMax: " .. xMax)
			-- print("yMin: " .. yMin .. ", yMax: " .. yMax)
			-- print("eventx: " .. event.x .. ", eventy: " .. event.y)
			
			if xCheck and yCheck then
				if obj.name == "buildmenu" then
					if obj.selected == false then
						uscript.deselectFunctions(obj, globalMenuTable)
						deselectObjects(event)
						globalMenuTable = uscript.selectFunctions(obj)
						uscript.setEventListeners(globalMenuTable)
					else
						globalMenuTable = uscript.deselectFunctions(obj, globalMenuTable)
					end
					return true
				end
				if obj.selected == false then
					deselectObjects(event)
					globalMenuTable = uscript.selectFunctions(obj)
					for i, menu in pairs(globalMenuTable) do
						objectTable["recruitMenu"] = menu
					end
					uscript.setEventListeners(globalMenuTable)
					return true
				end
			else
				if obj.name == "buildmenu" then
					globalMenuTable = uscript.deselectFunctions(obj, globalMenuTable)
				elseif obj.selected == true then
					uscript.deselectFunctions(obj, globalMenuTable)
				end
			end
		end 
	end
	return false
end

Runtime:addEventListener("tap", selectObject)

local function dragBackground(event)	-- Move background on drag
	local background = event.target
	local phase = event.phase
	
	if "began" == phase then
		display.currentStage:setFocus(background)
		setTouchOffsets(event)
		
	elseif "moved" == phase then
		local xMovcheck = event.x - background.touchOffsetX
		local yMovcheck = event.y - background.touchOffsetY
		updatePositions(event)		
		
	elseif "ended" == phase then
		display.currentStage:setFocus(nil)
	end
	
	return true
end

function scene:create(event)	-- Runs on scene creation but before on screen
	-- Load UI
	local uiTable = ui.loadUI()
	table.insert(objectTable, uiTable["buildmenu"])
	goldui = uiTable["goldui"]
	-- Load Background
	loadBackground()
	background:addEventListener("touch", dragBackground)
	-- Load Castle
	local castle = uscript.spawnBuilding(display.contentCenterX, display.contentCenterY, 
										 "castle", buildGroup, 0.5)
	table.insert(objectTable, castle)
end

local function gameLoop()	-- Main Game Loop
	minCount = minCount + 1
	if minCount >= 60 then
		minCount = 0
		hourCount = hourCount + 1
	end
	if hourCount >= 24 then
		hourCount = 0
		dayCount = dayCount + 1
		dayTick()
	end
	-- print("day: " .. dayCount .. " hour: " .. hourCount .. " min: " .. minCount)
	ui.updateUI(goldui)
end

function scene:show(event)	-- Runs when scene is on screen
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
	elseif phase == "did" then
		gameLoopTimer = timer.performWithDelay(1, gameLoop, -1)
	end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)

return scene