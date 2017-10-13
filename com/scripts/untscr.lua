-----------------------------------------------------------------------------------------
--
-- untscr.lua
-- collection of all object based scripts
-----------------------------------------------------------------------------------------
local sprites = require "scripts.sprite"
local ui = require "scenes.ui"

local uscript = {}
local spriteTable = sprites.loadSprites()

local costTable = {}
costTable["castle"] = 0
costTable["barracks"] = 200

function uscript.onMap(x, y)
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
	if uscript.onMap(x, y) == false then
		print(building.." must be built on the map")
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

return uscript
