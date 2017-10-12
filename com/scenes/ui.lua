-----------------------------------------------------------------------------------------
--
-- ui.lua
-- main ui functions
-----------------------------------------------------------------------------------------
local sprites = require "scripts.sprite"

local ui = {}
local spriteTable = sprites.loadSprites()

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
	
	local buildui = display.newSprite(spriteTable["buildmenu"], spriteTable["buildmenuData"])
	buildui.xScale = .4
	buildui.yScale = .4
	buildui.x = buildui.contentWidth/2
	buildui.y = display.contentHeight - 25
	buildui.selected = false
	buildui.name = "buildmenu"
	
	menuTable["buildmenu"] = buildui
	
	return menuTable
end

function ui.showBuildMenu()
	local menuTable = {}
	local menushelf = display.newImageRect("assets/buildmenushelf.png", 300, 40)
	menushelf.x = menushelf.contentWidth/2 + 25
	menushelf.y = display.contentHeight - 25
	menushelf.name = "buildmenu"
	
	menuTable["menushelf"] = menushelf
	
	local buildbarracks = display.newImageRect(spriteTable["barracks"], 1, 25, 25)
	buildbarracks.x = menushelf.contentWidth/2 + 25
	buildbarracks.y = display.contentHeight - 25
	buildbarracks.name = "buildmenu"
	
	menuTable["buildbarracks"] = buildbarracks
	
	return menuTable
end

function ui.transitionBuildMenu()

end

function ui.hideBuildMenu(menuTable)
	for i, menu in pairs(menuTable) do
		if menu ~= nil then
			menu:removeSelf()
		end
	end
end

function ui.updateUI(goldui)
	goldui.text = tostring(gold)

	
end

return ui