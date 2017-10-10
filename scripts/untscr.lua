-----------------------------------------------------------------------------------------
--
-- untscr.lua
-- collection of all unit based scripts
-----------------------------------------------------------------------------------------
local uscript = {}

function uscript.spawnBuilding(x, y, building, dgroup)
	
	if building == "red" then
		local newBuild = display.newImageRect(dgroup, "assets/Red.png", 100, 100)
		newBuild.x = x
		newBuild.y = y
		return newBuild
	end
end

function uscript.spawnUnit(x, y, unit, dgroup)

	if unit == "blue" then
		local newUnit = display.newImageRect(dgroup, "assets/blue.png", 32, 32)
		newUnit.x = x
		newUnit.y = y
	end
end

return uscript
