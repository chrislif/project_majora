-----------------------------------------------------------------------------------------
--
-- sprite.lua
-- main script for loading sprites
-----------------------------------------------------------------------------------------
local sprites = {}

function sprites:loadSprites()
	local spriteSheetTable = {}

		-- Castle Data
		----------------------------------------------------------------------------------
	local castleOptions =
	{
		frames =
		{
		  { -- 1) castle normal
			x = 0,
			y = 0,
			width = 200,
			height = 200
		  },
		  { -- 2) castle selected
			x = 0,
			y = 200,
			width = 200,
			height = 200
		  },
		},
	}
	local castleSheet = graphics.newImageSheet("assets/castle.png", castleOptions)

	local castleSequenceData = 
	{
		{
		name = "normal",
		start = 1,
		count = 1,
		},
		{
		name = "selected",
		start = 2,
		count = 1,
		}
	}
	spriteSheetTable["castle"] = castleSheet
	spriteSheetTable["castleData"] = castleSequenceData
	
		-- Barracks Data
		----------------------------------------------------------------------------------
	local barracksOptions = 
	{
		frames =
		{
		  { -- 1) barracks normal
			x = 0,
			y = 0,
			width = 200,
			height = 200
		  },
		  { -- 2) barracks selected
			x = 0,
			y = 200,
			width = 200,
			height = 200
		  },
		},
	}
	local barracksSheet = graphics.newImageSheet("assets/barracks.png", barracksOptions)
	
	local barracksSequenceData = 
	{
		{
		name = "normal",
		start = 1,
		count = 1,
		},
		{
		name = "selected",
		start = 2,
		count = 1,
		}
	}
	spriteSheetTable["barracks"] = barracksSheet
	spriteSheetTable["barracksData"] = barracksSequenceData
	
		-- Build Menu Data
		----------------------------------------------------------------------------------
	local buildmenuOptions =	
	{
		frames =
		{
		  { -- 1) buildmenu normal
			x = 0,
			y = 0,
			width = 100,
			height = 100
		  },
		  { -- 2) buildmenu selected
			x = 0,
			y = 100,
			width = 100,
			height = 100
		  },
		},
	}
	local buildmenuSheet = graphics.newImageSheet("assets/buildmenu.png", buildmenuOptions)
	
	local buildmenuSequenceData =
	{
		{
		name = "normal",
		start = 1,
		count = 1,
		},
		{
		name = "selected",
		start = 2,
		count = 1,
		}
	}
	spriteSheetTable["buildmenu"] = buildmenuSheet
	spriteSheetTable["buildmenuData"] = buildmenuSequenceData
		
		-- Return Data
		----------------------------------------------------------------------------------
	return spriteSheetTable
end

return sprites