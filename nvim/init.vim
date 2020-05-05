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

" files to ignore
set wildignore+=.pyc,.swp,.DS_Store

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

" netrw {{{

" :help netrw-quickmap
" let g:netrw_banner = 0

" cycle thru views with i
let g:netrw_liststyle = 3

" }}}

" }}}

" plugins {{{

" automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" color schemes {{{

Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" }}}

" airline {{{

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" enable buffers as tabs"
" let g:airline#extensions#tabline#enabled = 1

" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'

" let g:airline#extensions#tabline#formatter = 'default'

" }}}

" fzf {{{

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" hide statusline
" autocmd! FileType fzf set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" FZF key bindings
nnoremap <C-p> :Files<CR>
" nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-i': 'split',
            \ 'ctrl-v': 'vsplit' }

" }}}

" vim-surround {{{

" to use press cs"' to change " to '
Plug 'tpope/vim-surround'

" }}}

" vim-multiple-cursors {{{

Plug 'terryma/vim-multiple-cursors'

" start: <C-n> start multicursor and add a virtual cursor + selection on the match
" next: <C-n> add a new virtual cursor + selection on the next match
" skip: <C-x> skip the next match
" prev: <C-p> remove current virtual cursor + selection and go back on previous match
" select all: <A-n> start multicursor and directly select all matches

" }}}

" development {{{

Plug 'ryanoasis/vim-devicons'

" coc completion {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

" use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" close the preview window when completion is done
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" }}}

" ale {{{

Plug 'dense-analysis/ale'

" fix on save
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_fix_on_save = 1


" }}}

" polyglot {{{

Plug 'sheerun/vim-polyglot'

" }}}

" go {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" }}}

" nerdcommenter {{{

Plug 'preservim/nerdcommenter'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" mappings
" ---------
"Comment out the current line or text selected in visual mode.
"[count]<leader>cc |NERDCommenterComment|

"Same as cc but forces nesting.
"[count]<leader>cn |NERDCommenterNested|

"Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
"[count]<leader>c<space> |NERDCommenterToggle|

"Comments the given lines using only one set of multipart delimiters.
"[count]<leader>cm |NERDCommenterMinimal|

"Toggles the comment state of the selected line(s) individually.
"[count]<leader>ci |NERDCommenterInvert|

"Comments out the selected lines with a pretty block formatted layout.
"[count]<leader>cs |NERDCommenterSexy|

"Same as cc except that the commented line(s) are yanked first.
"[count]<leader>cy |NERDCommenterYank|

"Comments the current line from the cursor to the end of line.
"<leader>c$ |NERDCommenterToEOL|

"Adds comment delimiters to the end of line and goes into insert mode between them.
"<leader>cA |NERDCommenterAppend|

"Switches to the alternative set of delimiters.
"<leader>ca |NERDCommenterAltDelims|

"Same as |NERDCommenterComment| except that the delimiters are aligned down the left side (<leader>cl) or both sides (<leader>cb).
"[count]<leader>cl |NERDCommenterAlignLeft [count]<leader>cb |NERDCommenterAlignBoth

"Uncomments the selected line(s).
"[count]<leader>cu |NERDCommenterUncomment|

" }}}

" tagbar {{{

Plug 'majutsushi/tagbar'

nmap <F8> :TagbarToggle<CR>

" }}}

" auto-pairs {{{

Plug 'jiangmiao/auto-pairs'

" }}}

" git {{{

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" }}}

" prettier {{{

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" nmap <Leader>py <Plug>(Prettier)

" }}}

" }}}

" disabled {{{

" rust {{{

" Plug 'rust-lang/rust.vim'
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

" ultisnips {{{

" engine and snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" Trigger configuration
" let g:UltiSnipsExpandTrigger="<C-s>"
" let g:UltiSnipsJumpForwardTrigger="<C-b>"
" let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" snippets bootstrap 4 {{{

Plug 'jvanja/vim-bootstrap4-snippets'

" }}}

" }}}

" which-key {{{

" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
"
" let g:mapleader = "\<Space>"
" let g:maplocalleader = ","
"
" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :WhichKey ','<CR>


" }}}

" }}}

" initialize
call plug#end()

" }}}

" auto commands {{{

augroup configgroup
    autocmd!
    " autocmd VimEnter * highlight clear SignColumn
    " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    " \:call <SID>StripTrailingWhitespaces()
    " autocmd FileType java setlocal noexpandtab
    " autocmd FileType java setlocal list
    " autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    " autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    " autocmd FileType php setlocal expandtab
    " autocmd FileType php setlocal list
    " autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    " autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    " autocmd FileType ruby setlocal tabstop=2
    " autocmd FileType ruby setlocal shiftwidth=2
    " autocmd FileType ruby setlocal softtabstop=2
    " autocmd FileType ruby setlocal commentstring=#\ %s
    " autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType netrw set nolist
    autocmd FileType zsh set foldmethod=marker foldlevel=0
    autocmd FileType vim set foldmethod=marker foldlevel=0

    " autocmd BufEnter *.cls setlocal filetype=java
    " autocmd BufEnter Makefile setlocal noexpandtab
    " autocmd BufEnter *.sh setlocal tabstop=2
    " autocmd BufEnter *.sh setlocal shiftwidth=2
    " autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh

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

" }}}

" leader mappings {{{

" edit, source vim file
" nnoremap <silent> <leader>ev :vsp $MYVIMRC<cr>
" nnoremap <silent> <leader>ez :vsp ~/.zshrc<CR>
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>

" surround with double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" switch between current and last buffer
nmap <leader>. <c-^>

" show netrw
nnoremap <leader>ex :Exp<CR>
nnoremap <F8> :Exp<CR>

" format document
nnoremap <leader>ff gg=G<CR>

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
nnoremap <Tab> :bnext<CR>
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

colorscheme gruvbox
" colorscheme dracula

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
