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
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
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
set showmatch 
set confirm 
set ruler 
set autochdir 
set autowriteall 
set undolevels=1000
set backspace=indent,eol,start 

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

" This section are nice-to-haves for easier integration with machine, using vim-airline and such. 

Plug 'vim-airline/vim-airline'

"This section deals with workspace and session management 

Plug 'thaerkh/vim-workspace'

"Related to above, the following code saves all session files in a single directory outside your
"workspace

let g:workspace_session_directory = $HOME . '/.vim/sessions/'

"Related to above, this is a activity tracker for vim

" Plug 'wakatime/vim-wakatime'

" A disturbance in the force: we are using some emacs functionality here, org-mode specifically 
" Plug 'jceb/vim-orgmode'

"  This is for language-specific plugins 

Plug 'plasticboy/vim-markdown' 

" Load global configs
source ~/.config/nvim/global.vim

 call plug#end()
" Custom Configs
nnoremap <silent> <esc> :noh<cr><esc>

set mouse=a

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
                            \ | call lexical#init()
                            \ | call litecorrect#init()
                            " \ | call textobj#quote#init()
                            " \ | call textobj#sentence#init()
augroup END

let g:tq_enabled_backends=["openoffice_en", "mthesaur_txt", "datamuse_com"]
let g:tq_openoffice_en_file="/usr/share/mythes/th_en_US_v2"
let g:tq_mthesaur_file="~/.config/nvim/thesaurus/mthesaur.txt"

let user_dict = {
  \ 'maybe': ['mabye'],
  \ 'medieval': ['medival', 'mediaeval', 'medevil'],
  \ 'then': ['hten'],
  \ 'quote': ['qoute'],
  \ 'Quote': ['Qoute'],
  \ 'because': ['becuase', 'becase', 'becasue', 'beucase'],
  \ }

let g:lexical#spell_key = '<leader>s'
let g:lexical#spelllang = ['en_us']

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
