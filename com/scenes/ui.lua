-----------------------------------------------------------------------------------------
--
-- ui.lua
-- main ui functions
-----------------------------------------------------------------------------------------
local ui = {}

function ui.loadUI()
	local goldui = display.newImageRect("assets/goldui.png", 15, 15)
	goldui.x = display.contentWidth - (goldui.contentWidth * 3)
	goldui.y = goldui.contentHeight

	local goldTextOptions = 
	{
	text = tostring(gold)
	
	}
	local goldtext = display.newText(goldTextOptions)
	goldtext.x = display.contentWidth - (goldui.contentWidth * 2)
	goldtext.y = goldui.contentHeight
	
	local buildui = display.newImageRect("assets/buildmenu.png", 50, 50)
	buildui.x = buildui.contentWidth/2
	buildui.y = display.contentHeight - 25
	buildui.name = "buildmenu"
	
	return buildui
end

return ui