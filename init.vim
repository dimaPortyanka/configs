syntax on

set encoding=UTF-8
set path+=**
set wildmenu
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set listchars=eol:$
set colorcolumn=120
set shortmess+=c
set autoread
set incsearch
set ignorecase
set smartcase
set autowrite
set so=15
set cmdheight=1
set updatetime=750
set nofixendofline
set showmatch
set noshowmode
set laststatus=2

highlight ColorColumn ctermbg=0 guibg=lightgrey

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'jremmen/vim-ripgrep'
	Plug 'morhetz/gruvbox'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'git@github.com:Quramy/tsuquyomi.git'
	Plug 'vim-utils/vim-man'
	Plug 'lyuts/vim-rtags'
	Plug 'git@github.com:kien/ctrlp.vim.git'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'tweekmonster/gofmt.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/gv.vim'

	Plug 'tpope/vim-surround'
	Plug 'mbbill/undotree'
	Plug 'sheerun/vim-polyglot'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'mileszs/ack.vim'
	Plug 'jiangmiao/auto-pairs'

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'enricobacis/vim-airline-clock'
	Plug 'lambdalisue/battery.vim'
	Plug 'w0rp/ale'
	Plug '907th/vim-auto-save'
	Plug 'mattn/emmet-vim'

	Plug 'majutsushi/tagbar'

call plug#end()

if executable('rg')
    let g:rg_derive_root='true'
endif

if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set background=dark

set termguicolors     " enable true colors support
colorscheme gruvbox

let loaded_matchparen = 1
let mapleader = " "
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-star']
let g:ctrlp_use_caching = 0
let g:netrw_browse_split = 3
let g:netrw_banner = 0

let g:NERDTreeGitStatusConcealBrackets = 1
let g:netrw_winsize = 35

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1

if !has('gui_running')
    set t_Co=256
endif


let &t_TI = ""
let &t_TE = ""

let g:auto_save = 1

let g:airline_powerline_fonts=1
let g:airline#extensions#ale#enabled = 1
let g:battery#update_statusline = 1

let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'javascript': ['eslint'],
            \}

let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 1
let g:ale_fix_on_save = 1

map <F2> :echo 'Current time is ' . strftime('%c')<CR>

nnoremap <Leader>u :UndotreeShow<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>n :NERDTreeFind<CR>
nnoremap <Leader>v :vs<CR>
nnoremap <Leader>t :Rg<CR>
nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

nmap <silent> gn <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <Leader>rn <Plug>(coc-rename)
nmap <F8> :TagbarToggle<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
