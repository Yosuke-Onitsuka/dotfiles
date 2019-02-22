"行番号を表示
set number

if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_path = expand('~/.cache/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)

  let g:config_dir  = expand('~/.cache/userconfig')
  let s:toml        = g:config_dir . '/plugin.toml'
  let s:lazy_toml   = g:config_dir . '/plugin_lazy.toml'

  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/dein.vim')
  call dein#add('mattn/vim-starwars')
  "call dein#add('Yggdroot/indentLine')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('osyo-manga/vim-watchdogs')
  call dein#add('scrooloose/nerdtree')
  " TOML 読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

"カラースキーム設定
colorscheme molokai
set background=dark
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none
"dein Scripts-----------------------------

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------
execute pathogen#infect()

"indentLine setting---------------------------------
"let g:indentLine_enabled = 1
"let g:indentLine_setColors = 0
"End indentLine-------------------------------------

"vim-indent-guides setting---------------------------
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
set ts=4 sw=4 et
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray
let g:indet_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']
"End vim-indent-guides-------------------------------

"NerdTree setting------------------------------------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
"tab->spase無効化
set expandtab

"hlsearchコマンド
let hlstate=0
map <C-h> :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<CR>
