-----------------------------------------------------------------------------------------
--
-- untscr.lua
-- collection of all unit based scripts
-----------------------------------------------------------------------------------------
local uscript = {}

function uscript.spawnBuilding(x, y, building, dgroup, objectTable)	-- Spawn Building
	local newBuild = display.newImageRect(dgroup, "assets/".. building ..".png", 100, 100)
	newBuild.x = x
	newBuild.y = y
	newBuild.name = building
	newBuild.selected = false
	return newBuild
end

function uscript.spawnUnit(x, y, unit, dgroup)	-- Spawn Unit
	local newUnit = display.newImageRect(dgroup, "assets/" .. unit .. ".png", 32, 32)
	newUnit.x = x
	newUnit.y = y
end

return uscript
