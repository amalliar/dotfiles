" File type based indentation.
filetype plugin indent on

" Copy and cut to system clipboard.
set clipboard=unnamedplus

" Change cursor shape in different modes.
let &t_SI = "\e[5 q" " SI = INSERT mode
let &t_SR = "\e[3 q" " SR = REPLACE mode
let &t_EI = "\e[1 q" " EI = NORMAL mode

" Fast toggling between modes.
set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Set automatic toggling between line number modes.
set number relativenumber
set cul
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Highlight all search pattern matches.
set hlsearch

" Use 24-bit (true-color) mode in Vim.
if (has("termguicolors"))
	set termguicolors
endif

" Set Vim colourscheme.
syntax on
"colorscheme onedark
colorscheme gruvbox
set background=dark

" Set block cursor upon entry.
silent execute "!echo -ne '\e[1 q'"

" Search for files recursively from the current PWD
set path=.,**

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set nowrap
set sidescroll=1
set scrolloff=5
set sidescrolloff=15
set smartcase

" vim-easymotion plugin ------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" ----------------------------------------------------------------------------
