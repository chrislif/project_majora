-----------------------------------------------------------------------------------------
--
-- sprite.lua
-- main script for loading sprites
-----------------------------------------------------------------------------------------
local sprites = {}

function sprites:loadSprites() -- Gets all the necessary sprite sheets
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
		
		-- Rogue Guild Data
		----------------------------------------------------------------------------------
	local rogueguildOptions = 
	{
		frames =
		{
		  { -- 1) rogueguild normal
			x = 0,
			y = 0,
			width = 200,
			height = 200
		  },
		  { -- 2) rogueguild selected
			x = 0,
			y = 200,
			width = 200,
			height = 200
		  },
		},
	}
	local rogueguildSheet = graphics.newImageSheet("assets/rogueguild.png", rogueguildOptions)
	
	local rogueguildSequenceData = 
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
	spriteSheetTable["rogueguild"] = rogueguildSheet
	spriteSheetTable["rogueguildData"] = rogueguildSequenceData
		
		-- Ranger Guild Data
		----------------------------------------------------------------------------------
	local rangerguildOptions =
	{
		frames =
		{
		  { -- 1) rangerguild normal
			x = 0,
			y = 0,
			width = 200,
			height = 200
		  },
		  { -- 2) rangerguild selected
			x = 0,
			y = 200,
			width = 200,
			height = 200
		  },
		},
	}
	local rangerguildSheet = graphics.newImageSheet("assets/rangerguild.png", rangerguildOptions)
	
	local rangerguildSequenceData =
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
	spriteSheetTable["rangerguild"] = rangerguildSheet
	spriteSheetTable["rangerguildData"] = rangerguildSequenceData
	
		-- Wizard Guild Data
		local wizzyguildOptions =
	{
		frames =
		{
		  { -- 1) wizzyguild normal
			x = 0,
			y = 0,
			width = 200,
			height = 200
		  },
		  { -- 2) wizzyguild selected
			x = 0,
			y = 200,
			width = 200,
			height = 200
		  },
		},
	}
	local wizzyguildSheet = graphics.newImageSheet("assets/wizzyguild.png", wizzyguildOptions)
	
	local wizzyguildSequenceData =
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
	spriteSheetTable["wizzyguild"] = wizzyguildSheet
	spriteSheetTable["wizzyguildData"] = wizzyguildSequenceData
	
		-- Build Menu Data
		----------------------------------------------------------------------------------
	local selectuiOptions =
	{
		frames =
		{
		  { -- 1) selectui normal
			x = 0,
			y = 0,
			width = 100,
			height = 100
		  },
		  { -- 2) selectui castle selected
			x = 0,
			y = 100,
			width = 100,
			height = 100
		  },
		},
	}
	local selectuiSheet = graphics.newImageSheet("assets/selectui.png", selectuiOptions)
	
	local selectuiSequenceData =
	{
		{
		name = "normal",
		start = 1,
		count = 1,
		},
		{
		name = "castleSelected",
		start = 2,
		count = 1,
		},
		{
		name = "barracksSelected",
		start = 2,
		count = 1,
		}
	}
	spriteSheetTable["selectui"] = selectuiSheet
	spriteSheetTable["selectuiData"] = selectuiSequenceData
	
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