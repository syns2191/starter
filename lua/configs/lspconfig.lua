-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local os = require "os"

-- EXAMPLE
local servers = { "html", "cssls", "ts_ls", "lua_ls", "eslint" }
local nvlsp = require "nvchad.configs.lspconfig"
vim.g.auto_format = false
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local python_path = "/Users/sysng/nyoman/jubelio/repos/services-image-processing-service/env10/bin/python3.10"  -- Default to system Python

local venv_path = os.getenv("VIRTUAL_ENV")
if venv_path then
  if vim.fn.has("win32") == 1 then
    python_path = venv_path .. "\\Scripts\\python.exe"
  else
    python_path = venv_path .. "/bin/python3.10"  -- Adjust this based on your Python version
  end
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--
-- Additional ESLint-specific configuration
lspconfig.eslint.setup {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = require("lspconfig").util.root_pattern(".eslintrc", "package.json"),
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
    -- ESLint-specific settings
    eslint = {
      format = { enable = false }, -- Enable ESLint formatting
      packageManager = "npm", -- Adjust if using Yarn or pnpm
    },
  },
}

lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    python = {
      filetypes = { "python" },
      pythonPath = python_path ,
      analysis = {
        autoSearchPaths = true,   -- Automatically search for Python modules in the environment
        useLibraryCodeForTypes = true,  -- Include library code for type checking
      }
    },
  },
}
