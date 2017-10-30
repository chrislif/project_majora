-----------------------------------------------------------------------------------------
--
-- aiscr.lua
-- scripts for unit ai
-----------------------------------------------------------------------------------------
function math:sign(x)
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	else
		return 0
	end
end

local aiscript = {}

function aiscript:getWander(unit)
	local background = objectTable["background"]
	print(objectTable["background"])
	--unit.destX = background.contentCenterX/2 + (background.contentWidth/2 * math.random(-1, 1))
	--unit.destY = background.contentCenterY/2 + (background.contentHeight/2 * math.random(-1, 1))
end

function aiscript:getState(unit)
	unit.state = "wander"
	aiscript:getWander(unit)
end

function aiscript:doState(unit)
	if unit.state == "wander" and unit ~= nil then
		if unit.destX ~= unit.x then
			unit.x = unit.x + math.sign(unit.destX - unit.x)
		end
		if unit.destY ~= unit.y then
			unit.y = unit.y + math.sign(unit.destY - unit.y)
		end
		if unit.destX == unit.x and unit.destY == unit.y then
			unit.state = "idle"
		end
	end
end

function aiscript:checkUnits()
	for i, unit in pairs(unitTable) do
		if unit.state ~= "idle" then
			aiscript:doState(unit)
		else
			aiscript:getState(unit)
		end
	end
end

return aiscript