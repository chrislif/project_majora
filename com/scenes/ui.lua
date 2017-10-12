-----------------------------------------------------------------------------------------
--
-- ui.lua
-- main ui functions
-----------------------------------------------------------------------------------------
local ui = {}

function ui.loadUI()
	local menuTable = {}

	local goldui = display.newImageRect("assets/goldui.png", 15, 15)
	goldui.x = display.contentWidth - (goldui.contentWidth * 3)
	goldui.y = goldui.contentHeight

	local goldtext = display.newText({text = tostring(gold)})
	goldtext.x = display.contentWidth - (goldui.contentWidth)
	goldtext.y = goldui.contentHeight - 1
	goldtext.align = "center"
	
	menuTable["goldui"] = goldtext
	
	local buildui = display.newImageRect("assets/buildmenu.png", 40, 40)
	buildui.x = buildui.contentWidth/2
	buildui.y = display.contentHeight - 25
	buildui.name = "buildmenu"
	
	menuTable["buildmenu"] = buildui
	
	return menuTable
end

function ui.updateUI(goldui)
	goldui.text = tostring(gold)

end

return ui