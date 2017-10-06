-------------------------------------------------------------------------
---
---	Set of basic functions
---	
-------------------------------------------------------------------------
local script = {}

function script.sign(i)	-- Find the sign of an integer
	if i > 0 then
		return 1
	elseif i < 0 then
		return -1
	else
		return 0
	end
end

function script.tablelength(T)	-- Get length of a table
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

return script