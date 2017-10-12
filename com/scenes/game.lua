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
local menuTable = {}
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

local function buildObject(event)	-- Will Build an Object
	if isBuilding == false then return end
	if willBuild ~= nil then
		local newBuild = uscript.spawnBuilding(event.x, event.y, willBuild, buildGroup)
		table.insert(objectTable, newBuild)
		isBuilding = false
		willBuild = nil
	end
end

Runtime:addEventListener("tap", buildObject)

local function checkMenu(event)	-- Will check if the menu is tapped and then react
	local xcheck = false
	local ycheck = false
	if table.maxn(menuTable) > 0 then
		
	end
	local xmin = menu.x - menu.contentWidth/2
	local xmax = menu.x + menu.contentWidth/2
	local ymin = menu.y - menu.contentHeight/2
	local ymax = menu.y + menu.contentHeight/2
	
	xcheck = event.x > xmin and event.x < xmax
	ycheck = event.y > ymin and event.y < ymax
	if xcheck and ycheck then
		willBuild = "red"
		isBuilding = true
	else
		if menu ~= nil then
			menu:removeSelf()
		end
		menu = nil
	end
end

local function showMenu(event, obj)	-- Will show the menu
	menuActive = true
	if table.maxn(menuTable) > 0 then
		for i, obj in pairs(menuTable) do
			menuTable[i] = nil
			obj:removeSelf()
		end
	end
	menuTable["red"] = display.newImageRect(menuGroup, "assets/red.png", 50, 50)
	menuTable["yellow"] = display.newImageRect(menuGroup, "assets/yellow.png", 50, 50)
	
	local count = 0
	for i, obj in pairs(menuTable) do
		obj.x = obj.contentWidth/2
		obj.y = (obj.contentHeight * (2 + count))
		count = count + 1
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
			-- print("xmin: "..xmin..", xmax: "..xmax)
			-- print("ymin: "..ymin..", ymax: "..ymax)
			-- print("event.x: "..event.x..", event.y: "..event.y)
			
			if obj.name == "castle" then
				castleChecked = true
			end
			
			if xcheck and ycheck then
				if obj.selected == false then
					obj.selected = true
					if obj.name == "castle" then
						showMenu(event, obj)
						return
					end
				end
				
			else
				if obj.selected == true then
					obj.selected = false
				end
				if obj.name == "castle" then
					checkMenu(event)
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