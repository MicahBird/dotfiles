call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'jdhao/better-escape.vim'
call plug#end()

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"" Set options
set smartcase
set noerrorbells
set number
set wrap

"" Set mouse
set mouse=a

" Map yW to yank rest of line
nnoremap yW y$

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Don't save delete, change to black hole register
nnoremap d "_d
vnoremap d "_d
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c
vnoremap C "_C

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Better command line completion 
set wildmode=longest,list,full
