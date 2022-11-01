"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
 if has('win32')&&!has('win64')
   let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
 else
   let curl_exists=expand('curl')
 endif

" let g:vim_bootstrap_langs = "html,javascript,python"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim
" let g:vim_bootstrap_theme = "codedark"
" let g:vim_bootstrap_frams = ""

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

syntax on

set noerrorbells "This removes vim's default error bell, turning it off so that it doesn't annoy us 
set textwidth=0 
set wrapmargin=0
set smartindent 
set linebreak 
set number
set showmatch 
" set showbreak=+++
set smartcase
set noswapfile 
set undodir=~/.vim/undodir
set undofile
set incsearch 
set spell 
set spellsuggest+=15 " This prevents spelling suggestions taking up the entire screen
set showmatch 
set confirm 
set ruler 
set autochdir 
set autowriteall 
set undolevels=1000
set backspace=indent,eol,start 

" Set tab to be two spaces
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

" The next two settings ensure that line breaks and wrap work how writers, not
" coders, prefer it

set wrap
nnoremap <F5> :set linebreak<CR>
nnoremap <C-F5> :set nolinebreak<CR>

"   This is for color themes

Plug 'colepeters/spacemacs-theme.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'gruvbox-community/gruvbox'
   
"   This is a selection of plugins to make prose writing easier. 

Plug 'dpelle/vim-LanguageTool' 
Plug 'ron89/thesaurus_query.vim' 
Plug 'junegunn/goyo.vim' 
Plug 'junegunn/limelight.vim' 
Plug 'reedes/vim-pencil' 
Plug 'reedes/vim-wordy'
Plug 'preservim/vim-lexical'
Plug 'preservim/vim-litecorrect'
Plug '907th/vim-auto-save' "auto saves files as you edit

"  This is for language-specific plugins 
Plug 'plasticboy/vim-markdown' 

"  Plugin for markdown tables
Plug 'dhruvasagar/vim-table-mode' 

"This section deals with workspace and session management 

Plug 'thaerkh/vim-workspace'

" Languagetool Jar Location
let g:languagetool_jar='$HOME/Documents/Programs/LanguageTool/languagetool-commandline.jar'

"Related to above, the following code saves all session files in a single directory outside your
"workspace

let g:workspace_session_directory = $HOME . '/.vim/sessions/'

" Set autosave variables
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave"]


" Load global configs
source ~/.config/nvim/global.vim

 call plug#end()
" Custom Configs
nnoremap <silent> <esc> :noh<cr><esc>

" Markdown Plugin Settings
let g:vim_markdown_autowrite = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

" Markdown auto format tables
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a


let g:pencil#wrapModeDefault = 'soft'

" Autostart Scripts
augroup pencil
  autocmd!
  autocmd VimEnter * call pencil#init({'wrap': 'soft'})
                            \ | call lexical#init()
                            \ | call litecorrect#init()
  autocmd FileType * call pencil#init({'wrap': 'soft'})
                            \ | call lexical#init()
                            \ | call litecorrect#init()
                            " \ | call textobj#quote#init()
                            " \ | call textobj#sentence#init()
augroup END

" Thesaurus sources
let g:tq_enabled_backends=["openoffice_en", "mthesaur_txt", "datamuse_com"]
let g:tq_openoffice_en_file="/usr/share/mythes/th_en_US_v2"
let g:tq_mthesaur_file="~/.config/nvim/thesaurus/mthesaur.txt"

"*****************************************************************************
"" Spelling Corrections
"*****************************************************************************
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

let g:lexical#spell_key = '<leader>s'
let g:lexical#spelllang = ['en_us']
"
" Quick Insert Mode Spelling Remap 
" nnoremap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u 
nnoremap <c-s> z=1<CR> 

"" Custom Mappings
" Reload config
nnoremap <leader>sv :source ~/.config/nvim/winit.vim<CR>

" Map [s and ]s to z as well
nnoremap [z [s
nnoremap ]z ]s

" Map zs to find synonyms of the current word
nnoremap zs :ThesaurusQueryReplaceCurrentWord<CR>

" Map F8 to switch to light theme
map <F8> :call SetColorScheme() <bar> <CR>

map <F9> :Goyo <bar> <CR>

map <F10> :TogglePencil <bar> <CR>

colorscheme pacific 

" Add toggle for colorscheme (incomplete)
function! SetColorScheme()
    if g:colors_name == 'pacific'
        colorscheme gruvbox 
        set background=light
    else
        set background=dark
        colorscheme pacific 
    endif
endfunction

set background=dark 

if executable('rg')
    let g:rg_derive_root='true' 
endif

" Make searches case insensitive
set ignorecase
set smartcase

" Custom Variables
" Don't conceal markdown syntax
set conceallevel=0

" No auto wrapping
let g:pencil#textwidth = 0
set textwidth=0 
set wrapmargin=0
