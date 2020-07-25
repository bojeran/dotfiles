set nocompatible
set encoding=utf-8
filetype off

filetype plugin indent on

" set leader key
let mapleader = ","
" in case I want backspace to also delete newline and so on
set backspace=indent,eol,start
" show useful column width
set colorcolumn=80


noremap <space> :
inoremap jj <ESC>
noremap ,o o <ESC>

map ,cd :cd %:p:h <CR>
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,s :sp <C-R>=expand("%:p:h") . "/" <CR>
map ,m :make<CR>
map ,f /
" Move between windows more comfortable (also in terminal mode)
map ,j <c-w>j<c-w><CR>
tmap ,j <c-w>j<c-w><CR>
map ,k <c-w>k<c-w><CR>
tmap ,k <c-w>k<c-w><CR>
map ,h <c-w>h<c-w><CR>
tmap ,h <c-w>h<c-w><CR>
map ,l <c-w>l<c-w><CR>
tmap ,l <c-w>l<c-w><CR>
" Most easiest switching between two windows
map ,w <c-w>w<c-w><CR>
tmap ,w <c-w>w<c-w><CR>

" tmap ,gt <c-w>


" didn't use + before therefore i use it to quickly paste
" map + "+p
noremap ,p "+p
xnoremap ,y "+y
" map ü "+p
" lmap -> Insert, Command-Line, Lang-Args
" cmap -> Command-Line
cmap ü <c-r>+
tmap ü <c-w>"+
" switch easier to normal mode
tmap ö <c-w>N


" Some basic changes
" set tab size to 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab


