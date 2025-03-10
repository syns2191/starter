require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("i", "JJ", "<ESC>")
map("i", "JK", "<ESC>")

local term_clear = function()
  vim.fn.feedkeys("", "n")
  local sb = vim.bo.scrollback
  vim.bo.scrollback = 1
  vim.bo.scrollback = sb
end
-- kmap({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.35,
      col = 0.05,
      width = 0.9,
      height = 0.7,
    },
  }
end, { desc = "terminal toggle floating term" })

map("t", "<C-t>", "<C-\\><C-n>", { desc = "Switch to normal mode in terminal" })
map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle Git blame" })
map("t", "<C-[>", term_clear)

-- move line down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "move line up normanl mode" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "move line down insert mode" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move line down visual mode" })

-- move line up
map("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up yuuuuuormal mode" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line up inser mode" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move line up visual mode" })

vim.g.VM_maps = {
      ["Find Under"] = "<A-d>",           -- Start multi-cursor on the word under the cursor
      ["Add Cursor Down"] = "<A-Down>",      -- Add cursor down
      ["Add Cursor Up"] = "<A-Up>",        -- Add cursor up
      ["Select All"] = "<A-a>",           -- Select all occurrences
      ["Remove Region"] = "<A-x>",        -- Remove current region
    }


-- Split Window
map("n",  "ss", ":split<Return>", {desc = "split window horizontal"})
map("n", "sv", ":vplit<Return>", {desc = "split window vertical"})


-- Move Window
map("n", "sh", "<C-w>h", {desc = "move window to left"})

-- resize window
map("n", "<C-w><left>", "<C-w><", {desc="resize left"})
map("n", "<C-w><right>", "<C-w>>", {desc="resize right"})
map("n", "<C-w><up>", "<C-w>+", {desc = "resize up"})
map("n", "<C-w><down>", "<C-w>-", {desc="resize down"})
-- Open Neogit in a split
map('n', '<leader>gs', ':Neogit kind=split<CR>', { noremap = true, silent = true })

-- Open Neogit in a tab
map('n', '<leader>gt', ':Neogit kind=tab<CR>', { noremap = true, silent = true })

-- Quickly stage and commit
map('n', '<leader>gc', ':Neogit commit<CR>', { noremap = true, silent = true })

-- Pull changes from remote
map('n', '<leader>gp', ':Neogit pull<CR>', { noremap = true, silent = true })

-- Push changes to remote
map('n', '<leader>gP', ':Neogit push<CR>', { noremap = true, silent = true })

-- Open Diffview (requires Diffview.nvim)
map('n', '<leader>gd', ':DiffviewOpen<CR>', { noremap = true, silent = true })

-- Close Diffview
map('n', '<leader>gq', ':DiffviewClose<CR>', { noremap = true, silent = true })

-- View Git history (Diffview)
map('n', '<leader>gh', ':DiffviewFileHistory<CR>', { noremap = true, silent = true })
map('n', '<leader>gb', ':Neogit kind=split<CR>:G blame<CR>', { noremap = true, silent = true })
map('n', '<leader>gl', ':Neogit kind=split<CR>:G log<CR>', { noremap = true, silent = true })
map('n', '<leader>gr', ':Gvdiffsplit!<CR>', { noremap = true, silent = true })
map('n', '<leader>gh', ':DiffviewFileHistory %<CR>', { noremap = true, silent = true })

map('n', '<leader>gb', ':GitBlameToggle<CR>', { noremap = true, silent = true })
map('n', 'gnc', ']c', { noremap = true, silent = true })

-- Jump to the previous change in Neogit
map('n', 'gnp', '[c', { noremap = true, silent = true })
-- end of git
map('n', '<leader>j', '5j', { noremap = true, silent = true })

map('n', '<leader>jq', ':normal! ggVGgJ<CR>:%!jq .<CR>', { noremap = true, silent = true })
-- Wrap the current word with brackets
map("n", "<leader>w[", "ysiw[", { noremap = true, silent = true })

-- Wrap visually selected text with brackets
map("v", "<leader>w[", "S[", { noremap = true, silent = true })
map("v", "<Tab>", ">gv", { noremap = true, silent = true })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })


-- key remapping folding ufo
map("n", "zR", require('ufo').openAllFolds)
map("n", "zM", require('ufo').closeAllFolds)
map("n", "zr", require('ufo').openFoldsExceptKinds)
map("n", "zm", require('ufo').closeFoldsWith)
map("n", "zo", ':foldopen<CR>')
map("n", "zc", ':foldclose<CR>')

map("n", "K", function ()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)

