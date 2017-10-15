-----------------------------------------------------------------------------------------
--
-- ui.lua
-- main ui functions
-----------------------------------------------------------------------------------------
local sprites = require "scripts.sprite"

local ui = {}
local selectui
local goldui
local goldtext
local buildui
local spriteTable = sprites.loadSprites()


function ui.loadUI()	-- Load UI, usually on load
	local menuTable = {}

	goldui = display.newImageRect("assets/goldui.png", 15, 15)
	goldui.x = display.contentWidth - (goldui.contentWidth * 3) - 10
	goldui.y = goldui.contentHeight - 20

	selectui = display.newSprite(spriteTable["selectui"], spriteTable["selectuiData"])
	selectui.xScale = .5
	selectui.yScale = .5
	selectui.x = selectui.contentWidth/2 + 10
	selectui.y = selectui.contentHeight/2 - 20
	
	goldtext = display.newText({text = tostring(gold)})
	goldtext.x = display.contentWidth - (goldui.contentWidth) - 10
	goldtext.y = goldui.contentHeight - 20
	goldtext.align = "center"
	
	menuTable["goldui"] = goldtext
	
	buildui = display.newSprite(spriteTable["buildmenu"], spriteTable["buildmenuData"])
	buildui.xScale = .4
	buildui.yScale = .4
	buildui.x = buildui.contentWidth/2 + 10
	buildui.y = display.contentHeight
	buildui.selected = false
	buildui.name = "buildmenu"
	
	menuTable["buildmenu"] = buildui
	
	return menuTable
end

function ui.showBuildMenu()	-- Load build menu
	local menuTable = {}
	
	-- Menu Shelf
	local menushelf = display.newImageRect("assets/buildmenushelf.png", 275, 40)
	menushelf.x = menushelf.contentWidth/2 + 35
	menushelf.y = display.contentHeight
	menushelf.name = "buildshelf"
	menuTable["menushelf"] = menushelf
	
	-- Barracks
	local buildbarracks = display.newSprite(spriteTable["barracks"], spriteTable["barracksData"])
	buildbarracks.xScale = .15
	buildbarracks.yScale = .15
	buildbarracks.x = 75
	buildbarracks.y = display.contentHeight
	buildbarracks.selected = false
	buildbarracks.name = "buildbarracks"
	buildbarracks.building = "barracks"
	menuTable["buildbarracks"] = buildbarracks
	
	-- Ranger Guild
	local buildrangerguild = display.newSprite(spriteTable["rangerguild"], spriteTable["rangerguildData"])
	buildrangerguild.xScale = .15
	buildrangerguild.yScale = .15
	buildrangerguild.x = 125
	buildrangerguild.y = display.contentHeight
	buildrangerguild.selected = false
	buildrangerguild.name = "buildrangerguild"
	buildrangerguild.building = "rangerguild"
	menuTable["buildrangerguild"] = buildrangerguild
	
	-- Rogue Guild
	local buildrogueguild = display.newSprite(spriteTable["rogueguild"], spriteTable["rogueguildData"])
	buildrogueguild.xScale = .15
	buildrogueguild.yScale = .15
	buildrogueguild.x = 175
	buildrogueguild.y = display.contentHeight
	buildrogueguild.selected = false
	buildrogueguild.name = "buildrogueguild"
	buildrogueguild.building = "rogueguild"
	menuTable["buildrogueguild"] = buildrogueguild
	
	-- Wizard Guild
	local buildwizzyguild = display.newSprite(spriteTable["wizzyguild"], spriteTable["wizzyguildData"])
	buildwizzyguild.xScale = .15
	buildwizzyguild.yScale = .15
	buildwizzyguild.x = 225
	buildwizzyguild.y = display.contentHeight
	buildwizzyguild.selected = false
	buildwizzyguild.name = "buildwizzyguild"
	buildwizzyguild.building = "wizzyguild"
	menuTable["buildwizzyguild"] = buildwizzyguild
	return menuTable
end

function ui.getBuildOutline(building)	-- Get buildoutline for drag and drop menu
	local outline = display.newSprite(spriteTable[building], spriteTable[building.."Data"])
	outline.xScale = .5
	outline.yScale = .5
	return outline
end

function ui.selectUI(obj)
	selectui:setSequence(obj.name .. "Selected")
end

function ui.deselectUI()
	selectui:setSequence("normal")
end

function ui.hideBuildMenu(menuTable)	-- Hide build menu through destruction
	if menuTable ~= nil then
		for i, menu in pairs(menuTable) do
			if menu ~= nil then
				menu:removeSelf()
			end
		end
	end
end

function ui.updateUI(goldui)	-- Update UI, currently only gold
	goldui.text = tostring(gold)
end

return ui