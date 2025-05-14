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
  { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },
  'stevearc/aerial.nvim',
  -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  'nvim-telescope/telescope-ui-select.nvim',
  {
      'vim-airline/vim-airline', -- Using vim-airline b/c I couldn't get a word count to work on lualine :/
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
    dependencies = { 'nvim-lua/plenary.nvim', 'rafi/telescope-thesaurus.nvim' },
    opts = {
      extensions = {
        thesaurus = {
          provider = 'freedictionaryapi',
        },
      },
    },
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
  },
  {
    'folke/zen-mode.nvim',
      opts = {
         window = {
           backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
           -- height and width can be:
           -- * an absolute number of cells when > 1
           -- * a percentage of the width / height of the editor when <= 1
           -- * a function that returns the width or the height
           -- width = .60, -- width of the Zen window
           height = .85, -- height of the Zen window
           -- by default, no options are changed for the Zen window
           -- uncomment any of the options below, or add other vim.wo options you want to apply
           options = {
             signcolumn = "no", -- disable signcolumn
             number = false, -- disable number column
             relativenumber = false, -- disable relative numbers
             -- cursorline = false, -- disable cursorline
             -- cursorcolumn = false, -- disable cursor column
             -- foldcolumn = "0", -- disable fold column
             -- list = false, -- disable whitespace characters
           },
         },
      },
  },
  'David-Kunz/gen.nvim',
  'm4xshen/autoclose.nvim',
  'mbbill/undotree',
  'xiyaowong/transparent.nvim',
  'gruvbox-community/gruvbox', -- Using non-lua version so it co-operates with Vim Airline
  -- 'ron89/thesaurus_query.vim', -- Replaced with telescope plugin
  -- 'junegunn/goyo.vim', -- Replaced with Zen Mode
  'reedes/vim-pencil',
  'reedes/vim-wordy',
  'preservim/vim-lexical',
  'preservim/vim-litecorrect',
  'kepano/flexoki-neovim',
  {
    'Pocco81/auto-save.nvim',
    opts = {
      trigger_events = {"InsertLeave"},
      cleaning_interval = 0,
    },
	},
})

-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local utils = require 'utils'

-- QoL
g.syntax_enable = false
g.mapleader = ' '
opt.mouse = 'a'
opt.number = true

-- Load Plugins
require("autoclose").setup()
require("better_escape").setup()
-- disable netrw 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({ actions = { open_file = { quit_on_open = true, }, }, })
-- require 'treesitter'
local telescope = require 'telescope'

-- **Writing plugins config**
vim.g['pencil#wrapModeDefault'] = 'soft'

vim.g['gen_options'] = {
    model = 'mixtral',
    host = 'localhost',
    port = '11434',
    display_mode = 'split'
}

vim.g['gen_prompts'] = {
    Elaborate_Text = {
        prompt = "Elaborate the following text:\n$text",
        replace = true
    }
}

-- Autostart Scripts
cmd([[
let user_dict = {
  \ 'maybe': ['mabye'],
  \ 'medieval': ['medival', 'mediaeval', 'medevil'],
  \ 'then': ['hten'],
  \ 'the': ['thr'],
  \ 'not': ['nto'],
  \ 'necciracry': ['necessary'],
  \ 'Monday': ['monday'],
  \ 'Tuesday': ['tuesday'],
  \ 'Wednesday': ['wednesday'],
  \ 'Thursday': ['whursday'],
  \ 'Friday': ['friday'],
  \ 'quote': ['qoute'],
  \ 'Quote': ['Qoute'],
  \ 'media': ['meida'],
  \ 'because': ['becuase', 'becase', 'becasue', 'beucase'],
  \ }

" Autostart Scripts
augroup pencil
  autocmd!
  autocmd VimEnter * call pencil#init({'wrap': 'soft'})
                            \ | call lexical#init()
                            \ | call litecorrect#init(user_dict)
  autocmd FileType * call pencil#init({'wrap': 'soft'})
                            \ | call lexical#init()
                            \ | call litecorrect#init(user_dict)
augroup END

let g:lexical#spell_key = '<leader>s'
let g:lexical#spelllang = ['en_us']
]])

-- **Keybinds**
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
utils.map("n", "<C-j>", "<C-w>j")
utils.map("n", "<C-k>", "<C-w>k")
utils.map("n", "<C-l>", "<C-w>l")
utils.map("n", "<C-h>", "<C-w>h")
-- Splits
utils.map("n", "<leader>v", ":vsp<CR>")
utils.map("n", "<leader>h", ":sp<CR>")
-- Set working directory
utils.map("n", "<leader>.", ":lcd %:p:h<CR>")
-- Open File Tree
utils.map("n", "<leader>e", ':NvimTreeOpen<CR>')
-- Opens an edit command with the path of the currently edited file filled in
utils.map("n", "<leader>E", ':e <C-R>=expand("%:p:h") . "/" <CR>')
-- terminal emulation
utils.map("n", "<leader>sh", ":terminal<CR>")
-- Remove trailing whitespaces
vim.api.nvim_create_user_command('FixWhitespace', function()
    vim.cmd([[%s/\s\+$//e]])
end, {})
vim.api.nvim_set_keymap('n', '<leader>W', ':FixWhitespace<CR>', { noremap = true, silent = true })
--  Don't save delete, change to register
utils.map("nv", 'd', '"_d')
utils.map("nv", 'D', '"_D')
utils.map("nv", 'c', '"_c')
utils.map("nv", 'C', '"_C')
utils.map("nv", 'x', '"_x')
utils.map("nv", 'X', '"_X')
utils.map("nv", 's', '"_s')
utils.map("nv", 'S', '"_S')
utils.map("nv", '<leader>d', 'd') -- Keep a cut
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
-- Remove Search Highlighting after pressing escape
utils.map("n","<esc>",":noh<cr><esc>")
-- Reload Neovim
utils.map("n", "<leader><leader>r", ":source $MYVIMRC<CR>")

-- opt.relativenumber = true
opt.signcolumn = 'number'

-- Light/Dark Mode switcher
function SetColorScheme()
    if string.match(vim.g.colors_name, 'flexoki') then
        -- Reset all colors to their default values
        cmd("highlight clear")
        cmd("syntax reset")
        cmd("colorscheme default")
        vim.cmd('colorscheme gruvbox')
        vim.o.background = 'light'
    else
        -- Reset all colors to their default values
        cmd("highlight clear")
        cmd("syntax reset")
        cmd("colorscheme default")
        vim.o.background = 'dark'
        vim.cmd('colorscheme flexoki-dark')
    end
end


cmd("colorscheme flexoki-dark")
vim.o.background = 'dark'
opt.errorbells = false -- This removes s default error bell, turning it off so that it doesn't annoy us
opt.textwidth = 0
opt.wrapmargin = 0
opt.conceallevel = 0
opt.smartindent = true
opt.linebreak = true
opt.number = true
opt.showmatch = true
-- opt.showbreak = '+++'
opt.wildmode = 'longest,list,full'
opt.termguicolors = true
opt.clipboard = 'unnamedplus'
opt.ignorecase = true
opt.smartcase = true
opt.swapfile = false
opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'
opt.undofile = true
opt.incsearch = true
opt.spell = true
opt.spellsuggest = opt.spellsuggest + { '15' } -- This prevents spelling suggestions taking up the entire screen
opt.showmatch = true
opt.confirm = true
opt.ruler = true
opt.autochdir = true
opt.autowriteall = true
opt.undolevels = 1000
opt.undofile = true
cmd("set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/")
opt.backspace = { 'indent', 'eol', 'start' }

-- The next two settings ensure that line breaks and wrap work how writers, not coders, prefer it
opt.wrap = true
utils.map("n", "<F5>", ":set linebreak<CR>")
utils.map("n", "<C-F5>", ":set nolinebreak<CR>")

-- Set tab to be two spaces
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

-- Quick Insert Mode Spelling Remap (CTRL + S) to fix mistake
utils.map("n", "<C-s>", "z=1<CR><CR>")  -- Had to put an extra <CR> b/c of an "Press enter to contiue prompt"

-- Map [s and ]s to z as well
utils.map("n", "[z", "[s")
utils.map("n", "]z", "]s")

-- Un-highlight searched word after pressisng escape
utils.map("n", "<esc>", ":noh<cr><esc>")

-- Open Undo
utils.map("n", "<esc>", ":noh<cr><esc>")

-- Map zs to find synonyms of the current word
utils.map("n", "zs", "<cmd>Telescope thesaurus lookup<CR>")

utils.map("nv", "<leader>u", ":UndotreeToggle<CR>")
utils.map("nv", "<leader>G", ":ZenMode<CR>")
utils.map("nv", "<leader>P", ":TogglePencil <bar> <CR>")
utils.map("nv", "<leader>S", ":lua SetColorScheme()<CR>")
