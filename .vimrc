set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" Miscellaneous auto-load Vim scripts
" Necessary for vim-session
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
:let g:session_autoload = 'no'
:let g:session_autosave = 'yes'

" File explorer
Plugin 'scrooloose/nerdtree'
" Allow searching
Plugin 'MarSoft/nerdtree-grep-plugin'

Plugin 'vim-airline/vim-airline'
" Display buffers as tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='distinguished'

" Markdown syntax hilighting
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Clang format
" Plugin 'rhysd/vim-clang-format'
" C-Support
" Plugin 'WolfgangMehner/c-support'

" Undotree visualizer
Plugin 'mbbill/undotree'

" Bazel integration
Plugin 'lakshayg/vim-bazel'

Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>

" PageUp and PageDown complete commands from history
cnoremap <PageUp> <Up>
cnoremap <PageDown> <Down>
" Up and Down browse through command history
cnoremap <Up> <PageUp>
cnoremap <Down> <PageDown>

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

" Switch buffers with Ctrl-j and Ctrl-k
:nnoremap <C-k> :bnext<CR>
:nnoremap <C-j> :bprevious<CR>

" Move through quickfix items with Ctrl-h and Ctrl-l
:nnoremap <C-h> :cnext<CR>
:nnoremap <C-l> :cprevious<CR>

" Toggle line numbers
:nnoremap <leader>l :set invnumber<CR>

" Toggle search result highlighting
:nnoremap <leader>h :set hls!<CR>

" Close buffer
fun! CloseBuffer()
    if win_getid() == 1000
        bp
        bd #
    else
        bd
    endif
endfunction
" :nnoremap <leader>q :bd<CR>  " Messes up NerdTree
" :nnoremap <leader>q :bp<cr>:bd #<cr> " Closes buffer but leaves window
:nnoremap <leader>q :call CloseBuffer()<CR>

" Open NERDTree with Ctrl-n
nnoremap <C-n> :NERDTree<CR>
" Open current file with \nf
nnoremap <leader>nf :NERDTreeFind<CR>

" Allow to switch unsaved buffers
set hidden

" Indent by 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" Show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Use Clang-Format on save
function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/vim/addons/syntax/clang-format-14.py
  echo "EHEJ"
endfunction
autocmd BufWritePre *.h,*.hpp,*.cc,*.cpp call Formatonsave()

" (Doesn't work)
" Reload all buffers on <leader>-l
" fun! RefreshAllBuffers()
"     set autoread
"     checktime
"     set noautoread
" endfun
" nnoremap <C-l> :call RefreshAllBuffers()<CR>

" Open new scratch (temporary) buffer on :scratch or <C-t>
fun! OpenScratchBuffer()
    enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfun
nnoremap <C-t> :call OpenScratchBuffer()<CR>

" Open Undotree visualizer
:nnoremap <leader>u :UndotreeToggle<CR>

" Set folds to follow syntax and default to open folds
:set foldmethod=syntax
:set nofoldenable
