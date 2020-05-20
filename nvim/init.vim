" vim/nvim configuration

" define leader
let mapleader=","

" settings {{{

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
set dir=~/.cache/vim "swap directory"
set backupdir=~/.cache/vim "backup directory"

" appearance
set autoread "auto read files that have changed outside of vim"
set autowrite "auto write buffer on certain conditions"
set backspace=indent,eol,start " OSX stupid backspace fix
set bsdir=last "open last directory"
set cursorline " enable cursor line "
set diffopt+=vertical "show diff vertically"
set encoding=utf-8 " use an encoding that supports unicode
set hidden " disable warning of hidden buffers
set history=1000
set linebreak "avoid wrapping a line in the middle of a word
set list
set listchars=tab:--,trail:.,extends:#,nbsp:.
set matchtime=1 " When typing a closing bracket, briefly flash the one it matches
set modelines=1 "check end of file for folding instructions"
set mouse=a "enable mouse mode
set number relativenumber " show hybrid line numbers
set ruler "enable column and line numbers"
set scrolloff=10 "screenlines to keep above and below the cursor
set shell=$SHELL "shell
set shortmess=acI "reduce press enter warning"
set showbreak=↪ "show break char"
set showcmd "show imcomplete commands
set showmatch " highlight matching [{()}]
set sidescrolloff=5 "col to keep to the left and right of the cursor
set signcolumn=auto "show sign column
set splitbelow " split below by default"
set splitright " split right by default "
set title "set title of window to file
set ttyfast "faster redrawing
set updatetime=300 "bad experience for diagnostic messages when it's default 4000
set virtualedit=block "virtual cursor movements. options: block, insert or all"
set wildmenu "wild menu
set wildmode=list:longest,full "show list of completions, complete then iterate full
set winbl=10 " set floating window to be slightly transparent

" tab control
set expandtab "tabs are spaces
set autoindent "auto indent on new lines set autoread
set shiftround "round indentation when shifting lines
set smartindent "smarter than indent.
set smarttab "smart tabbing
set tabstop=4 "default tab space
set softtabstop=4 "number of spaces in tab when editing
set shiftwidth=4 "shift size after rounding

" folding
set foldlevel=0
set foldlevelstart=0
set foldmethod=syntax "marker, indent, syntax"
set foldnestmax=2 "deepest fold is 10 levels
set nofoldenable "no fold by default (foldenable)"

" status
set cmdheight=1 "better display for message
set laststatus=2 "always display the status bar

" backup, swap, spelling
set nobackup "don't create backup files
set nospell "disable spelling highlights
set noswapfile "no swap files
set nowritebackup "delete backup after write

" search
set hlsearch "highlight search results
set ignorecase "case insensitive searching
set gdefault "default global search"
set magic "set magic on, for regex
set incsearch "set incremental search, like modern browsers
set nolazyredraw "don't redraw while executing macros
set smartcase "case-sensitive if expression contains a capital letter

" ignore files
set wildignore+=*.swp
set wildignore+=.DS_Store
set wildignore+=*.pyc
set wildignore+=*.class

" ignore directories
set wildignore+=*/.git/*
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*

" nvim options
if (has('nvim'))

    " show results of substition as they're happening
    " but don't open a split
    set inccommand=nosplit

    " better terminal colors
    " https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
    let g:terminal_color_0 = '#4e4e4e'
    let g:terminal_color_1 = '#d68787'
    let g:terminal_color_2 = '#5f865f'
    let g:terminal_color_3 = '#d8af5f'
    let g:terminal_color_4 = '#85add4'
    let g:terminal_color_5 = '#d7afaf'
    let g:terminal_color_6 = '#87afaf'
    let g:terminal_color_7 = '#d0d0d0'
    let g:terminal_color_8 = '#626262'
    let g:terminal_color_9 = '#d75f87'
    let g:terminal_color_10 = '#87af87'
    let g:terminal_color_11 = '#ffd787'
    let g:terminal_color_12 = '#add4fb'
    let g:terminal_color_13 = '#ffafaf'
    let g:terminal_color_14 = '#87d7d7'
    let g:terminal_color_15 = '#e4e4e4'

    set fillchars=vert:\|,fold:-
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                \ exe "normal! g`\"" |
                \ endif

    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

endif

if has('macunix') " options: unix, win32, win32unix

    " prevent mac terminal flash issue
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500

endif

" enable 24 bit color support if supported
if (has("termguicolors"))
    if (!(has("nvim")))
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    set termguicolors
endif

" }}}

" plugins {{{

" automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" dev icons
Plug 'https://github.com/ryanoasis/vim-devicons'

" color schemes
Plug 'https://github.com/chriskempson/base16-vim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/dracula/vim', { 'as': 'dracula' }
Plug 'https://github.com/larsbs/vimterial_dark'
Plug 'https://github.com/ayu-theme/ayu-vim'

" plugins
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/mhinz/vim-startify'

" language support
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/mattn/emmet-vim'
" Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'https://github.com/posva/vim-vue'

" netrw {{{

let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Show line numbers in netrw/directory browser/explorer
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" }}}

" easymotion {{{

" Plug 'https://github.com/easymotion/vim-easymotion'

" " <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" " s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)

" " Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)

" " Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)

" }}}

" lightline {{{

Plug 'https://github.com/itchyny/lightline.vim'

let g:lightline = {
            \ 'colorscheme': 'wombat',
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

" fzf {{{

" Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'https://github.com/junegunn/fzf.vim'

" " hide statusline
" " autocmd! FileType fzf set laststatus=0 noshowmode noruler
" "   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" " FZF key bindings
" nnoremap <C-p> :Files<CR>
" " nnoremap <C-b> :Buffers<CR>
" nnoremap <C-f> :FZF<CR>
" let g:fzf_action = {
"             \ 'ctrl-t': 'tab split',
"             \ 'ctrl-h': 'split',
"             \ 'ctrl-v': 'vsplit' }

" }}}

" leaderf {{{

Plug 'https://github.com/Yggdroot/LeaderF', { 'do': './install.sh' }

let g:Lf_ShowDevIcons = 1

 " popup mode
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1
" let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
" let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

" }}}

" git {{{

Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'

" git commit browser
Plug 'https://github.com/junegunn/gv.vim'

" Commands
" --------
" :GV to open commit browser
"
" You can pass git log options to the command, e.g. :GV -S foobar.
" :GV! will only list commits that affected the current file
" :GV? fills the location list with the revisions of the current file
" :GV or :GV? can be used in visual mode to track the changes in the selected lines.

" Mappings
" --------
" o or <cr> on a commit to display the content of it
" o or <cr> on commits to display the diff in the range
" O opens a new tab instead
" gb for :Gbrowse
" ]] and [[ to move between commits
" . to start command-line with :Git [CURSOR] SHA à la fugitive
" q or gq to close

" }}}

" deoplete {{{

Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" golang
Plug 'https://github.com/deoplete-plugins/deoplete-go', { 'do': 'make'}

" }}}

" ale {{{

Plug 'https://github.com/dense-analysis/ale'

" fix on save
let g:ale_fix_on_save = 1

" Enable completion where available.
let g:ale_completion_enabled = 1

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']

" }}}

" disabled {{{

" rust {{{

" Plug 'https://github.com/rust-lang/rust.vim'
"
" let g:rustfmt_autosave = 1
"
" "macunix                 Macintosh version of Vim, using Unix files (OS-X).
" "unix                    Unix version of Vim.
" "win32                   Win32 version of Vim (MS-Windows 95 and later, 32 or 64 bits)
" "win32unix               Win32 version of Vim, using Unix files (Cygwin)
"
" if has('macunix')
"   let g:rust_clip_command = 'pbcopy'
" elseif has('unix')
"   let g:rust_clip_command = 'xclip -selection clipboard'
" endif

" au! BufNewFile,BufReadPost *.{rs} set foldmethod=syntax

" rust-racer {{{

" Plug 'racer-rust/vim-racer'
"
" " racer path
" let g:racer_cmd = "$HOME/.cargo/bin/racer"
"
" " insert parentheses
" let g:racer_insert_paren = 1
"
" " auto commands
" augroup Racer
"   autocmd!
"   autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
"   autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
"   autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
"   autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
"   autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
" augroup END

" }}}

" }}}

" which-key {{{

" Plug 'https://github.com/liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
"
" let g:mapleader = "\<Space>"
" let g:maplocalleader = ","
"
" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :WhichKey ','<CR>


" }}}

" vim-multiple-cursors {{{

" Plug 'https://github.com/terryma/vim-multiple-cursors'

" start: <C-n> start multicursor and add a virtual cursor + selection on the match
" next: <C-n> add a new virtual cursor + selection on the next match
" skip: <C-x> skip the next match
" prev: <C-p> remove current virtual cursor + selection and go back on previous match
" select all: <A-n> start multicursor and directly select all matches

" }}}

" }}}

" initialize
call plug#end()

" }}}

" auto commands {{{

augroup configgroup
    autocmd!
    " au VimEnter * highlight clear SignColumn
    " au BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    " \:call <SID>StripTrailingWhitespaces()
    " au FileType java setlocal noexpandtab
    " au FileType java setlocal list
    " au FileType java setlocal listchars=tab:+\ ,eol:-
    " au FileType java setlocal formatprg=par\ -w80\ -T4
    " au FileType php setlocal expandtab
    " au FileType php setlocal list
    " au FileType php setlocal listchars=tab:+\ ,eol:-
    " au FileType php setlocal formatprg=par\ -w80\ -T4
    " au FileType ruby setlocal tabstop=2
    " au FileType ruby setlocal shiftwidth=2
    " au FileType ruby setlocal softtabstop=2
    " au FileType ruby setlocal commentstring=#\ %s
    " au FileType python setlocal commentstring=#\ %s
    au FileType netrw set nolist
    au FileType zsh set foldmethod=marker foldlevel=0 foldenable
    au FileType vim set foldmethod=marker foldlevel=0 foldenable

    " au BufEnter *.cls setlocal filetype=java
    " au BufEnter Makefile setlocal noexpandtab
    " au BufEnter *.sh setlocal tabstop=2
    " au BufEnter *.sh setlocal shiftwidth=2
    " au BufEnter *.sh setlocal softtabstop=2
    au BufEnter *.zsh-theme setlocal filetype=zsh

    au TermEnter,TermLeave * setlocal scrolloff=0

    " trim whitespace on save
    au BufWritePre * :%s/\s\+$//e

    " enter insert mode any time focus is put on a terminal
    autocmd BufWinEnter,WinEnter term://* startinsert

    " remove cursor line on insert
    autocmd InsertEnter,InsertLeave * set cul!
augroup END

" }}}

" commands {{{

" wipe resiters contents
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" }}}

" mappings {{{

" editing {{{

" disabled keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" nnoremap $ <nop>
" nnoremap ^ <nop>

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

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" remove highlight from search
nnoremap <silent> <leader><space> :noh<CR>

" map delete line
nnoremap <silent> - O<esc>
nnoremap <silent> <bs> dd

" scroll the viewport faster
nnoremap <silent> <C-e> 5<C-e>
nnoremap <silent> <C-y> 5<C-y>

" enable . command in visual mode
vnoremap . :normal .<cr>

" keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" highlight last inserted text
nnoremap gV `[v`]

" folding
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <Space> za
vnoremap <Space> za

" Use space to jump down a page (like browsers do)...
" nnoremap <Space> <PageDown>
" xnoremap <Space> <PageDown>

" return turns off search highlighting
nnoremap <CR> :set hlsearch! hlsearch?<CR>

" toggle spell check
map <F7> :setlocal spell! spelllang=en_us<CR>

" surround with double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" switch between current and last buffer
nmap <leader>. <c-^>

" show netrw
nnoremap <leader>ex :Exp<CR>
nnoremap <F7> :Exp<CR>

" format document
" nnoremap <leader>ff gg=G<CR>

" edit, source vim file
" nnoremap <silent> <leader>ev :vsp $MYVIMRC<cr>
" nnoremap <silent> <leader>ez :vsp ~/.zshrc<CR>
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>

" }}}

" windows {{{

" split related commands "
" :sp filename	Open filename in horizontal split
" :vsp filename	Open filename in vertical split
" Ctrl-w h Ctrl-w ←	Shift focus to split on left of current
" Ctrl-w l Ctrl-w →	Shift focus to split on right of current
" Ctrl-w j Ctrl-w ↓	Shift focus to split below the current
" Ctrl-w k Ctrl-w ↑	Shift focus to split above the current
" Ctrl-w n+	Increase size of current split by n lines
" Ctrl-w n-	Decrease size of current split by n lines

" split vertically
nnoremap <leader>wv <C-w>v

" split horizontally
nnoremap <leader>wh <C-w>s

" close all but current
nnoremap <leader>wo <C-w>o

" quit window
nnoremap <leader>wq <C-w>q

" resize =
nnoremap <leader>we <C-w>=

" kotate window
nnoremap <leader>wr <C-W>r

" move to window
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" resize windows
map <right> <c-w><
map <left>  <c-w>>
map <up>    <c-w>+
map <down>  <c-w>-

" edit file in sudo if protected
cmap w!! w !sudo tee % >/dev/null

" }}}

" buffers {{{

" switch to buffer by number
nnoremap <leader>gb :ls<CR>:b<Space>

" switch to buffer by name [partial]
nnoremap <leader>bb :buffer *

" buffer next
nnoremap <leader>bn :bn<CR>

" buffer previous
nnoremap <leader>bp :bp<CR>

" buffer delete
nnoremap <leader>bd :bd<CR>

" navigate between buffers using tab and shift+tab
nnoremap <Tab> :bNext<CR>
nnoremap <S-Tab> :bprevious<CR>


" }}}

" tabs {{{

" tab new
nnoremap <leader>tn :tabnew<CR>

" tab edit a file
nnoremap <leader>te :tabedit **/*

" tab find a file
nnoremap <leader>tf :tabfind *

" close current tab
nnoremap <leader>tw :tabclose<CR>

" closes all tab pages except the current one
nnoremap <leader>to :tabo<CR>

" navigate between buffers using tab and shift+tab
" nnoremap <Tab> :tabNext<CR>
" nnoremap <S-Tab> :tabprevious<CR>

" }}}

" terminal {{{

" remap exit
tnoremap <Esc> <C-\><C-n>

" }}}

" }}}

" color schemes {{{

" colorscheme base16-default-dark

" let g:onedark_termcolors=16
" let g:onedark_terminal_italics=1
" colorscheme onedark

" colorscheme gruvbox
" colorscheme dracula
" colorscheme vimterial_dark

" options: light, mirage, dark
let ayucolor="mirage"
colorscheme ayu

" }}}

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
