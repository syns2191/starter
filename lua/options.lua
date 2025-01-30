require "nvchad.options"

-- add yours here!
-- solarized colorscheme
local solarized_color = {
  base03 = "#002b36",
  base02 = "#073642",
  base01 = "#586e75",
  base00 = "#657b83",
  base0 = "#839496",
  base1 = "#93a1a1",
  base2 = "#eee8d5",
  base3 = "#fdf6e3",
  yellow = "#b58900",
  orange = "#cb4b16",
  red = "#dc322f",
  magenta = "#d33682",
  violet = "#6c71c4",
  blue = "#268bd2",
  cyan = "#2aa198",
  green = "#859900"
}

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
o.cursorline = true


vim.api.nvim_set_hl(0, "SolarizedActiveLine", {
  underline = true,
  bg = solarized_color.base02,
  fg = solarized_color.base1,
  sp = solarized_color.blue
})

vim.api.nvim_set_hl(0, "SolarizedInactiveLine", {
  bg = solarized_color.base03,
  fg = solarized_color.base01
})


vim.api.nvim_set_hl(0, "CursorLineNr", {
  underline = true,
  -- undercurl = true,
  bold = true,
  bg = "#363a45"
})

vim.api.nvim_set_hl(0, "CursorLine", {
  link = "SolarizedActiveLine"
})
