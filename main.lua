-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local script = require(".bscr")

local backGroup = display.newGroup()
local buildGroup = display.newGroup()
local unitGroup = display.newGroup()


local gameLoopTimer
	
local function gameLoop()

end

gameLoopTimer = timer.performWithDelay(5, gameLoop, -1)