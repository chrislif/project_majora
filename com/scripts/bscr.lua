-----------------------------------------------------------------------------------------
--
-- bscr.lua
-- collection of basic scripts
-----------------------------------------------------------------------------------------
local bscript = {}

function bscript.sign(i)	-- Find the sign of an integer
	if i > 0 then
		return 1
	elseif i < 0 then
		return -1
	else
		return 0
	end
end

return bscript