local lspconfig = require 'lspconfig'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'
mason.setup({})
mason_lspconfig.setup({
  automatic_installation = true
})

-- Auto-Completion
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function contains(list, x)
    for _, v in pairs(list) do
        if v == x then return true end
    end
    return false
end

local capabilities = cmp_nvim_lsp.default_capabilities();
capabilities.textDocument.completion.completionItem.snippetSupport = true

function on_attach(client,bufnr)
  utils.map("n", "<C-X>", ":AerialToggle float<CR>")
  utils.map("n", "<C-F>", function()
    vim.lsp.buf.code_action()
  end)
  utils.map("n", "<C-A>", function()
    vim.lsp.buf.hover()
  end)
  utils.map("n", "<C-D>", function()
    vim.lsp.buf.definition()
  end)
  utils.map("n", "<C-W>", function()
    vim.diagnostic.goto_prev()
  end)
  utils.map("n", "<C-E>", function()
    vim.diagnostic.goto_next()
  end)

    vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function()
      pcall(function()
        -- These have special, non-LSP formatters
        local whitelist = { "yaml", "json", "json5" }

        if contains(blacklist, vim.bo.filetype) then
          vim.lsp.buf.format({ timeout_ms = 200 })
        end
      end)
    end,
  })
end

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
}



-- Setup Languages that require no additional config (just use the LSP as-is)
local basic_languages = { "pyright", "bashls", "cssls", "html", "jsonls", "clangd", "yamlls", "marksman" }
-- local basic_languages = { "pyright", "bashls", "cssls", "html", "jsonls", "clangd", "yamlls", "marksman", "harper_ls"}

for _, lsp in ipairs(basic_languages) do
  lspconfig[lsp].setup(options)
end

  lspconfig.lua_ls.setup {
    server = {
      on_attach = function(client, bufnr)
        options.on_attach(client, bufnr)
      end,
      capabilities = options.capabilities
    },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
