" Identity: This file has no dependencies.
"

" BORING
" if .vimrc file exists then nocompatible is already on, do nothing
" if you start this .vimrc file with -u and no system-wide .vimrc file exists
" then we have to turn nocompatible mode explicitly on.
if &compatible        
    set nocompatible  " enables all the cool features of the modern vim.
                      "   Note: compatible mode behaves like the old vi
endif


" ESSENTIAL SETTINGS YOU MIGHT WANT TO REMEMBER
" essential for vertical movement
set number                      " show absolute line number at current position

set relativenumber              " show relative line numbers everywhere else


" FURTHER SETTINGS YOU DON'T HAVE TO REMEMBER 
filetype plugin indent off      " detect filetypes and custom plugin and indent
                                "   files

syntax on                       " enable syntax highlighting

set encoding=utf-8      " The encoding displayed.

set fileencoding=utf-8  " The encoding written to file.

set backspace=indent,eol,start  " in case I want backspace to also delete
                                "   newline and so on
set colorcolumn=80              " show red line at column 80

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " set tab size to
                                                            "   4 spaces
set ttimeoutlen=0               " remove waiting for special keys after 
                                "   hitting <ESC>

set autochdir                   " automatically change in the directory of
                                " the current file

" HOTKEYS
let mapleader = ","             " set leader key, for hotkeys starting with it

" noremap y z
" noremap z y
" noremap! y z
" noremap! z y
                                " US layout uses QWERTY and therefore shortcuts
                                "   are optimzed for it. On QWERTZ you want
                                "   at a minimum switch Y and Z key.
                                " yy does not work at the moment

noremap <space> :
                                " ergonomic reason (press one key instead of
                                "   two without moving the hand)

inoremap jj <ESC>
                                " ergonomic reason (makes me using <ESC> less 
                                "   often)

noremap ,o o <ESC>
                                " sometimes I just want a new line without
                                "   leaving the normal mode

map ,cd :cd %:p:h <CR>
                                " cd into the directory of the current file

map ,e :tabnew :e <C-R>=expand("%:p:h") . "/" <CR>
                                            " open other file (replacing
                                            "   current)

map ,s :sp <C-R>=expand("%:p:h") . "/" <CR>
                                            " open other file in split window

map ,m :make<CR>
                                " call make

map ,f /
                                " alternative of pressing / which is quite far
                                "   to reach on my keyboard.

noremap ,p "+p
                                " paste more quickly from system clipboard
noremap ,P "+P
                                " paste more quickly from system clipboard

xnoremap ,y "+y
                                " yank to system clipboard (only in selection
                                "   mode)

" EXPERIMENTAL HOTKEYS IF YOU LIKE
" cmap ü <c-r>+                 
"                               " paste alternative to system-wide pasting
" tmap ü <c-w>"+                
"                               " paste in terminal mode
" tmap ö <c-w>N                 
"                               " switch easier from terminal to normal mode
" noremap ,j 10jzt
                                " move down more quickly



" TMUX INTERACTION
" source: https://gist.github.com/mislav/5189704
" tmux + vim switch between panes with C-hjkl without dependencies
function! TmuxMove(direction)
        let wnr = winnr()
        silent! execute 'wincmd ' . a:direction
        " If the winnr is still the same after we moved, it is the last pane
        if wnr == winnr()
                call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
        end
endfunction

nnoremap <silent> <c-h> :call TmuxMove('h')<cr>
nnoremap <silent> <c-j> :call TmuxMove('j')<cr>
nnoremap <silent> <c-k> :call TmuxMove('k')<cr>
nnoremap <silent> <c-l> :call TmuxMove('l')<cr>


" NETRW config (its a built-in plugin)
let g:netrw_banner=0         " disable the top banner ???
let g:netrw_browse_split=4   " ???
let g:netrw_altv=1           " open splits to the right
let g:netrw_liststyle=3      " tree view
" let g:netrw_winsize=25       " minimum 25 size?
let g:netrw_preview=1        " split preview to the right (pressing enter)



" Zotero integration
" source: https://retorque.re/zotero-better-bibtex/citing/cayw/
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'citep' : 'pandoc'
  let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

" Source: https://stackoverflow.com/questions/61766814/close-netrw-explorer-after-opening-a-new-file
" Close after opening a file (which gets opened in another window):
let g:netrw_fastbrowse = 0
autocmd FileType netrw setl bufhidden=wipe
function! CloseNetrw() abort
  for bufn in range(1, bufnr('$'))
    if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
      silent! execute 'bwipeout ' . bufn
      if getline(2) =~# '^" Netrw '
        silent! bwipeout
      endif
      return
    endif
  endfor
endfunction
augroup closeOnOpen
  autocmd!
  autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
aug END
