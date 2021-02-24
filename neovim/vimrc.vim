" nvim configuration

" abbreviations {{{

abbr waht what
abbr tehn then
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter
abbr cosnt const
abbr attribtue attribute
abbr attribuet attribute

" }}}

" settings {{{

set encoding=utf-8
scriptencoding utf-8

" define leader
let mapleader = ','

" disable netrw
" let loaded_netrwPlugin=1

syntax on
filetype plugin indent on

" clipboard
if has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard+=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" backup
set backupcopy=yes         " enable safe writes

" functionality
set autoread                   " auto read files that have changed outside of vim "
set autowrite                  " auto write buffer when switching files "
set backspace=indent,eol,start " OSX stupid backspace fix "
set browsedir=last             " open last directory"
set diffopt+=vertical          " show diff vertically"
set hidden                     " disable warning of hidden buffers "
set history=10000              " show history
set mouse=a                    " enable mouse mode "
set path+=**                   " enable recursive dir paths "
set shell=$SHELL               " use os shell "
set shortmess+=aFc             " don't pass messages to |ins-completion-menu| "
set ttyfast                    " faster redrawing "

" display
set background=dark            " vim background color "
set foldcolumn=2               " display sidebar for folds "
set linebreak                  " avoid wrapping a line in the middle of a word "
set list                       " show invisibles
" set listchars=tab:→→,eol:¬,space:.,trail:.,extends:#,nbsp:.
set listchars=tab:→→,trail:.,extends:#,nbsp:.
set matchtime=1                " When typing a closing bracket, briefly flash the one it matches "
set number relativenumber      " show hybrid line numbers "
set noshowmode                 " don't show mode "
set ruler                      " enable column and line numbers "
" set showbreak=↪                " show break char "
set showcmd                    " show imcomplete commands "
set showmatch                  " highlight matching [{()}] "
set signcolumn=auto            " show sign column "
set splitbelow                 " split below by default "
set splitright                 " split right by default "
" set textwidth=80
set title                      " set title of window to file "
set virtualedit=all            " virtual cursor movements. options: block, insert or all "
set wildmenu                   " wild menu "

" scroll
set scrolloff=15                " screenlines to keep above and below the cursor "
set sidescrolloff=15            " col to keep to the left and right of the cursor "

" tab control
set autoindent                 " auto indent on new lines set autoread "
set expandtab                  " tabs are spaces "
set shiftround                 " round indentation when shifting lines "
set shiftwidth=4               " shift size after rounding "
set smartindent                " smarter than indent "
set smarttab                   " smart tabbing "
set softtabstop=4              " number of spaces in tab when editing "
set tabstop=4                  " default tab space "

" folding
set foldlevel=0                " default fold level "
set foldlevelstart=0           " start with folding at level 0 "
set foldmethod=syntax          " marker, indent, syntax "
set foldnestmax=2              " deepest fold is 10 levels "
set modelines=1                " check end of file for folding instructions "
set nofoldenable               " no fold by default (foldenable) "

" status
set cmdheight=1                " better display for message "
set laststatus=2               " always display the status bar "

" backup, swap, spelling
" set nobackup                   " don't create backup files "
" set nospell                    " disable spelling highlights "
" set noswapfile                 " no swap files "
set nowritebackup              " delete backup after write "

" search
set gdefault                   " default global search"
set hlsearch                   " highlight search results "
set ignorecase                 " case insensitive searching "
set incsearch                  " set incremental search, like modern browsers "
set magic                      " set magic on, for regex "
set lazyredraw                 " don't redraw while executing macros, option: nolazyredraw "
set smartcase                  " case-sensitive if expression contains a capital letter "

" ignore files
set wildignore+=*.class
set wildignore+=*.pyc
set wildignore+=*.swp
set wildignore+=.DS_Store

" ignore directories
set wildignore+=**/.git/**
set wildignore+=**/bower_components/**
set wildignore+=**/node_modules/**

" nvim options
if (has('nvim'))
    " show results of substition without a split
    set inccommand=nosplit
    set fillchars=vert:\|,fold:-

endif

if has('macunix') " options: unix, win32, win32unix

    " prevent mac terminal flash issue
    set noerrorbells
    set visualbell
    set t_vb=
    set timeoutlen=500

endif

" enable 24 bit color support if supported
if (has('termguicolors'))
    if (!(has('nvim')))
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    set termguicolors
endif

" terminal cursor mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" }}}

" plugins {{{

" automatically install vim-plug and run PlugInstall if vim-plug not found
" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" color schemes
Plug 'https://github.com/ayu-theme/ayu-vim'
Plug 'https://github.com/chriskempson/base16-vim'
Plug 'https://github.com/dracula/vim', { 'as': 'dracula' }
Plug 'https://github.com/drewtempelmeyer/palenight.vim'
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/larsbs/vimterial_dark'
Plug 'https://github.com/mhartington/oceanic-next'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/rakr/vim-one'

" fzf {{{

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - Popup window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - down / up / left / right
" let g:fzf_layout = { 'down': '40%' }

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

if has('nvim-0.4.0') || has("patch-8.2.0191")
    let g:fzf_layout = { 'window': {
                \ 'width': 0.9,
                \ 'height': 0.7,
                \ 'highlight': 'Comment',
                \ 'rounded': v:false } }
else
    let g:fzf_layout = { "window": "silent botright 16split enew" }
endif


" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
            \ {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" normal mode mappings
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>f. :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>ll :Lines<CR>
nnoremap <silent> <Leader>lb :BLines<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>; :Commands<CR>
nnoremap <silent> <Leader>ht :Helptags<CR>
nnoremap <silent> <Leader>] :Tags<CR>
nnoremap <silent> <Leader>b] :BTags<CR>

" git mappings
let g:fzf_commits_log_options = '--graph --color=always
            \ --format="%C(yellow)%h%C(red)%d%C(reset)
            \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
nnoremap <silent> <Leader>gg :GFiles?<CR>
nnoremap <silent> <Leader>gc  :Commits<CR>
nnoremap <silent> <Leader>gb :BCommits<CR>

" rust grep
nnoremap <Leader>rg :Rg<Space>
nnoremap <Leader>RG :Rg!<Space>

" recently used files
nnoremap <silent> <Leader>fm :FZFMru<CR>

" marks
nnoremap <silent> <Leader>mm :Marks<CR>
nnoremap <silent> <Leader>mp :Maps<CR>
nnoremap <silent> <Leader>ms :Snippets<CR>

" }}}

" startify {{{

Plug 'https://github.com/mhinz/vim-startify'

" augroup group-startify
"     autocmd!
"     " show startify after last buffer close
"     au BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif
" augroup END

" }}}

" lightline {{{

Plug 'https://github.com/itchyny/lightline.vim'

" schemes: wombat, onedark, palenight
let g:lightline = {
            \ 'colorscheme': 'palenight',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead',
            \   'readonly': 'LightLineReadOnly',
            \ },
            \ }

function! LightlineReadonly()
    return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" }}}

" git {{{

Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'

" }}}

" polyglot {{{

Plug 'https://github.com/sheerun/vim-polyglot'

" }}}

" commentary {{{

Plug 'https://github.com/tpope/vim-commentary'

" }}}

call plug#end()

" }}}

" auto commands {{{

augroup configgroup
    au!

    " workaround some broken plugins which set guicursor indiscriminately"
    au OptionSet guicursor noautocmd set guicursor=

    au VimEnter * highlight clear SignColumn

    " automatically install missing plugins on startup
    au VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugUpdate --sync | q
                \| endif

    au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable

    " quit readonly files with q instead of :q
    au FileType help noremap <buffer> q :bd<cr>

    " todo: add comment for this command
    au BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                \ exe "normal! g`\"" |
                \ endif

    " trim whitespace on save
    au BufWritePre * :%s/\s\+$//e

    " enter insert mode any time focus is put on a terminal
    au BufWinEnter,WinEnter term://* startinsert

    " remove cursor line on insert
    au InsertEnter,InsertLeave * set cul!

    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    au FileType fzf tnoremap <buffer> <Esc> <Esc>

augroup END

" }}}

" mappings {{{

" disabled keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" disable, remap esc
inoremap <esc> <nop>
inoremap jk <esc>
inoremap kj <esc>
vnoremap jk <esc>
vnoremap kj <esc>
cnoremap jk <esc>
cnoremap kj <esc>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

" remap command toggle
nnoremap ; :
nnoremap : ;

" remap movement keys
" nnoremap e <S-e>
" nnoremap w <S-w>
" nnoremap b <S-b>
" nnoremap <S-e> e
" nnoremap <S-w> w
" nnoremap <S-b> b

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" use qq to record, q to stop, Q to play a macro
nnoremap Q @q
vnoremap Q :normal @q

" scroll the viewport faster
nnoremap <silent> <C-e> 3<C-e>
nnoremap <silent> <C-y> 3<C-y>

" enable . command in visual mode
vnoremap . :normal .<cr>

" keep visual selection when indenting/outdenting
vmap <silent> < <gv
vmap <silent> > >gv

" highlight last inserted text
nnoremap <silent> gV `[v`]

" folding
nnoremap <Space> za
vnoremap <Space> za

" edit, source vim file
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" move to window
map <silent> <C-h> <C-w>h
map <silent> <C-j> <C-w>j
map <silent> <C-k> <C-w>k
map <silent> <C-l> <C-w>l

" use arrows to resize windows
map <right> <c-w><
map <left>  <c-w>>
map <up>    <c-w>+
map <down>  <c-w>-

" remap exit
tnoremap <silent> <Esc> <C-\><C-n>

" save with sudo
cmap w!! w !sudo tee %

" netrw
nnoremap <silent><leader>x :Explore<CR>

" format
nnoremap <silent><leader>w f gg=G<CR>

" noh
nnoremap <silent><leader><space> :noh<CR>
" }}}

" color schemes {{{

let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
let g:palenight_terminal_italics=1
let ayucolor="mirage" " options: light, mirage, dark

" colorscheme OceanicNext
" colorscheme ayu
" colorscheme dracula
" colorscheme gruvbox
" colorscheme one
" colorscheme onedark
" colorscheme onedark
" colorscheme vimterial_dark
colorscheme palenight

" }}}
