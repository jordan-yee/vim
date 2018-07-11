" Enable many features
if &compatible
  set nocompatible
endif

" Load Pathogen packages
execute pathogen#infect()
Helptags

" GUI
if has('gui_running')
  au GUIEnter * simalt ~x " Start fullscreen
  set guioptions -=m      " Remove menubar
  set guioptions -=T      " Remove toolbar

  " Miscelaneous settings
  colorscheme molokai
  set guifont=Source_Code_Pro:h11:cANSI:qDRAFT
  set scrolloff=1         " Show a few lines of context around the cursor
else
  colorscheme darkblue
endif

" Enable mouse actions
if has('mouse')
  set mouse=a
endif

" Miscelaneous Defaults
syntax on
filetype plugin indent on
set number
set relativenumber
set backspace=indent,eol,start
set history=200         " Keep 200 lines of command line history
set ruler               " Show the cursor position all the time
set showcmd             " Display incomplete commands
set wildmenu            " Display completion matches in a status line
set incsearch           " Highlight search results while typing search term
set autoread            " Automatically files modified outside vim
set laststatus=2        " The last window will always have a status line
set formatoptions+=j    " Delete comment character when joining commented lines
set nowrap

" Show trailing whitespace
highlight ExtraWhitespace ctermbg=DarkGray guibg=#333333 guifg=#666666
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
set list listchars=tab:>-,trail:·

" Remove trailing whitespace on write
function! StripTrailingWhitespace()
  normal mZ
  let l:chars = col("$")
  %s/\s\+$//e
  if (line("'Z") != line(".")) || (l:chars != col("$"))
    echo "Trailing whitespace stripped\n"
  endif
  normal `Z
endfunction
autocmd BufWritePre * call StripTrailingWhitespace()

" Autocompletion
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,longest,preview
"highlight Pmenu guibg=#ffaf00 guifg=#404042 gui=bold
" Enter key selects highlighted completion item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Highlight first match with <C-n>
inoremap <expr> <silent> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" SuperTab
let g:SuperTabLongestHighlight=1

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Binding for quicker return to normal mode
imap jk <Esc>

" Indentation settings
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Optional Packages
if has('syntax') && has('eval')
  packadd matchit
endif

" Open command prompt by running :Cp
if !exists(":Cp")
  command Cp :!start cmd /k cd %:p:h<CR>
endif

" Open windows explorer by running :We
if !exists(":We")
  command We :!start Explorer /select,%:p<CR>
endif

" Switch to most recently open buffer with ALT-`
nmap <M-`> :b#<cr>

" Rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Set <Space> to leader key
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=" "

" vim-sexp custom mappings
let g:sexp_mappings = {
      \ 'sexp_emit_head_element':         '<LocalLeader>B',
      \ 'sexp_emit_tail_element':         '<LocalLeader>b',
      \ 'sexp_capture_prev_element':      '<LocalLeader>S',
      \ 'sexp_capture_next_element':      '<LocalLeader>s',
      \ }

" CtrlP
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard']

" vim-table-mode
let g:table_mode_corner='|'

" fugitive
set statusline=[%n]
set statusline+=\ %f\ %h%m%r
set statusline+=\ \ %{fugitive#statusline()}
set statusline+=%=%c
set statusline+=%=\ %l/%L

" Go to quickfix prev/next
nnoremap <C-up> :cN<cr>
nnoremap <C-down> :cn<cr>

" Set indent folding by default
set foldmethod=indent
