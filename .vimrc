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
colorscheme onedark
syntax on

" Highlight trailing whitespace.
"highlight ExtraWhitespace ctermbg=red guibg=#ff7b86
"match ExtraWhitespace /\s\+$\|\s+\s{1}/

" Highlight strings over 80 characters long.
"highlight MoreThan80 ctermbg=red guibg=#ff7b86
":2match MoreThan80 /\%81v.\+/

" Set block cursor upon entry.
silent execute "!echo -ne '\e[1 q'"

" Search for files recursively from the current PWD
set path=.,**
