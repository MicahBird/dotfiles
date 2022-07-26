"" Global plugins
Plug 'jdhao/better-escape.vim'

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

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Map P to paste on new line
nnoremap P :pu<CR>
" Don't save delete, change to register
nnoremap d "_d
vnoremap d "_d
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c
vnoremap C "_C
