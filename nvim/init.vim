set encoding=utf-8
scriptencoding utf-8

" define leader
let mapleader = ','

" settings {{{

" disable netrw
let loaded_netrwPlugin=1

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
set directory=~/.cache/vim " swap directory"
set backupdir=~/.cache/vim " backup directory"
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
set shortmess+=c               " don't pass messages to |ins-completion-menu| "
set ttyfast                    " faster redrawing "

" display
set background=dark            " vim background color "
set cursorline                 " enable cursor line "
set linebreak                  " avoid wrapping a line in the middle of a word "
set list                       " show invisibles
set listchars=tab:--,
            \trail:.,
            \extends:#,
            \nbsp:.
" set listchars=tab:→→,eol:¬,space:.,trail:.,extends:#
set matchtime=1                " When typing a closing bracket, briefly flash the one it matches "
set number relativenumber      " show hybrid line numbers "
set ruler                      " enable column and line numbers "
set showbreak=↪                " show break char "
set showcmd                    " show imcomplete commands "
set showmatch                  " highlight matching [{()}] "
set signcolumn=auto            " show sign column "
set splitbelow                 " split below by default "
set splitright                 " split right by default "
set title                      " set title of window to file "
set virtualedit=block          " virtual cursor movements. options: block, insert or all "
set wildmenu                   " wild menu "
set wildoptions=pum            " display menu in popup "

" scroll
set scrolloff=10               " screenlines to keep above and below the cursor "
set sidescrolloff=5            " col to keep to the left and right of the cursor "

" popup
set winbl=20                   " floating window transparency "

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
set nobackup                   " don't create backup files "
set nospell                    " disable spelling highlights "
set noswapfile                 " no swap files "
set nowritebackup              " delete backup after write "

" search
set gdefault                   " default global search"
set hlsearch                   " highlight search results "
set ignorecase                 " case insensitive searching "
set incsearch                  " set incremental search, like modern browsers "
set magic                      " set magic on, for regex "
set nolazyredraw               " don't redraw while executing macros "
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

" }}}

" plugins {{{

" automatically install vim-plug and run PlugInstall if vim-plug not found
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    augroup nvinstall
        autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup end
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" dev icons
Plug 'https://github.com/ryanoasis/vim-devicons'

" color schemes
Plug 'https://github.com/chriskempson/base16-vim'
Plug 'https://github.com/ayu-theme/ayu-vim'
Plug 'https://github.com/dracula/vim', { 'as': 'dracula' }
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/larsbs/vimterial_dark'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/mhartington/oceanic-next'

" plugins
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/alvan/vim-closetag'

" language support
Plug 'https://github.com/zxqfl/tabnine-vim'
Plug 'https://github.com/sheerun/vim-polyglot'
" Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'https://github.com/posva/vim-vue'
Plug 'https://github.com/prettier/vim-prettier', { 'do': 'yarn install' }
" Plug 'https://github.com/mattn/emmet-vi

" fzf {{{

Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'

" FZF key bindings
nnoremap <M-f> :FZF<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>g :Rg<CR>
nnoremap <silent> <leader>o :All<cr>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <leader>h :History<CR>

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" let g:fzf_default_command = 'rg -p --files --ignore-case -g ''node_modules/**'' -g ''.git/**'''
let g:fzf_default_command = 'rg -g node_modules'

let g:fzf_tags_command = 'ctags -R --exclude="node_modules/*" --exclude=".git" --exclude="dist/*" --exclude="build/*" --exclude="tests" .'

command! -bang -nargs=*  All
            \ call fzf#run(fzf#wrap({
            \ 'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*,.cache/*,dist/*,*.lock}"',
            \ 'down': '40%',
            \ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse'
            \ }))


" }}}

" ale {{{

Plug 'https://github.com/dense-analysis/ale'

" options
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint', 'vls']}
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_tsserver_autoimport = 1

" use quickfix instead of loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" change signs
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" turn off running on text change and insert
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0

" don't run on opening a file
" let g:ale_lint_on_enter = 0

" highlight
hi ALEWarning ctermbg=DarkMagenta
hi clear ALEErrorSign
hi clear ALEWarningSign

" mappings
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" }}}

" snippets {{{

Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'

let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<c-b>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" }}}

" startify {{{

Plug 'https://github.com/mhinz/vim-startify'

augroup group-startify
    autocmd!
    " show startify after last buffer close
    au BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif
augroup END

" }}}

" lightline {{{

Plug 'https://github.com/itchyny/lightline.vim'

" schemes: wombat
let g:lightline = {
            \ 'colorscheme': 'onedark',
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

" taglist {{{

Plug 'https://github.com/yegappan/taglist'

let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window = 1
let Tlist_Process_File_Always = 1
" let Tlist_Compact_Format = 1
" let Tlist_Use_Horiz_Window = 1

" show tags for only open file
let Tlist_Show_One_File = 1

" show taglist
nnoremap <silent> <F12> :TlistToggle<CR>

" }}}

" easy align {{{

Plug 'https://github.com/junegunn/vim-easy-align'

" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}

" vim-signature {{{

Plug 'https://github.com/kshenoy/vim-signature'

" mx           Toggle mark 'x' and display it in the leftmost column
" dmx          Remove mark 'x' where x is a-zA-Z

" m,           Place the next available mark
" m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
" m-           Delete all marks from the current line
" m<Space>     Delete all marks from the current buffer
" ]`           Jump to next mark
" [`           Jump to prev mark
" ]'           Jump to start of next line containing a mark
" ['           Jump to start of prev line containing a mark
" `]           Jump by alphabetical order to next mark
" `[           Jump by alphabetical order to prev mark
" ']           Jump by alphabetical order to start of next line having a mark
" '[           Jump by alphabetical order to start of prev line having a mark
" m/           Open location list and display marks from current buffer

" m[0-9]       Toggle the corresponding marker !@#$%^&*()
" m<S-[0-9]>   Remove all markers of the same type
" ]-           Jump to next line having a marker of the same type
" [-           Jump to prev line having a marker of the same type
" ]=           Jump to next line having a marker of any type
" [=           Jump to prev line having a marker of any type
" m?           Open location list and display markers from current buffer
" m<BS>        Remove all markers

" }}}

" git {{{

Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'

" }}}

" rust {{{

" Plug 'https://github.com/rust-lang/rust.vim'

" let g:rustfmt_autosave = 1

" " "macunix                 Macintosh version of Vim, using Unix files (OS-X).
" " "unix                    Unix version of Vim.
" " "win32                   Win32 version of Vim (MS-Windows 95 and later, 32 or 64 bits)
" " "win32unix               Win32 version of Vim, using Unix files (Cygwin)
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

" disabled {{{

" }}}

call plug#end()

" }}}

" auto commands {{{

" syntax region htmlFold start="<\z(\<\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|para\|source\|track\|wbr\>\)\@![a-z-]\+\>\)\%(\_s*\_[^/]\?>\|\_s\_[^>]*\_[^>/]>\)" end="</\z1\_s*>" fold transparent keepend extend containedin=htmlHead,htmlH\d

augroup configgroup
    au!

    " workaround some broken plugins which set guicursor indiscriminately"
    au OptionSet guicursor noautocmd set guicursor=

    au VimEnter * highlight clear SignColumn

    " automatically install missing plugins on startup
    autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugUpdate --sync | q
                \| endif

    au FileType html,xhtml,htm setlocal foldmethod=indent foldlevel=0 foldenable
    au FileType zsh setlocal foldmethod=marker foldlevel=0 foldenable
    au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable

    " quit readonly files with q instead of :q
    au FileType help noremap <buffer> q :bd<cr>

    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    au! FileType fzf tnoremap <buffer> <Esc> <Esc>

    " todo: add comment for this command
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                \ exe "normal! g`\"" |
                \ endif

    " au BufEnter Makefile setlocal noexpandtab
    " au BufEnter *.cls setlocal filetype=java
    " au BufEnter *.sh setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufEnter *.zsh-theme setlocal filetype=zsh

    " trim whitespace on save
    au BufWritePre * :%s/\s\+$//e

    " auto source when saving
    " au BufWritePost $MYVIMRC source %

    " enter insert mode any time focus is put on a terminal
    au BufWinEnter,WinEnter term://* startinsert

    " remove cursor line on insert
    au InsertEnter,InsertLeave * set cul!

    " remove scrolloff in terminal
    au TermEnter,TermLeave * setlocal scrolloff=0
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

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" use qq to record, q to stop, Q to play a macro
nnoremap Q @q
vnoremap Q :normal @q

" easy caps
" inoremap <c-u> <ESC>viwUi
" nnoremap <c-u> viwU<ESC>

" scroll the viewport faster
nnoremap <silent> <C-e> 3<C-e>
nnoremap <silent> <C-y> 3<C-y>

" enable . command in visual mode
vnoremap . :normal .<cr>

" keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" highlight last inserted text
nnoremap gV `[v`]

" folding
nnoremap <Space> za
vnoremap <Space> za

" format document
" nnoremap <leader>ff gg=G<CR>

" edit, source vim file
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" tab completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" " resize =
" nnoremap <M-=> <C-w>=

" move to window
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" use arrows to resize windows
" map <right> <c-w><
" map <left>  <c-w>>
" map <up>    <c-w>+
" map <down>  <c-w>-

" use alt to resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" tab in normal mode switches buffers
"nnoremap <TAB> :bnext<CR>
"nnoremap <S-TAB> :bprevious<CR>

" remap exit
tnoremap <Esc> <C-\><C-n>

" save with sudo
cmap w!! w !sudo tee %

" }}}

" color schemes {{{

" let g:onedark_termcolors=16
" let g:onedark_terminal_italics=1
" colorscheme onedark

" colorscheme gruvbox
" colorscheme dracula
" colorscheme vimterial_dark
colorscheme onedark
" colorscheme OceanicNext

" options: light, mirage, dark
" let ayucolor="mirage"
" colorscheme ayu

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
