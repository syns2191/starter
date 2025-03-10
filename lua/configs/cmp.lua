-- local cmp = require "cmp"
-- local blink_cmp = require "blink.cmp"
--
--
-- cmp.setup {
--   mapping = {
--     -- Tab navigation
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--
--     -- Shift+Tab for previous item
--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--
--     -- Confirm selection
--     ["<CR>"] = cmp.mapping.confirm { select = true },
--
--     -- Manually trigger completion
--     ["<C-Space>"] = cmp.mapping.complete(),
--   },
--
--   sources = cmp.config.sources {
--     { name = "blink.cmp" }, -- Primary completion source
--     { name = "nvim_lsp", keyword_length = 2 }, -- Avoid LSP duplicates
--     { name = "buffer", keyword_length = 3 }, -- Reduce noise from buffer
--     { name = "path" }, -- File path suggestions
--   },
--
--   -- Deduplicate completion items
--   formatting = {
--     format = function(entry, vim_item)
--       vim_item.dup = 0 -- Prevent duplicates from appearing
--       return vim_item
--     end,
--   },
-- }
--
-- blink_cmp.setup {
--   window = {
--     border = "rounded",
--     winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
--   },
-- }

local cmp = require("cmp")
cmp.setup({
  window = {
    mapping = {
      ["<CR>"] = cmp.mapping.confirm({ select = true })
    },
    completion = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      max_height = 10, -- Show only 10 suggestions at a time
    },
    documentation = {
      border = "rounded",
    },
  },
  sources = cmp.config.sources({
    { name = "codeium", priority = 1000 }, -- AI completions
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }),
  experimental = {
    ghost_text = {
      hl_group = "CmpGhostText",
    },
  },
})

-- Set highlight for ghost text (dimmed like comments)
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
