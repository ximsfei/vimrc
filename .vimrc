"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
syntax enable
syntax on
set cul             " Highlight the screen line of the cursor with CursorLine
"set cuc             " Highlight the screen column of the cursor with CursorColumn
set magic
set shortmess=atI
autocmd InsertEnter * se cul    "starting Insert mode
set ruler           " Show the line and column number of the cursor position, separated by a comma.
set showcmd
"set whichwrap+=<,>,h,l     " Allow specified keys that move the cursor left/right to move to the
" previous/next line when the cursor is on the first/last character in the line.
set scrolloff=3     " Minimal number of screen lines to keep above and below the cursor.
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set laststatus=2

set autoindent
set cindent
set smartindent

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

set number
set relativenumber
set history=1000

set hlsearch
set incsearch

set showmatch
set matchtime=1

set nows                    " nowrapscan
set noeb                    " noerrorbells
set novb                    " novisualbell
set nobackup
set noswapfile

set langmenu=zh_CN.UTF-8
set helplang=cn

set cmdheight=2
set completeopt=preview,menu

"set foldenable
"set foldcolumn=0
"set foldmethod=indent
"set foldlevel=3
"set foldopen-=search        " don't open folds when you search into them
"set foldopen-=undo          " don't open folds when you undo stuff
"set foldclose=all
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set confirm
set ignorecase smartcase

set linespace=0
set wildmenu
set backspace=2

"set mouse=a
set selection=exclusive
"set selectmode=mouse,key

set report=0
set fillchars=vert:\ ,stl:\ ,stlnc:\

":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
endif

set autowrite
set autoread
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

filetype on
filetype plugin on
filetype indent on

set viminfo+=!      " Remember a lot of information when you exit vim and later start it again

set iskeyword+=_,$,@,%,#,-

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" new file title
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
func SetTitle()
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "	> File Name: ".expand("%"))
        call append(line(".")+1, "	> Author: ")
        call append(line(".")+2, "	> Mail: ")
        call append(line(".")+3, "	> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc
autocmd BufNewFile * normal G


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keyboard commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap tt :%s/\t/    /g<CR>   " Replace tab to spaces

"map <C-w>w <ESC>:mksession! ~/workspace.session<CR>
"            \:wviminfo ~/workspace.viminfo<CR>
"map <C-w>r <ESC>:source ~/workspace.session<CR>
"            \:rviminfo ~/workspace.viminfo<CR>

" Buffers
nnoremap bn :bnext<CR>
nnoremap bp :bprevious<CR>
nnoremap bd :bdelete<CR>
nnoremap bl :buffers<CR>
" Tab
map tn :tabnext<CR>
map tp :tabprevious<CR>
map td :tabnew .<CR>
map te :tabedit
map tc :tabclose<CR>

noremap <C-k> :vimgrep /<C-R>=expand("<cword>")<CR>/j %<CR> \| :copen<CR>

map! <C-Z> <Esc>zzi
vmap <C-c> "+y
imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$

map <F2> :Tlist<CR>
imap <F2> <ESC> :Tlist<CR>
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>

"map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
        "        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc


map <F6> :call FormartSrc()<CR><CR>

func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""""
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Sort_Type = "name"
let Tlist_Show_One_File = 1
let Tlist_Compart_Format = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 0

"set tags=tags
"set autochdir

"""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
autocmd vimenter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeWinPos = 'right'

set termencoding=utf-8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

"-----------------------------------------------------------------
" plugin - lookupfile.vim
"-----------------------------------------------------------------
if filereadable("filenametags")
    let g:LookupFile_TagExpr = string('filenametags')
endif
map <C-l> :LookupFile<CR>
"map <C-l>b :LUBufs<CR>
"map <C-l>o :LUTags<CR>

au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType java setlocal dict+=~/.vim/dict/java.dict
au FileType vim setlocal dict+=~/.vim/dict/vim.dict
