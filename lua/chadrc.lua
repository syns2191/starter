-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "solarized_osaka",
  transparency = false,
  custom_highlights = {
    Normal = {
      bg = "#00000099"
    }
  }

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.plugins = {
  user = {
    ["nvim-base46"] = {
      custom_highlights = {
        Normal = {
          bg = "#00000099"
        }
      }
    }
  }
}

return M
