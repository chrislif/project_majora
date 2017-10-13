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
	goldui.x = display.contentWidth - (goldui.contentWidth * 3) - 10
	goldui.y = goldui.contentHeight - 20

	local goldtext = display.newText({text = tostring(gold)})
	goldtext.x = display.contentWidth - (goldui.contentWidth) - 10
	goldtext.y = goldui.contentHeight - 20
	goldtext.align = "center"
	
	menuTable["goldui"] = goldtext
	
	local buildui = display.newSprite(spriteTable["buildmenu"], spriteTable["buildmenuData"])
	buildui.xScale = .4
	buildui.yScale = .4
	buildui.x = buildui.contentWidth/2
	buildui.y = display.contentHeight
	buildui.selected = false
	buildui.name = "buildmenu"
	
	menuTable["buildmenu"] = buildui
	
	return menuTable
end

function ui.showBuildMenu()
	local menuTable = {}
	local menushelf = display.newImageRect("assets/buildmenushelf.png", 300, 40)
	menushelf.x = menushelf.contentWidth/2 + 25
	menushelf.y = display.contentHeight
	menushelf.name = "buildshelf"
	
	menuTable["menushelf"] = menushelf
	
	local buildbarracks = display.newSprite(spriteTable["barracks"], spriteTable["barracksData"])
	buildbarracks.xScale = .15
	buildbarracks.yScale = .15
	buildbarracks.x = 75
	buildbarracks.y = display.contentHeight
	buildbarracks.selected = false
	buildbarracks.name = "buildbarracks"
	
	menuTable["buildbarracks"] = buildbarracks
	
	return menuTable
end

function ui.transitionBuildMenu()

end

function ui.hideBuildMenu(menuTable)
	if menuTable ~= nil then
		for i, menu in pairs(menuTable) do
			if menu ~= nil then
				menu:removeSelf()
			end
		end
	end
end

function ui.updateUI(goldui)
	goldui.text = tostring(gold)

	
end

return ui