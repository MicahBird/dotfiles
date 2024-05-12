local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local lazy = require 'lazy'
lazy.setup({
  'nvim-treesitter/nvim-treesitter',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  -- "rebelot/kanagawa.nvim",
  {
    'Mofiqul/vscode.nvim',
    opts = {
      -- Enable italic comment
      italic_comments = true,

      -- Underline `@markup.link.*` variants
      underline_links = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,
    },
    lazy = false,
  },
  "max397574/better-escape.nvim",

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },

  { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },
  'stevearc/aerial.nvim',

  -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  'nvim-telescope/telescope-ui-select.nvim',
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
      'nvim-tree/nvim-tree.lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
  },
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
-- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
}
})

-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local utils = require 'utils'

-- QoL
g.syntax_enable = false

cmd("cnoreabbrev W! w!")
cmd("cnoreabbrev Q! q!")
cmd("cnoreabbrev Qall! qall!")
cmd("cnoreabbrev Wq wq")
cmd("cnoreabbrev Wa wa")
cmd("cnoreabbrev wQ wq")
cmd("cnoreabbrev WQ wq")
cmd("cnoreabbrev W w")
cmd("cnoreabbrev Q q")
cmd("cnoreabbrev Qall qall")

utils.map("n", "<C-j>", "<C-w>j")
utils.map("n", "<C-k>", "<C-w>k")
utils.map("n", "<C-l>", "<C-w>l")
utils.map("n", "<C-h>", "<C-w>h")
--  Don't save delete, change to register
utils.map("nv", 'd', '"_d')
utils.map("nv", 'c', '"_c')
utils.map("nv", 'C', '"_C')
-- Map P to paste on new line
utils.map("n", "P", ":pu<CR>")
-- Map yW to yank rest of line
utils.map("n","yW","y$")
-- Move visual block
utils.map("v", "J", ":m '>+1<CR>gv=gv")
utils.map("v", "K", ":m '<-2<CR>gv=gv")
-- Vmap for maintain Visual Mode after shifting > and <
utils.map("v","<","<gv")
utils.map("v",">",">gv")

g.mapleader = ' '
opt.mouse = 'a'
opt.number = true
-- opt.relativenumber = true
opt.signcolumn = 'number'
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wildmode = 'longest,list,full'
opt.termguicolors = true
opt.clipboard = 'unnamedplus'
opt.foldmethod = 'indent'
opt.foldenable = false
opt.updatetime = 250
opt.smartcase = true
opt.wrap = true
opt.undofile = true

--

-- Reload Neovim
utils.map("n", "<leader><leader>r", ":source $MYVIMRC<CR>")

cmd("colorscheme vscode")
vim.o.background = "dark"

-- Load Plugins
require('undotree').setup()
utils.map("n", "<leader>u", "<cmd>lua require('undotree').toggle()<cr>")
require('lualine').setup {
  options = {
    theme = 'vscode'
    -- ... your lualine config
  }
}
require('better_escape').setup()

require 'treesitter'

-- Auto-Completion
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    }
  )
})

require 'lsp'
local telescope = require 'telescope'

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    borderchars = { "", "", "", "", "", "", "", "" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    }
  },
  extensions = {
    ["ui-select"] = {
      sorting_strategy = "ascending",
      results_title = false,
      layout_strategy = "cursor",
      layout_config = {
        width = 60,
        height = 9,
      },
      borderchars = { "", "", "", "", "", "", "", "" },
    },
    frecency = {
      auto_validate = false
    }
  }
})
telescope.load_extension('ui-select')
-- telescope.load_extension('frecency')

utils.map("n", "<leader>f", ":Telescope find_files<CR>")
utils.map("n", "<leader>g", ":Telescope live_grep<CR>")
utils.map("n", "<leader>t", ":Telescope treesitter<CR>")
utils.map("n", "<leader>b", ":Telescope current_buffer_fuzzy_find<CR>")
