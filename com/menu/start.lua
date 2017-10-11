-----------------------------------------------------------------------------------------
--
-- start.lua
-- start menu
-----------------------------------------------------------------------------------------
local composer = require "composer" 

-- Initialize Scene
local scene = composer.newScene()
local backGroup = display.newGroup()
local buttonGroup = display.newGroup()

local background = display.newImageRect(backGroup, "assets/background.png", 800, 1400)
background.x = display.contentCenterX
background.y = display.contentCenterY

local button = display.newImageRect(buttonGroup, "assets/start.png", 200, 100)
button.x = display.contentCenterX
button.y = display.contentCenterY

local function startGame(event)
	composer.gotoScene("scenes.game")
	background:removeSelf()
	button:removeSelf()
	composer.removeScene("start")
end

button:addEventListener("tap", startGame)

return scene