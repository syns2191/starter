return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    commit = "29be0919b91fb59eca9e90690d76014233392bef",
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
  },
  {
    "prettier/vim-prettier",
    branch = "master",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    branch = "main",
  },
  {
    "tpope/vim-fugitive",
    branch = "master",
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      "echasnovski/mini.pick", -- optional
    },
    config = true,
  },
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    branch = "main",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    branch = "master",
    event = "VeryLazy",
    init = function()
      -- Optional: Disable default keybindings if needed
      -- vim.g.tmux_navigator_no_mappings = 0

      -- Only add this if you need terminal buffer support
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          vim.keymap.set("t", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { buffer = true })
          vim.keymap.set("t", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { buffer = true })
          vim.keymap.set("t", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { buffer = true })
          vim.keymap.set("t", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { buffer = true })
        end,
      })
    end,
  },
  {
    "folke/noice.nvim",
    version = "v4.9.0",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
      },
      -- add any options here
      --
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000",
        },
      },
    },
  },

  -- { "akinsho/git-conflict.nvim", version = "*", config = true },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    -- opts = {
    -- 	ensure_installed = {
    -- 		"vim", "lua", "vimdoc",
    --     "html", "css"
    -- 	},
    -- },
  },
  {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    config = function() end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.experimental = opts.experimental or {}
      opts.experimental.ghost_text = {
        hl_group = "CmpGhostText",
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    version = "v1.8.2", -- Replace with the stable version you want
  },
  {
    "lewis6991/gitsigns.nvim",
    version = "v0.6", -- Replace with a stable version
  },
  -- {
  --   "saghen/blink.cmp",
  --   -- optional: provides snippets for the snippet source
  --   dependencies = "rafamadriz/friendly-snippets",
  --
  --   -- use a release tag to download pre-built binaries
  --   version = "*",
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   -- If you use nix, you can build from source using latest nightly rust with:
  --   -- build = 'nix run .#build-plugin',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     -- 'default' for mappings similar to built-in completion
  --     -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  --     -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  --     -- See the full "keymap" documentation for information on defining your own keymap.
  --     keymap = { preset = "default" },
  --
  --     appearance = {
  --       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- Useful for when your theme doesn't support blink.cmp
  --       -- Will be removed in a future release
  --       use_nvim_cmp_as_default = true,
  --       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = "mono",
  --     },
  --
  --     -- Default list of enabled providers defined so that you can extend it
  --     -- elsewhere in your config, without redefining it, due to `opts_extend`
  --     sources = {
  --       default = { "lsp", "path", "snippets", "buffer" },
  --     },
  --   },
  --   opts_extend = { "sources.default" },
  -- }
}
