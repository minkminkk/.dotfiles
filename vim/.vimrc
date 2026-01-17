" Set compatibility to vim-only (no vi)
set nocompatible


" Basic settings
syntax on
set number relativenumber
set ruler
set smartcase
set incsearch
set ai  " auto indent
set shiftwidth=4
set tabstop=4
set laststatus=2
set encoding=utf-8
set so=14
set history=500


" Autoread the file when file is changed from outside
set autoread
au FocusGained,BufEnter * silent! checktime


" Set shortcuts for move a line up/down
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
 	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif


" Util functions
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction











