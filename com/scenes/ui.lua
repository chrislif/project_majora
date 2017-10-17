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
	goldui.type = "ui"
	
	goldtext = display.newText({text = tostring(gold)})
	goldtext.x = display.contentWidth - (goldui.contentWidth) - 10
	goldtext.y = goldui.contentHeight - 20
	goldtext.align = "center"
	goldtext.type = "ui"
	
	menuTable["goldui"] = goldtext
	
	buildui = display.newSprite(spriteTable["buildmenu"], spriteTable["buildmenuData"])
	buildui.xScale = .4
	buildui.yScale = .4
	buildui.x = buildui.contentWidth/2 + 10
	buildui.y = display.contentHeight
	buildui.selected = false
	buildui.name = "buildmenu"
	buildui.type = "build"
	
	menuTable["buildmenu"] = buildui
	
	return menuTable
end

function ui.showBuildMenu()	-- Load build menu
	local menuTable = {}
	
	-- Menu Shelf
	local buildshelf = display.newImageRect("assets/buildmenushelf.png", 275, 40)
	buildshelf.x = buildshelf.contentWidth/2 + 35
	buildshelf.y = display.contentHeight
	buildshelf.name = "buildshelf"
	buildshelf.type = "build"
	menuTable[buildshelf.name] = buildshelf
	
	-- Barracks
	local buildbarracks = display.newSprite(spriteTable["barracks"], spriteTable["barracksData"])
	buildbarracks.xScale = .15
	buildbarracks.yScale = .15
	buildbarracks.x = 75
	buildbarracks.y = display.contentHeight
	buildbarracks.selected = false
	buildbarracks.name = "buildbarracks"
	buildbarracks.building = "barracks"
	buildbarracks.type = "build"
	menuTable[buildbarracks.name] = buildbarracks
	
	-- Ranger Guild
	local buildrangerguild = display.newSprite(spriteTable["rangerguild"], spriteTable["rangerguildData"])
	buildrangerguild.xScale = .15
	buildrangerguild.yScale = .15
	buildrangerguild.x = 125
	buildrangerguild.y = display.contentHeight
	buildrangerguild.selected = false
	buildrangerguild.name = "buildrangerguild"
	buildrangerguild.building = "rangerguild"
	buildrangerguild.type = "build"
	menuTable[buildrangerguild.name] = buildrangerguild
	
	-- Rogue Guild
	local buildrogueguild = display.newSprite(spriteTable["rogueguild"], spriteTable["rogueguildData"])
	buildrogueguild.xScale = .15
	buildrogueguild.yScale = .15
	buildrogueguild.x = 175
	buildrogueguild.y = display.contentHeight
	buildrogueguild.selected = false
	buildrogueguild.name = "buildrogueguild"
	buildrogueguild.building = "rogueguild"
	buildrogueguild.type = "build"
	menuTable[buildrogueguild.name] = buildrogueguild
	
	-- Wizard Guild
	local buildwizzyguild = display.newSprite(spriteTable["wizzyguild"], spriteTable["wizzyguildData"])
	buildwizzyguild.xScale = .15
	buildwizzyguild.yScale = .15
	buildwizzyguild.x = 225
	buildwizzyguild.y = display.contentHeight
	buildwizzyguild.selected = false
	buildwizzyguild.name = "buildwizzyguild"
	buildwizzyguild.building = "wizzyguild"
	buildwizzyguild.type = "build"
	menuTable[buildwizzyguild.name] = buildwizzyguild
	
	return menuTable
end

function ui.getBuildOutline(building)	-- Get buildoutline for drag and drop menu
	local outline = display.newSprite(spriteTable[building], spriteTable[building.."Data"])
	outline.xScale = .5
	outline.yScale = .5
	return outline
end

function ui.hideBuildMenu(menuTable)	-- Hide build menu through destruction
	if menuTable ~= nil then
		for i, menu in pairs(menuTable) do
			if menu ~= nil then
				menuTable[i] = nil
				menu:removeSelf()
			end
		end
	end
end

function ui.showRecruitMenu(building)
	local recruitMenu = display.newSprite(spriteTable["recruitmenu"], spriteTable["recruitmenuData"])
	recruitMenu.x = building.x + building.contentWidth/2
	recruitMenu.y = building.y - building.contentHeight/2
	recruitMenu.name = "recruitMenu"
	recruitMenu.type = "recruit"
	recruitMenu.parent = building
	recruitMenu.selected = false
	
	objectTable["recruitMenu"] = recruitMenu
end

function ui.hideRecruitMenu()
	local recruitMenu = objectTable["recruitMenu"]
	objectTable["recruitMenu"] = nil
	recruitMenu:removeSelf()
end

function ui.updateUI(goldui)	-- Update UI, currently only gold
	goldui.text = tostring(gold)
end

return ui