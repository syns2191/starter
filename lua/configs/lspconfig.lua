-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local util = require "lspconfig.util"

local lspconfig = require "lspconfig"
local os = require "os"

-- EXAMPLE
local servers = { "html", "cssls", "lua_ls", "eslint", "ts_ls" }
local nvlsp = require "nvchad.configs.lspconfig"
vim.g.auto_format = false
vim.diagnostic.config {
  update_in_insert = false, -- Don't update diagnostics while typing
}
-- lsps with default config
local capabilities = nvlsp.capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities
  }
end

local python_path = "/Users/sysng/nyoman/jubelio/repos/services-image-processing-service/env10/bin/python3.10" -- Default to system Python

local venv_path = os.getenv "VIRTUAL_ENV"
if venv_path then
  if vim.fn.has "win32" == 1 then
    python_path = venv_path .. "\\Scripts\\python.exe"
  else
    python_path = venv_path .. "/bin/python3.10" -- Adjust this based on your Python version
  end
end

lspconfig.ts_ls.setup {
  single_file_support = true, -- Avoid loading full projects into memory
  flags = { debounce_text_changes = 200 }, -- Reduce CPU load

  on_attach = function(client)
    -- Disable built-in formatting (use Prettier instead)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    client.server_capabilities.renameProvider = false -- Disable renaming (optional)
    client.server_capabilities.codeActionProvider = false

    -- Optionally disable diagnostics to reduce memory usage
    client.server_capabilities.diagnostics = false
  end,

  init_options = {
    hostInfo = "neovim",
    maxTsServerMemory = 2048, -- Limit TypeScript server memory usage
    preferences = {
      disableSuggestions = false, -- Disable autocomplete suggestions from tsls
    },
  },
}

-- require("lspconfig").ts_ls.setup({
--   flags = { debounce_text_changes = 3000 },
--   root_dir = function(fname)
--     return util.root_pattern("package.json", "tsconfig.json", ".git")(fname)
--   end,
--   settings = {
--     typescript = {
--       inlayHints = { includeInlayParameterNameHints = "none" },
--     },
--   },
--   capabilities = nvlsp.capabilities,
--   on_attach = function(client, bufnr)
--     client.server_capabilities.definitionProvider = true
--   end,
-- })

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--
-- Additional ESLint-specific configuration
lspconfig.eslint.setup {
  flags = { debounce_text_changes = 500 },
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = function(fname)
    return require("lspconfig").util.root_pattern(".eslintrc", ".eslintrc.json", "package.json")(fname)
  end,
  on_attach = function(client, bufnr)
    -- Use the default on_attach function from nvchad
    nvlsp.on_attach(client, bufnr)

    -- -- Enable auto-fixing on save if ESLint supports it
    -- if client.server_capabilities.documentFormattingProvider and vim.g.auto_format then
    --   vim.cmd [[
    --     augroup LspFormatting
    --       autocmd! * <buffer>
    --       autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
    --     augroup END
    --   ]]
    -- end
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    eslint = {
      codeAction = { disableRuleComment = { enable = false } },
    },
    -- ESLint-specific settings
  },
}

-- active the pyright if code in python
lspconfig.pyright.setup {
  flags = { debounce_text_changes = 3000 },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  filetypes = { "python" },
  capabilities = nvlsp.capabilities,
  settings = {
    python = {
      pythonPath = python_path,
      analysis = {
        autoSearchPaths = true, -- Automatically search for Python modules in the environment
        useLibraryCodeForTypes = true, -- Include library code for type checking
      },
    },
  },
}

-- neovim ufo lsp config
require("ufo").setup()
