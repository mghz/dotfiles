" vim/nvim configuration

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

" appearance
set backspace=indent,eol,start " OSX stupid backspace fix
set encoding=utf-8 " use an encoding that supports unicode
set hidden " disable warning of hidden buffers
set history=1000
set linebreak "avoid wrapping a line in the middle of a word
set list "enable list
set matchtime=1 " When typing a closing bracket, briefly flash the one it matches
set mouse=a "enable text copy
set number relativenumber " show hybrid line numbers
set scrolloff=10 "screenlines to keep above and below the cursor
set shell=$SHELL "shell
"set shortmess+=c " don't give ins-completion-menu messages
set shortmess=at "don't give ins-completion-menu messages
set showcmd "show imcomplete commands
set showmatch " highlight matching [{()}]
set sidescrolloff=5 "col to keep to the left and right of the cursor
set signcolumn=yes "show sign column
set splitbelow
set splitright
set title "set title of window to file
set ttyfast "faster redrawing
set updatetime=300 "bad experience for diagnostic messages when it's default 4000
set virtualedit=block "virtual cursor movements. options: block, insert or all"
set wildmenu "wild menu
set wildmode=longest,list,full "wild mode
"set wildmode=list:longest " complete files like a shell

" tab control
set autoindent "auto indent on new lines set autoread
set expandtab	"tabs are spaces
set shiftround "round indentation when shifting lines
set shiftwidth=2 "shift size after rounding
set smartindent "smarter than indent.
set smarttab "smart tabbing
set softtabstop=2 "number of spaces in tab when editing
set tabstop=2	"default tab space

" folding
set foldlevel=2
set foldlevelstart=2
set foldmethod=marker "fold based on marker
set foldnestmax=15 "deepest fold is 10 levels
set foldenable "fold by default (nofoldenable)

" status
set cmdheight=1 "better display for message
set laststatus=2 "always display the status bar

" backup, swap, spelling
set nobackup "don't create backup files
set nospell "disable spelling highlights
set noswapfile "no swap files
set nowritebackup "delete backup after write

" searc
set hlsearch "highlight search results
set ignorecase "case insensitive searching
set magic "set magic on, for regex
set incsearch "set incremental search, like modern browsers
set nolazyredraw "don't redraw while executing macros
set smartcase "case-sensitive if expresson contains a capital letter

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
        \   exe "normal! g`\"" |
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

" highlights {{{

" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
highlight ExtraWhitespace ctermbg=red guibg=red

" }}}

" functions {{{

" function! s:buflist()
"   redir => ls
"   silent ls
"   redir END
"   return split(ls, '\n')
" endfunction
"
" function! s:bufopen(e)
"   execute 'buffer' matchstr(a:e, '^[ 0-9]*')
" endfunction

" }}}

" plugins {{{

" ensure vim-plug is installed
" call functions#PlugLoad()

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

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
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

" auto-pairs {{{

Plug 'jiangmiao/auto-pairs'

" }}}

" git {{{

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" }}}

" fzf {{{

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" hide statusline
" autocmd! FileType fzf set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <silent> <Leader>z :Files<CR>

" }}}

" coc completion {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" }}}

" polyglot {{{

Plug 'sheerun/vim-polyglot'

" }}}

" rust {{{

Plug 'rust-lang/rust.vim'

let g:rustfmt_autosave = 1

"macunix                 Macintosh version of Vim, using Unix files (OS-X).
"unix                    Unix version of Vim.
"win32                   Win32 version of Vim (MS-Windows 95 and later, 32 or 64 bits)
"win32unix               Win32 version of Vim, using Unix files (Cygwin)

if has('macunix')
  let g:rust_clip_command = 'pbcopy'
elseif has('unix')
  let g:rust_clip_command = 'xclip -selection clipboard'
endif

au! BufNewFile,BufReadPost *.{rs} set foldmethod=syntax

" }}}

" rust-racer {{{

Plug 'racer-rust/vim-racer'

" racer path
let g:racer_cmd = "$HOME/.cargo/bin/racer"

" insert parentheses
let g:racer_insert_paren = 1

" auto commands
augroup Racer
  autocmd!
  autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
  autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
  autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
  autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
  autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
augroup END

" }}}

" ultisnips {{{

" engine and snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Trigger configuration
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" }}}

" initialize
call plug#end()

" }}}

" auto commands {{{

augroup vimrc
  au!

  " trim whitespace on save
  " au BufWritePre * :%s/\s\+$//e

augroup END

" wipe resiters contents
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/



" }}}

" mappings {{{

let mapleader=","

" editing {{{

" disable, remap esc
inoremap <esc> <nop>
inoremap jk <esc>
inoremap kj <esc>
vnoremap jk <esc>
vnoremap kj <esc>
cnoremap jk <esc>
cnoremap kj <esc>

" remap command toggle
nnoremap ; :
nnoremap : ;

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" remove highlight from search
nnoremap <silent> ,<space> :noh<CR>

" map delete line
nnoremap <silent> - o<esc>
nnoremap <silent> <bs> dd

" scroll the viewport faster
nnoremap <silent> <C-e> 3<C-e>
nnoremap <silent> <C-y> 3<C-y>

" enable . command in visual mode
vnoremap . :normal .<cr>

" keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" }}}

" leader mappings {{{

" edit, source vim file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" clear highlighted search
noremap <leader>h :set hlsearch! hlsearch?<cr>

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" surround with double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" switch between current and last buffer
nmap <leader>. <c-^>

" }}}

" splits {{{

" Split related commands "
" :sp filename	Open filename in horizontal split
" :vsp filename	Open filename in vertical split
" Ctrl-w h Ctrl-w ←	Shift focus to split on left of current
" Ctrl-w l Ctrl-w →	Shift focus to split on right of current
" Ctrl-w j Ctrl-w ↓	Shift focus to split below the current
" Ctrl-w k Ctrl-w ↑	Shift focus to split above the current
" Ctrl-w n+	Increase size of current split by n lines
" Ctrl-w n-	Decrease size of current split by n lines

" add a split
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s

" split nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" }}}

" buffers {{{

map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

" }}}

" tabs {{{

" navigation
" nnoremap <C-t>      :tabnew<CR>
" inoremap <C-t>      <Esc>:tabnew<CR>
" nnoremap <C-w>      :tabclose<CR>
" inoremap <C-w>      <Esc>:tabclose<CR>

" nnoremap th :tabfirst<CR>
" nnoremap tk :tabnext<CR>
" nnoremap tj :tabprev<CR>
" nnoremap tl :tablast<CR>
" nnoremap tt :tabedit<Space>
" nnoremap tn :tabnext<Space>
" nnoremap tm :tabm<Space>
" nnoremap td :tabclose<CR>
" nnoremap tw :tabnew<CR>

" terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" set leader shortcut for splits
nnoremap ,w <C-w>

" switch between splits
nnoremap ,, <C-w><C-w>

" maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>

" Max out the height of the current split
" ctrl + w _

" Max out the width of the current split
" ctrl + w |

" Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =

" Swap top/bottom or left/right split
" Ctrl+W R

" Break out current window into a new tabview
" Ctrl+W T

" Close every window in the current tabview but the current one
" Ctrl+W o

" }}}

" }}}

" colorscheme {{{

colorscheme base16-default-dark

"let g:onedark_termcolors=16
"let g:onedark_terminal_italics=1
"colorscheme onedark

colorscheme dracula
"colorscheme gruvbox

" }}}
