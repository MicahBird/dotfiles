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
require('lazy').setup({
  "max397574/better-escape.nvim",
})

-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api

function multiMap(modes, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  for i = 1, string.len(modes) do
    vim.keymap.set(string.sub(modes, i, i), lhs, rhs, options)
  end
end

-- QoL
g.mapleader = ' '
g.maplocalleader = ' '
opt.mouse = 'a'
opt.number = true
-- Case insensitive search
opt.ignorecase = true
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
cmd("set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/")

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

-- Switching windows
multiMap("n", "<C-j>", "<C-w>j")
multiMap("n", "<C-k>", "<C-w>k")
multiMap("n", "<C-l>", "<C-w>l")
multiMap("n", "<C-h>", "<C-w>h")
-- Splits
multiMap("n", "<leader>v", ":vsp<CR>")
multiMap("n", "<leader>h", ":sp<CR>")
-- Set working directory
multiMap("n", "<leader>.", ":lcd %:p:h<CR>")
-- Open File Tree
multiMap("n", "<leader>e", ':e<CR>')
-- Opens an edit command with the path of the currently edited file filled in
multiMap("n", "<leader>E", ':e <C-R>=expand("%:p:h") . "/" <CR>')
-- terminal emulation
multiMap("n", "<leader>sh", ":terminal<CR>")
-- Remove trailing whitespaces
vim.api.nvim_create_user_command('FixWhitespace', function()
    vim.cmd([[%s/\s\+$//e]])
end, {})
vim.api.nvim_set_keymap('n', '<leader>W', ':FixWhitespace<CR>', { noremap = true, silent = true })
--  Don't save delete, change to register
multiMap("nv", 'd', '"_d')
multiMap("nv", 'D', '"_D')
multiMap("nv", 'c', '"_c')
multiMap("nv", 'C', '"_C')
multiMap("nv", 'x', '"_x')
multiMap("nv", 'X', '"_X')
multiMap("nv", 's', '"_s')
multiMap("nv", 'S', '"_S')
multiMap("nv", '<leader>d', 'd') -- Keep a cut
-- Map P to paste on new line
multiMap("n", "P", ":pu<CR>")
-- Map yW to yank rest of line
multiMap("n","yW","y$")
-- Move visual block
multiMap("v", "J", ":m '>+1<CR>gv=gv")
multiMap("v", "K", ":m '<-2<CR>gv=gv")
-- Vmap for maintain Visual Mode after shifting > and <
multiMap("v","<","<gv")
multiMap("v",">",">gv")
-- Remove Search Highlighting after pressing escape
multiMap("n","<esc>",":noh<cr><esc>")
-- Reload Neovim
multiMap("n", "<leader><leader>r", ":source $MYVIMRC<CR>")
