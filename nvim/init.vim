" vim/nvim configuration

" define leader
let mapleader = ","

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
set dir=~/.cache/vim "swap directory"
set backupdir=~/.cache/vim "backup directory"

" functionality
set autoread " auto read files that have changed outside of vim "
set autowrite " auto write buffer on certain conditions "
set backspace=indent,eol,start " OSX stupid backspace fix "
set bsdir=last " open last directory"
set diffopt+=vertical " show diff vertically"
set encoding=utf-8 " use an encoding that supports unicode "
set hidden " disable warning of hidden buffers "
set history=10000
set mouse=a " enable mouse mode "
"set omnifunc=syntaxcomplete#Complete " enable auto completion "
set path+=** " enable recursive dir paths "
set shell=$SHELL " use os shell "
set shortmess+=c " don't pass messages to |ins-completion-menu| "
set ttyfast " faster redrawing "

" display
set background=dark " vim background color "
set cursorline " enable cursor line "
set linebreak " avoid wrapping a line in the middle of a word "
set list
set listchars=tab:--,trail:.,extends:#,nbsp:.
set matchtime=1 " When typing a closing bracket, briefly flash the one it matches "
set number relativenumber " show hybrid line numbers "
set ruler " enable column and line numbers "
set showbreak=↪ " show break char "
set showcmd " show imcomplete commands "
set showmatch " highlight matching [{()}] "
set signcolumn=auto " show sign column "
set splitbelow " split below by default "
set splitright " split right by default "
set title " set title of window to file "
set virtualedit=block " virtual cursor movements. options: block, insert or all "
set wildmenu " wild menu "
set wildoptions=pum " display menu in popup "

" scroll
set scrolloff=10 " screenlines to keep above and below the cursor "
set sidescrolloff=5 " col to keep to the left and right of the cursor "

" popup
" set pumheight=10 " set popup menu smaller "
set winbl=20 " floating window transparency "

" timings
"set timeoutlen=100 " default is 1000 "
"set updatetime=500 " bad experience for diagnostic messages when it's default 4000 "

" tab control
set autoindent " auto indent on new lines set autoread "
set expandtab " tabs are spaces "
set shiftround " round indentation when shifting lines "
set shiftwidth=4 " shift size after rounding "
set smartindent " smarter than indent "
set smarttab " smart tabbing "
set softtabstop=4 " number of spaces in tab when editing "
set tabstop=4 " default tab space "

" folding
set foldlevel=0 " default fold level "
set foldlevelstart=0 " start with folding at level 0 "
set foldmethod=syntax " marker, indent, syntax "
set foldnestmax=2 " deepest fold is 10 levels "
set modelines=1 " check end of file for folding instructions "
set nofoldenable " no fold by default (foldenable) "

" status
set cmdheight=1 " better display for message "
set laststatus=2 " always display the status bar "

" backup, swap, spelling
set nobackup " don't create backup files "
set nospell " disable spelling highlights "
set noswapfile " no swap files "
set nowritebackup " delete backup after write "

" search
set gdefault " default global search"
set hlsearch " highlight search results "
set ignorecase " case insensitive searching "
set incsearch " set incremental search, like modern browsers "
set magic " set magic on, for regex "
set nolazyredraw " don't redraw while executing macros "
set smartcase " case-sensitive if expression contains a capital letter "

" ignore files
set wildignore+=*.class
set wildignore+=*.pyc
set wildignore+=*.swp
set wildignore+=.DS_Store

" ignore directories
set wildignore+=*/.git/*
set wildignore+=*/bower_components/*
set wildignore+=*/node_modules/*

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
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" dev icons
Plug 'https://github.com/ryanoasis/vim-devicons'

" color schemes
Plug 'https://github.com/ayu-theme/ayu-vim'
Plug 'https://github.com/dracula/vim', { 'as': 'dracula' }
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/larsbs/vimterial_dark'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/mhartington/oceanic-next'

" plugins
" Plug 'https://github.com/tpope/vim-surround'
" Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/Yggdroot/indentLine'
" Plug 'https://github.com/alvan/vim-closetag'

" language support
" Plug 'https://github.com/zxqfl/tabnine-vim'
Plug 'https://github.com/sheerun/vim-polyglot'
" Plug 'https://github.com/mattn/emmet-vim'
" Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'https://github.com/posva/vim-vue'

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

" coc.nvim {{{

Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}

" extensions
Plug 'https://github.com/weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'https://github.com/josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'https://github.com/neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'https://github.com/neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
Plug 'https://github.com/neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}

" extensions
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-eslint',
    \ 'coc-git',
    \ 'coc-highlight',
    \ 'coc-jest',
    \ 'coc-json',
    \ 'coc-lines',
    \ 'coc-lists',
    \ 'coc-markdownlint',
    \ 'coc-marketplace',
    \ 'coc-pairs',
    \ 'coc-project',
    \ 'coc-python',
    \ 'coc-rls',
    \ 'coc-snippets',
    \ 'coc-xml',
    \]

" mappings: explorer
nnoremap <F7> :CocCommand explorer<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" functions
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

" disabled {{{

" javascript {{{

" Plug 'https://github.com/pangloss/vim-javascript'

" let g:javascript_plugin_jsdoc = 1

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

" Plug 'https://github.com/Yggdroot/LeaderF', { 'do': './install.sh' }

" " popup mode
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1
" let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
" let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

" let g:Lf_ShowDevIcons = 1
" let g:Lf_ShortcutF = "<leader>ff"
" noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
" noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
" noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
" noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

" " search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" noremap go :<C-U>Leaderf! rg --recall<CR>

" }}}

" taglist {{{

" Plug 'https://github.com/yegappan/taglist'

" let Tlist_Close_On_Select = 1
" let Tlist_Exit_OnlyWindow = 1
" let Tlist_GainFocus_On_ToggleOpen = 1
" let Tlist_Use_Right_Window = 1
" let Tlist_Process_File_Always = 1
" " let Tlist_Compact_Format = 1
" " let Tlist_Use_Horiz_Window = 1

" " show tags for only open file
" let Tlist_Show_One_File = 1

" " show taglist
" nnoremap <silent> <F8> :TlistToggle<CR>

" }}}

" }}}

call plug#end()

" }}}

" auto commands {{{

augroup configgroup
    au!

    " workaround some broken plugins which set guicursor indiscriminately"
    au OptionSet guicursor noautocmd set guicursor=

    au VimEnter * highlight clear SignColumn
    au FileType zsh setlocal foldmethod=marker foldlevel=0 foldenable
    au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable

    " quit readonly files with q instead of :q
    au FileType help noremap <buffer> q :bd<cr>

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
nnoremap <leader>ff gg=G<CR>

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
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

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
