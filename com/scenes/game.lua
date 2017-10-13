-----------------------------------------------------------------------------------------
--
-- game.lua
-- main game 
-----------------------------------------------------------------------------------------
-- Requires
local bscript = require "scripts.bscr"
local uscript = require "scripts.untscr"
local ui = require "scenes.ui"
local composer = require "composer"

-- Initialize Scene
gold = 0
local scene = composer.newScene()
local gameLoopTimer
local objectTable = {}
local menuTable = {}
local goldui

-- Create Display Groups
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
		if obj.name ~= "buildmenu" and obj ~= nil then
			obj.touchOffsetX = event.x - obj.x
			obj.touchOffsetY = event.y - obj.y
		end
	end
end

local function updatePositions(event, xmov, ymov)	-- Update position of objects
	for i, obj in pairs(objectTable) do
		if obj.name ~= "buildmenu" and obj ~= nil then
			local xmov = event.x - obj.touchOffsetX
			local ymov = event.y - obj.touchOffsetY
			obj.x = xmov
			obj.y = ymov
		end
	end
end

local function deselectMenu()
	for i, menuobj in pairs(menuTable) do
		if menuobj.name ~= "buildshelf" then
			uscript.deselectFunctions(menuobj, menuTable)
		end
	end
end

local function selectMenu(event)
	if menuTable ~= nil then
		for i, menuobj in pairs(menuTable) do
			local xmin = menuobj.x - menuobj.contentWidth/2
			local xmax = menuobj.x + menuobj.contentWidth/2
			local ymin = menuobj.y - menuobj.contentHeight/2
			local ymax = menuobj.y + menuobj.contentHeight/2
			
			local xcheck = event.x > xmin and event.x < xmax
			local ycheck = event.y > ymin and event.y < ymax
			
			if xcheck and ycheck then
				if menuobj.name ~= "buildshelf" then
					uscript.selectFunctions(menuobj)
					return true
				else
					deselectMenu()
					return true
				end
			end
		end
	end
	return false
end

local function selectObject(event)	-- Function to select objects
	for i, obj in pairs(objectTable) do	-- Check if object is tapped on
		if obj ~= nil and obj.name ~= "background" then
			local xmin = obj.x - obj.contentWidth/2
			local xmax = obj.x + obj.contentWidth/2
			local ymin = obj.y - obj.contentHeight/2
			local ymax = obj.y + obj.contentHeight/2
			
			local xcheck = event.x > xmin and event.x < xmax
			local ycheck = event.y > ymin and event.y < ymax
			-- print("object: " .. obj.name)
			-- print("xmin: " .. xmin .. ", xmax: " .. xmax)
			-- print("ymin: " .. ymin .. ", ymax: " .. ymax)
			-- print("eventx: " .. event.x .. ", eventy: " .. event.y)
			
			
			if xcheck and ycheck then
				if obj.name == "buildmenu" then
					if obj.selected == false then
						menuTable = uscript.selectFunctions(obj)
					else
						menuTable = uscript.deselectFunctions(obj, menuTable)
					end
					return
				end
				if obj.selected == false then
					menuTable = uscript.selectFunctions(obj)
					return
				end
			else
				if obj.name == "buildmenu" then
					if selectMenu(event) == false then
						menuTable = uscript.deselectFunctions(obj, menuTable)
					end
				elseif obj.selected == true then
					menuTable = uscript.deselectFunctions(obj, menuTable)
				end
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

function scene:create(event)	-- Runs on scene creation but before on screen
	local castle = uscript.spawnBuilding(display.contentCenterX, display.contentCenterY, 
										 "castle", buildGroup, 0.5)
	table.insert(objectTable, castle)
	local uiTable = ui.loadUI()
	table.insert(objectTable, uiTable["buildmenu"])
	goldui = uiTable["goldui"]
end

local function gameLoop()	-- Main Game Loop
	ui.updateUI(goldui)
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