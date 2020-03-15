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

" hightlights {{{

" highlight whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermfg=19 guifg=#333333
highlight NonText ctermfg=19 guifg=#333333

" make comments and HTML attributes italic
highlight Comment cterm=italic term=italic gui=italic
highlight htmlArg cterm=italic term=italic gui=italic
highlight xmlAttrib cterm=italic term=italic gui=italic

" highlight Type cterm=italic term=italic gui=italic
highlight Normal ctermbg=none

" }}}

" functions {{{

function! PlugLoad()

endfunction

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

" }}}

" plugins {{{

" ensure vim-plug is installed
" call functions#PlugLoad()

call plug#begin(expand('~/.config/nvim/plugged'))

" color schemes {{{

Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" }}}

" nerdtree {{{

Plug 'preservim/nerdtree'

" nerdtree
" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" % opens current directory of file
nnoremap <C-o> :NERDTreeToggle %<cr>

" nerdtree ignore files
let g:NERDTreeIgnore = ['^node_modules$']

" }}}

" nerdtree git {{{

Plug 'Xuyuanp/nerdtree-git-plugin'

" nerd git plugin
let NERDTreeShowHidden=1 "show hidden files
let g:NERDTreeQuitOnOpen=1 "close after opening file
let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
      \ "Staged"    : "#0ee375",
      \ "Modified"  : "#d9bf91",
      \ "Renamed"   : "#51C9FC",
      \ "Untracked" : "#FCE77C",
      \ "Unmerged"  : "#FC51E6",
      \ "Dirty"     : "#FFBD61",
      \ "Clean"     : "#87939A",
      \ "Ignored"   : "#808080"
      \ }

" }}}

" git {{{

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" }}}

" coc completion {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" }}}

" initialize
call plug#end()

" }}}

" auto commands {{{

augroup vimrc
  au!

  " trim whitespace on save
  au BufWritePre * :%s/\s\+$//e

  " auto format html, no wrap
  au BufWritePre,BufRead *.rs :normal gg=G
  au BufWritePre,BufRead *.html :normal gg=G
  au BufNewFile,BufRead *.html setlocal nowrap
augroup END

" }}}

" mappings {{{

" disable, remap esc
inoremap <esc> <nop>
inoremap jk <esc>
inoremap kj <esc>
vnoremap jk <esc>
vnoremap kj <esc>

" remap command toggle
nnoremap ; :
nnoremap : ;

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" map delete line
nnoremap - o<esc>
nnoremap <bs> dd
inoremap <c-d> <esc>ddi

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" enable . command in visual mode
vnoremap . :normal .<cr>

" keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" leader mappings {{{

" edit, source vim file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" format doc
nnoremap <leader>ff gg=G

" clear highlighted search
noremap <leader>h :set hlsearch! hlsearch?<cr>

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" surround with double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" switch between current and last buffer
nmap <leader>. <c-^>

" remove highlight
nnoremap <leader>, :noh<cr>

" }}}

" splits {{{

" add a split
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s

" split nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" }}}

" tabs {{{

" navigation
nnoremap <C-S-tab>  :tabprevious<CR>
nnoremap <C-tab>    :tabnext<CR>
nnoremap <C-t>      :tabnew<CR>
inoremap <C-S-tab>  <Esc>:tabprevious<CR>i
inoremap <C-tab>    <Esc>:tabnext<CR>i
inoremap <C-t>      <Esc>:tabnew<CR>
nnoremap <C-Insert> :tabnew<CR>
nnoremap <C-Delete> :tabclose<CR>

nnoremap th :tabfirst<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tt :tabedit<Space>
nnoremap tn :tabnext<Space>
nnoremap tm :tabm<Space>
nnoremap td :tabclose<CR>

" use <A-Fn> to go to the nth tabpage
nnoremap <A-F1> 1gt
nnoremap <A-F2> 2gt
nnoremap <A-F3> 3gt
nnoremap <A-F4> 4gt
nnoremap <A-F5> 5gt
nnoremap <A-F6> 6gt
nnoremap <A-F7> 7gt
nnoremap <A-F8> 8gt
nnoremap <A-F9> 9gt
nnoremap <A-F0> 10gt

" Alternatively use
"nnoremap L gt
"nnoremap th :tabnext<CR>
"nnoremap tl :tabprev<CR>
"nnoremap tn :tabnew<CR>

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

" settings {{{

colorscheme base16-default-dark

"let g:onedark_termcolors=16
"let g:onedark_terminal_italics=1
"colorscheme onedark

"colorscheme dracula
"colorscheme gruvbox

let mapleader=","
let base16colorspace=256

syntax on
filetype plugin indent on

" clipboard
if has('clipboard')
  if has('unnamedplus') " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" appearance
set backspace=indent,eol,start " OSX stupid backspace fix
set encoding=utf-8 " use an encoding that supports unicode
set hidden " disable warning of hidden buffers
set history=1000
set linebreak " avoid wrapping a line in the middle of a word
set mouse=a " enable text copy
set relativenumber " show hybrid line numbers
set scrolloff=10 " screenlines to keep above and below the cursor
set shell=$SHELL " shell
set shortmess+=c " don't give ins-completion-menu messages
set showcmd "show imcomplete commands
set showmatch " highlight matching [{()}]
set sidescrolloff=5 " col to keep to the left and right of the cursor
set signcolumn=yes " show sign column
set splitbelow
set splitright
set title " set title of window to file
set ttyfast "faster redrawing
set updatetime=300 " bad experience for diagnostic messages when it's default 4000
set wildmenu " wild menu
set wildmode=longest,list,full " wild mode
"set wildmode=list:longest " complete files like a shell

" tab control
set autoindent " auto indent on new lines set autoread
set expandtab	" tabs are spaces
set shiftround " round indentation when shifting lines
set shiftwidth=2 " shift size after rounding
set smartindent " smarter than indent.
set smarttab " smart tabbing
set softtabstop=2 " number of spaces in tab when editing
set tabstop=2	" default tab space

" folding
set foldlevel=2
set foldlevelstart=2
set foldmethod=marker " fold based on marker
set foldnestmax=10 " deepest fold is 10 levels
set foldenable " fold by default (nofoldenable)

" status
set cmdheight=1 " better display for message
set laststatus=2 " always display the status bar

" backup, swap, spelling
set nobackup " don't create backup files
set nospell " disable spelling highlights
set noswapfile " no swap files
set nowritebackup " delete backup after write

" search
set hlsearch " highlight search results
set ignorecase " case insensitive searching
set magic " Set magic on, for regex
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros
set smartcase " case-sensitive if expresson contains a capital letter

" files to ignore
set wildignore+=.pyc,.swp,.DS_Store

" nvim options
if (has('nvim'))
  " show results of substition as they're happening
  " but don't open a split
  set inccommand=nosplit
endif

" error bell
if has('macunix') " options: unix, win32, win32unix
  " prevent mac terminal flash issue
  set noerrorbells
  set visualbell
  set t_vb=
  set tm=500
endif

" terminal colors
" set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

" switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175

if &term =~ '256color'
  " disable background color erase
  set t_ut=
endif

" enable 24 bit color support if supported
if (has("termguicolors"))
  if (!(has("nvim")))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" comments {{{
"
" Most custom commands expand off my map leader, keeping nvim as vanilla as possible.
"
" , - Map leader, nearly all my custom mappings starts with pressing the comma key
" ,q - Sidebar filetree viewer (NERDTree)
" ,w - Sidebar classes, functions, variables list (TagBar)
" \ - Toggle both NERDTree and TagBar
" ,ee - Change colorscheme (with fzf fuzzy finder)
" ,ea - Change Airline theme
" ,e1 - Color mode: Dracula (Dark)
" ,e2 - Color mode: Seoul256 (Between Dark & Light)
" ,e3 - Color mode: Forgotten (Light)
" ,e4 - Color mode: Zazen (Black & White)
" ,r - Refresh/source ~/.config/nvim/init.vim
" ,t - Trim all trailing whitespaces
" ,a - Auto align variables (vim-easy-align), eg. do ,a= while your cursor is on a bunch of variables to align their equal signs
" ,s - New terminal in horizontal split
" ,vs - New terminal in vertical split
" ,d - Automatically generate Python docstrings while cursor is hovering above a function or class
" ,f - Fuzzy find a file (fzf)
" ,g - Toggle Goyo mode (Goyo), super clean and minimalistic viewing mode
" ,h - Toggle rainbow parentheses highlighting
" ,j - Set filetype to "journal" which makes the syntax highlighting beautiful when working on regular text files and markdown
" ,k - Toggle coloring of hex colors
" ,l - Toggle Limelight mode (Limelight), highlight the lines near cursor only
" ,c<Space> - Toggle comment for current line (Nerd Commenter)
" <Alt-r> - Toggle RGB color picker
" <Tab> - Next buffer
" <Shift-Tab> - Previous buffer
"
" nmap <leader>q :NERDTreeToggle<CR>
" nmap \ <leader>q
" nmap <leader>w :TagbarToggle<CR>
" nmap <leader>ee :Colors<CR>
" nmap <leader>ea :AirlineTheme
" nmap <leader>e1 :call ColorDracula()<CR>
" nmap <leader>e2 :call ColorSeoul256()<CR>
" nmap <leader>e3 :call ColorForgotten()<CR>
" nmap <leader>e4 :call ColorZazen()<CR>
" nmap <leader>r :so ~/.config/nvim/init.vim<CR>
" nmap <leader>t :call TrimWhitespace()<CR>
" xmap <leader>a gaip*
" nmap <leader>a gaip*
" nmap <leader>s <C-w>s<C-w>j:terminal<CR>
" nmap <leader>vs <C-w>v<C-w>l:terminal<CR>
" nmap <leader>d <Plug>(pydocstring)
" nmap <leader>f :Files<CR>
" nmap <leader>g :Goyo<CR>
" nmap <leader>h :RainbowParentheses!!<CR>
" nmap <leader>j :set filetype=journal<CR>
" nmap <leader>k :ColorToggle<CR>
" nmap <leader>l :Limelight!!<CR>
" xmap <leader>l :Limelight!!<CR>
" autocmd FileType python nmap <leader>x :0,$!~/.config/nvim/env/bin/python -m yapf<CR>
" "nmap <leader>n :HackerNews best<CR>J
" nmap <silent> <leader><leader> :noh<CR>
" nmap <Tab> :bnext<CR>
" nmap <S-Tab> :bprevious<CR>
"
" }}}
