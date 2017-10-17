-----------------------------------------------------------------------------------------
--
-- fow.lua
-- all fog of war related functions 
-----------------------------------------------------------------------------------------
local fogscript = {}
local fogTable = {}
local id = 0

function fogscript:removeFog(fogU)
	fogTable["x"..fogU.x.."y"..fogU.y] = nil
	objectTable[fogU.name] = nil
	fogU:removeSelf()
end

function fogscript:addFog(fogU, x, y)
	fogU.x = x
	fogU.y = y
	fogU.name = "fog" .. id
	id = id + 1
	fogU.area = fogU.contentWidth * fogU.contentHeight
	fogU.type = "fog"
	fogTable["x"..fogU.x.."y"..fogU.y] = fogU
	objectTable[fogU.name] = fogU
end

function fogscript:loadFog()
	local fog = display.newImageRect(fogGroup, "assets/fogUnit.png", background.contentWidth, background.contentHeight)
	fogscript:addFog(fog, background.x, background.y)
	return fogTable
end

function fogscript:collisionCheck(coor, fogU)
	if fogU ~= nil then
		local fogXMin = fogU.x - fogU.contentWidth/2
		local fogXMax = fogU.x + fogU.contentWidth/2
		local fogYMin = fogU.y - fogU.contentHeight/2
		local fogYMax = fogU.y + fogU.contentHeight/2
		
		local xMinCheck = fogXMin < coor.x and coor.x < fogXMax
		local xMaxCheck = fogXMin < coor.x and coor.x < fogXMax
		
		local yMinCheck = fogYMin < coor.y and coor.y < fogYMax
		local yMaxCheck = fogYMin < coor.y and coor.y < fogYMax
		
		-- print("fogXMin: " .. fogXMin .. ", fogXMax: " .. fogXMax)
		-- print("fogYMin: " .. fogYMin .. ", fogYMax: " .. fogYMax)
		-- print("xMin: " .. xMin .. ", xMax: " .. xMax)
		-- print("yMin: " .. yMin .. ", yMax: " .. yMax)
		-- print("xMinCheck: " .. tostring(xMinCheck) .. ", xMaxCheck: " .. tostring(xMaxCheck))
		-- print("yMinCheck: " .. tostring(yMinCheck) .. ", yMaxCheck: " .. tostring(yMaxCheck))
		
		if ((xMinCheck or xMaxCheck) and (yMinCheck or yMaxCheck)) then
			return true
		end
	end
	return false
end

function fogscript:checkXDivideFog(coor, fogU)
	local xlfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth/2, fogU.contentHeight)
	fogscript:addFog(xlfog, fogU.x - fogU.contentWidth/4, fogU.y)
	local xrfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth/2, fogU.contentHeight)
	fogscript:addFog(xrfog, fogU.x + fogU.contentWidth/4, fogU.y)
	local result = false
	
	if fogscript:collisionCheck(coor, xlfog) then
		if fogscript:collisionCheck(coor, xrfog) then
			result = false
		else
			result = true
		end
	else
		result = true
	end
	
	fogscript:removeFog(xlfog)
	fogscript:removeFog(xrfog)
	return result
end

function fogscript:checkYDivideFog(coor, fogU)
	local ytfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth, fogU.contentHeight/2)
	fogscript:addFog(ytfog, fogU.x, fogU.y - fogU.contentHeight/4)
	local ybfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth, fogU.contentHeight/2)
	fogscript:addFog(ybfog, fogU.x, fogU.y + fogU.contentHeight/4)
	local result = false
	
	if fogscript:collisionCheck(coor, ytfog) then
		if fogscript:collisionCheck(coor, ybfog) then
			result = false
		else
			result = true
		end
	else
		result = true
	end
	
	fogscript:removeFog(ytfog)
	fogscript:removeFog(ybfog)
	return result
end

function fogscript:xDivideFog(coor, fogU)
	local xlfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth/2, fogU.contentHeight)
	fogscript:addFog(xlfog, fogU.x - fogU.contentWidth/4, fogU.y)
	local xrfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth/2, fogU.contentHeight)
	fogscript:addFog(xrfog, fogU.x + fogU.contentWidth/4, fogU.y)
	fogscript:removeFog(fogU)
	
end

function fogscript:yDivideFog(coor, fogU)
	local ytfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth, fogU.contentHeight/2)
	fogscript:addFog(ytfog, fogU.x, fogU.y - fogU.contentHeight/4)
	local ybfog = display.newImageRect(fogGroup, "assets/fogUnit.png", fogU.contentWidth, fogU.contentHeight/2)
	fogscript:addFog(ybfog, fogU.x, fogU.y + fogU.contentHeight/4)
	fogscript:removeFog(fogU)
end

function fogscript:compareDivideFog(coor, fogU)
	if fogU.contentHeight > fogU.contentWidth then
		fogscript:yDivideFog(coor, fogU)
	else
		fogscript:xDivideFog(coor, fogU)
	end
end

function fogscript:divideFog(coor, fogU)
	local xCheck = fogscript:checkXDivideFog(coor, fogU)
	local yCheck = fogscript:checkYDivideFog(coor, fogU)
	
	if xCheck and not(yCheck) then
		fogscript:yDivideFog(coor, fogU)
	elseif not(xCheck) and yCheck then
		fogscript:xDivideFog(coor, fogU)
	else
		fogscript:compareDivideFog(coor, fogU)
	end
end

function fogscript:checkFog(coor)
	for i, fogU in pairs(fogTable) do
		if fogscript:collisionCheck(coor, fogU) then
			if fogU.area > 2000 or fogU.contentHeight > (50) or fogU.contentWidth > (50) then
				fogscript:divideFog(coor, fogU)
				return false
			else
				fogscript:removeFog(fogU)
				return true
			end
		end
	end
end

function fogscript:clearFog(obj)
	
	local xMin = obj.x - obj.los
	local xMax = obj.x + obj.los
	local yMin = obj.y - obj.los
	local yMax = obj.y + obj.los
	
	local xCount = xMin
	local yCount = yMin
	
	print(obj.los)
	while xCount < xMax do
		while yCount < yMax do
			local coor = {}
			coor.x = xCount
			coor.y = yCount
			while fogscript:checkFog(coor) do end
			yCount = yCount + 5
		end
		print(xCount)
		yCount = 0
		xCount = xCount + 5
	end
		
end

return fogscript