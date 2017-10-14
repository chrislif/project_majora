-----------------------------------------------------------------------------------------
--
-- untscr.lua
-- collection of all object based scripts
-----------------------------------------------------------------------------------------
-- Requires
local sprites = require "scripts.sprite"
local ui = require "scenes.ui"

local uscript = {}

-- Table to get all sprites
local spriteTable = sprites.loadSprites()

-- Table for cost of buildings
local costTable = {}
costTable["castle"] = 0
costTable["barracks"] = 200

-- Table for building collision stats
local buildingTable = {}
buildingTable["barracks"] = {}
buildingTable["barracks"]["width"] = 100
buildingTable["barracks"]["height"] = 100

buildingTable["castle"] = {}
buildingTable["castle"]["width"] = 100
buildingTable["castle"]["height"] = 100

function uscript.checkBuildCollision(x, y, building)	-- Checks collision before placing building
	local flag = false

	if building == "castle" then return true end
	if building ~= nil then
		local buildXMin = x - buildingTable[building]["width"]/2
		local buildXMax = x + buildingTable[building]["width"]/2
		local buildYMin = y - buildingTable[building]["height"]/2
		local buildYMax = y + buildingTable[building]["height"]/2
		
		for i, obj in pairs(objectTable) do
			if obj ~= nil and obj.name ~= "background" and obj.name ~= "buildmenu" then
				
				local xMin = obj.x - obj.contentWidth/2
				local xMax = obj.x + obj.contentWidth/2
				local yMin = obj.y - obj.contentHeight/2
				local yMax = obj.y + obj.contentHeight/2
				-- print(obj.name)
				-- print("buildXMin: " .. buildXMin .. ", buildXMax: " .. buildXMax)
				-- print("buildYMin: " .. buildYMin .. ", buildYMax: " .. buildYMax)
				-- print("xMin: " .. xMin .. ", xMax: " .. xMax)
				-- print("yMin: " .. yMin .. ", yMax: " .. yMax)
				
				local xMinCheck = buildXMin < xMin or buildXMin > xMax
				local xMaxCheck = buildXMax < xMin or buildXMax > xMax
				local yMinCheck = buildYMin < yMin or buildYMin > yMax
				local yMaxCheck = buildYMax < yMin or buildYMax > yMax
				-- print("xMinCheck: " .. tostring(xMinCheck) .. ", xMaxCheck: " .. tostring(xMaxCheck))
				-- print("yMinCheck: " .. tostring(yMinCheck) .. ", yMaxCheck: " .. tostring(yMaxCheck))
				
				if not((xMinCheck and xMaxCheck) or (yMinCheck and yMaxCheck)) then
					 return false
				end
			end
		end
		return true
	end
end

function uscript.onMap(x, y, building)	-- Checks if building is on the map
	local xMin = x > background.x - background.contentWidth/2
	local xMax = x < background.x + background.contentWidth/2
	local yMin = y > background.y - background.contentHeight/2
	local yMax = y < background.y + background.contentHeight/2
	local xCheck = xMin and xMax
	local yCheck = yMin and yMax
	
	if xCheck and yCheck then
		return true
	end
	return false
end

function uscript.spawnBuilding(x, y, building, dgroup, scale)	-- Spawn Building
	if uscript.onMap(x, y, building) == false then
		print(building.." must be built on the map")
		return nil
	end
	if uscript.checkBuildCollision(x, y, building) == false then
		print(building.." can't be placed on another building")
		return nil
	end
	if costTable[building] > gold then 
		print("not enought gold to build "..building)
		return nil
	end
	local newBuild = display.newSprite(dgroup, spriteTable[building], spriteTable[building.."Data"])
	newBuild.xScale = scale
	newBuild.yScale = scale
	newBuild.x = x
	newBuild.y = y
	newBuild.name = building
	newBuild.selected = false
	gold = gold - costTable[building]
	return newBuild
end

function uscript.spawnUnit(x, y, unit, dgroup)	-- Spawn Unit
	local newUnit = display.newImageRect(dgroup, "assets/" .. unit .. ".png", 32, 32)
	newUnit.x = x
	newUnit.y = y
end

function uscript.selectFunctions(obj)	-- Checks and runs function on selection
	obj:setSequence("selected")
	obj.selected = true
	if obj.name == "castle" then
		
	elseif obj.name == "buildmenu" then
		return ui.showBuildMenu()
	elseif obj.name == "buildbarracks" then
		return "barracks"
	end
end

function uscript.deselectFunctions(obj, menuTable)	-- Runs functions on deselect
	obj:setSequence("normal")
	obj.selected = false
	if obj.name == "buildmenu" then
		ui.hideBuildMenu(menuTable)
	end
	return nil
end

function uscript.dragNdropMenu(event)	-- Drag and drop build menu functionality
	local menuTarget = event.target
	local phase = event.phase
	
	if phase == "began" then
		display.currentStage:setFocus(menuTarget)
		menuTarget.touchOffsetX = event.x - menuTarget.x
		menuTarget.touchOffsetY = event.y - menuTarget.y
		
	elseif phase == "moved" then
		menuTarget.xScale = .5
		menuTarget.yScale = .5
		menuTarget.x = event.x - menuTarget.touchOffsetX
		menuTarget.y = event.y - menuTarget.touchOffsetY
	
	elseif phase == "ended" then
		local newBuild = uscript.spawnBuilding(menuTarget.x, menuTarget.y, menuTarget.building, buildGroup, 0.5)
		table.insert(objectTable, newBuild)
		ui.hideBuildMenu(globalMenuTable)
		globalMenuTable = ui.showBuildMenu()
		uscript.setEventListeners(globalMenuTable)
		display.currentStage:setFocus(nil)
	end
	
	return true
end

function uscript.setEventListeners(globalMenuTable)	-- Sets event listeners for drag and drop menu
	for i, menuObj in pairs(globalMenuTable) do
		if menuObj ~= nil and menuObj.name ~= "buildshelf" then
			menuObj:addEventListener("touch", uscript.dragNdropMenu)
		end
	end
end

return uscript
