syntax on

set encoding=UTF-8
set path+=**
set wildmenu
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set display+=lastline
set scrolloff=1
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

    Plug 'ryanoasis/vim-devicons'

	Plug 'moll/vim-bbye' " optional dependency

    Plug 'aymericbeaumet/vim-symlink'

    Plug 'mbbill/undotree'

    Plug 'jremmen/vim-ripgrep'

	Plug 'morhetz/gruvbox'

    Plug 'vim-utils/vim-man'
	Plug 'git@github.com:kien/ctrlp.vim.git'

    Plug 'sheerun/vim-polyglot'
    Plug 'jparise/vim-graphql'
    Plug 'leafgarland/typescript-vim'
    Plug 'HerringtonDarkholme/yats.vim'


	Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
    Plug 'mileszs/ack.vim'
	Plug 'jiangmiao/auto-pairs'

    Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'enricobacis/vim-airline-clock'
	Plug 'lambdalisue/battery.vim'

    Plug '907th/vim-auto-save'
	Plug 'mattn/emmet-vim'

call plug#end()

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git" | rg ""'

let g:coc_global_extensions = [
      \ 'coc-tsserver'
      \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

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

hi Normal guibg=NONE ctermbg=NONE

let loaded_matchparen = 1
let mapleader = " "
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-star']
let g:ctrlp_use_caching = 0


if !has('gui_running')
    set t_Co=256
endif

let &t_TI = ""
let &t_TE = ""


let g:auto_save = 1

let g:airline_powerline_fonts = 1

set signcolumn=number

map <F2> :echo 'Current time is ' . strftime('%c')<CR>

let g:netrw_banner = 0

nnoremap <leader>n :if &ft ==# "netrw" ""<CR>:Rexplore<CR>else<CR>:Explore<CR>endif<CR><CR>
nnoremap <Leader>u :UndotreeShow<CR>

nnoremap <Leader>f :Files<CR>

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>v :vs<CR>
nnoremap <Leader>t :Rg<CR>
nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

nmap <Leader>rn <Plug>(coc-rename)

nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd StdinReadPre * let s:std_in=1

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

