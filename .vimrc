" set shell=/bin/sh

let g:pathogen_disabled = ["vimside","vim-easytags","python-mode","jedi-vim"]

let maplocalleader = ","
let vimrplugin_assign = 0

let s:uname = system('uname -n | tr "\n" " "')

"my additions
nmap =p :r !pbpaste<CR>
nmap =yy :.!pbcopy<CR>u
map =y !pbcopy<CR>u
nmap "h :nohl<CR>

autocmd filetype tex,plaintex,text set spell
autocmd filetype tex,plaintex,text hi clear SpellBad
autocmd filetype tex,plaintex,text hi SpellBad cterm=undercurl ctermfg=red
map <F5> :setlocal spell! spelllang=en_us<CR>


" lhs comments
map ,# :s/^/#/<CR>:nohl<CR>
map ,/ :s/^/\/\//<CR>:nohl<CR>
map ,> :s/^/> /<CR>:nohl<CR>
map ," :s/^/\"/<CR>:nohl<CR>
map ,% :s/^/%/<CR>:nohl<CR>
map ,! :s/^/!/<CR>:nohl<CR>
map ,; :s/^/;/<CR>:nohl<CR>
map ,- :s/^/--/<CR>:nohl<CR>
map ,<S-Tab> :s/^\/\/\\|^--\\|^> \\|^[#"%!;\t]//<CR>:nohl<CR>
map ,<Tab> :s/^/<Tab>/<CR>:nohl<CR>

" CtrlP
map ,f. :CtrlP .<CR>

" Tabular
:map "t= :Tab /=<CR>
:map "t< :Tab /<-<CR>
:map "t: :Tab /:<CR>
:map "t+ :Tab /+<CR>
:map "t( :Tab /(<CR>
:map "t) :Tab /)<CR>
:map "t# :Tab /#<CR>

"Buffer explorer

map "b :BufExplorer<CR>
map "bv :BufExplorerVerticalSplit<CR>
map "bh :BufExplorerHorizontalSplit<CR>
map "p :b#<CR>

" netrw - native substitut to nerdTree
let g:netrw_altv = 3
map ,e :Vexplore<cr>

" XPtemplate
let g:xptemplate_key = '<C-_>'

set omnifunc=syntaxcomplete#Complete

" Interact with spark shell
if (s:uname == "WDBED2900300 " )
  let g:sparkVersion = "1.3.0"
  let g:inTmux       = 1
  let g:sparkOptions = "--master local[10] --driver-memory 6G --executor-memory 6G"
elseif (s:uname == "apas2.srv.be.europe.intranet " )
  let g:inTmux       = 1
  let g:sparkOptions = "--master yarn-client  --driver-memory 4g --executor-memory 8g --num-executors 8 --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer'"
elseif (s:uname == "apa03 " )
  let g:sparkVersion = "1.5.1"
  let g:inTmux       = 1
  let g:sparkOptions = "--master local[6] --driver-memory 1G --executor-memory 1.5G"
elseif (s:uname == "user-PC ")
  let g:sparkVersion = "1.3.1"
  let g:inTmux       = 1
  let g:sparkOptions = "--master local[4]"
else
  let g:sparkVersion = "1.6.2"
  let g:inTmux         = 1
  let g:sparkOptions = ""
endif

autocmd filetype scala,python noremap ,ss :call StartSparkShell(g:sparkOptions)<CR>
autocmd filetype scala,python noremap ,sk :call StopSparkShell()<CR>
autocmd filetype scala,python noremap ,sa :1,$ call SparkShellSendMultiLine()<CR>

autocmd filetype scala,python nnoremap ,l  :call SparkShellSendLine()<CR>
autocmd filetype scala,python nnoremap ,su :call SparkShellSendKey("<C-R><C-W>")<CR><Esc>
autocmd filetype scala,python nnoremap ,sp :call SparkShellEnterPasteEnv()<CR>
autocmd filetype scala,python nnoremap ,se :call SparkShellExitPasteEnv()<CR>
autocmd filetype scala,python nnoremap ,sc :call SparkShellSendKey("<C-R><C-W>.count()\r")<CR><Esc>
autocmd filetype scala        nnoremap ,st :call SparkShellSendKey("<C-R><C-W>.take(5).foreach(println)\r")<CR><Esc>
autocmd filetype       python nnoremap ,st :call SparkShellSendKey("for e in <C-R><C-W>.take(5) : print(e)\r\r")<CR><Esc>
autocmd filetype scala,python nnoremap ,so :call SparkShellSendKey("<C-R><C-W>\r")<CR><Esc>

" on data frames
autocmd filetype scala,python nnoremap ,sdt :call SparkShellSendKey("<C-R><C-W>.show()\r")<CR><Esc>
autocmd filetype scala,python nnoremap ,sdtf :call SparkShellSendKey("<C-R><C-W>.show(5)\r")<CR><Esc>
autocmd filetype scala,python nnoremap ,sds :call SparkShellSendKey("<C-R><C-W>.printSchema()\r")<CR><Esc>
autocmd filetype scala,python nnoremap ,sdd :call SparkShellSendKey("<C-R><C-W>.describe(<C-R><C-W>.columns:_*).show()\r")<CR><Esc>


autocmd filetype scala,python vnoremap ,so y:call SparkShellSendKey(substitute('<C-R>0',"\"","\\\"","")."\r")<CR>
autocmd filetype scala,python vnoremap ,l  :call SparkShellSendMultiLine() <CR>

" Additional R mappings


"vimux
let g:VimuxHeight = "40"

"autocmd filetype R nnoremap   :Twrite 0<CR>

" Jedi
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

"cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" tags
set tags+=$HOME/bin/spark-repo/tags

"Scala doc

autocmd FileType scala nnoremap <leader>sd :ScalaDoc <C-R><C-W><cr>
let g:scaladoc_paths = "http://spark.apache.org/docs/1.2.1/api/scala"

"" ipython macvim
"function! Send2IPython ()
"  execute "silent !osascript ~/.vim/ftplugin/python/ipyqtmacvim.scpt"
"endfunction
"
"" Command to send line or visual selection
"autocmd filetype python nmap ,l "+yy:call Send2IPython()<CR>
"autocmd filetype python imap ,l <ESC>"+yy:call Send2IPython()<CR>gi
"autocmd filetype python vmap ,s "+y:call Send2IPython()<CR>
"
"" Command to run entire file
"autocmd filetype python nmap ,a :let @+='run '.expand('%:p')<CR>:call Send2IPython()<CR>
"autocmd filetype python imap ,a <ESC>:let @+='run '.expand('%:p')<CR>:call Send2IPython()<CR>gi
"
" folding

"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview 
"
set foldmethod=marker

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

""""""
" of Derek WyattA
"
" pathogen
" execute pathogen#infect()
execute pathogen#infect('bundle/{}', '~/vim_local/{}')
syntax on
"filetype plugin indent on

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
" set listchars=tab:▸\ ,eol:¬
" set listchars=tab:-\ ,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" powerline configuration
set encoding=utf-8
let g:Powerline_symbols = 'fancy'
"set guifont=Inconsolata\ For\ Powerline
set rtp+=/usr/local/lib/python2.7/dist-packages/Powerline-beta-py2.7.egg/powerline/bindings/vim/
set laststatus=2

" line numbers
set number
:highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" eclim
set nocompatible
filetype plugin indent on
" let g:EclimLogLevel = 10

" eclim color
"hi Pmenu ctermbg=darkgray ctermfg=gray guibg=darkgray guifg=#bebebe
"hi PmenuSel ctermbg=gray ctermfg=black guibg=#bebebe guifg=black
"hi PmenuSbar ctermbg=gray guibg=#bebebe
"hi PmenuThumb cterm=reverse gui=reverse

" http://stackoverflow.com/questions/1551231/highlight-variable-under-cursor-in-vim-like-in-netbeans
":autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" highlight unwanted(trailing) whitespace
" + have this highlighting not appear whilst you are typing in insert mode
" + have the highlighting of whitespace apply when you open new buffers
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
":highlight ExtraWhitespace ctermbg=red guibg=red
":autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

" Solarized
syntax on
set background=dark
let g:solarized_termcolors = 256
"colorscheme desert
if has("gui_running")
  colorscheme wombat
elseif &t_Co == 256
  colorscheme wombat256mod
endif



" leader key
let mapleader = ','

" searching
set ignorecase smartcase incsearch hlsearch

" don't display welcome
set shortmess+=I

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

"Always show current position
set ruler

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Turn backup off
set nobackup
set nowb
" set noswapfile
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Remap VIM 0 to first non-blank character
map 0 ^

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Format scala code
let g:scala_sort_across_groups=1
"au BufEnter *.scala setl formatprg=java\ -jar\ /Users/stefanb/Exec/scalariform.jar\ -f\ -q\ +alignParameters\ +alignSingleLineCaseStatements\ +doubleIndentClassDeclaration\ +preserveDanglingCloseParenthesis\ +rewriteArrowSymbols\ +preserveSpaceBeforeArguments\ --stdin\ --stdout
nmap <leader>m :SortScalaImports<CR>gggqG<C-o><C-o><leader><w>

" Tagbar (http://blog.stwrt.ca/2012/10/31/vim-ctags)
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" NerdTree
map <leader>n :NERDTreeToggle<cr>
"map <leader>r :NERDTreeFind<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Buffers - explore/next/previous: leader-u, Alt-F12, leader-p.
nnoremap <silent> <leader>u :BufExplorer<CR>
nnoremap <silent> <M-F12> :bn<CR>
nnoremap <silent> <leader>p :bp<CR>

" Replace word under cursor globally
nnoremap <Leader>a :%s/\<<C-r><C-w>\>/

" Replace word under cursor in line
nnoremap <Leader>s :s/\<<C-r><C-w>\>/

" remove whitespace http://vim.wikia.com/wiki/Remove_unwanted_spaces
" called by leader-m
:nnoremap <silent> <leader>dw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" ignoring/enabling tests
nmap <leader>in :%s/it("/ignore("/<CR>
nmap <leader>it :%s/ignore(/it(/<CR>

" pastetoggle http://stackoverflow.com/questions/2861627/paste-in-insert-mode
" set paste
set pastetoggle=<F2>

" Wildmenu completion: use for file exclusions"
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"
set wildignore+=*.class "java/scala class files"
set wildignore+=*/target/* "sbt target directory"

" Command-T Cache
"let g:CommandTMaxCachedDirectories=0

" Rainbow parantheses
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['gray',        'RoyalBlue3'],
      \ ['black',       'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\#/
  elseif ext == 'js' || ext == 'scala'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^\#//
  elseif ext == 'js' || ext == 'scala'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction

map <C-a> :call Comment()<CR>
map <C-b> :call Uncomment()<CR>

" colorcolumn / print margin
if version > 702
  set colorcolumn=120
endif

"-----------------------------------------------------------------------------
"" CtrlP Settings
"-----------------------------------------------------------------------------
" http://robots.thoughtbot.com/faster-grepping-in-vim/
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_switch_buffer = 'E'
let g:ctrlp_tabpage_position = 'c'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_root_markers = ['.project.root']
let g:ctrlp_custom_ignore = '\v%(/\.%(git|hg|svn)|\.%(class|o|png|jpg|jpeg|bmp|tar|jar|tgz|deb|zip)$|/target/%(quickfix|resolution-cache|streams)|/target/scala-2.10/%(classes|test-classes|sbt-0.13|cache)|/project/target|/project/project)'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = '1ri'
let g:ctrlp_match_window = 'max:40'
let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("j")':   ['<c-n>'],
      \ 'PrtSelectMove("k")':   ['<c-p>'],
      \ 'PrtHistory(-1)':       ['<c-j>', '<down>'],
      \ 'PrtHistory(1)':        ['<c-i>', '<up>']
      \ }
nmap ,fb :CtrlPBuffer<cr>
nmap ,ff :CtrlP .<cr>
nmap ,fF :execute ":CtrlP " . expand('%:p:h')<cr>
nmap ,fr :CtrlP<cr>
nmap ,fm :CtrlPMixed<cr>

"-----------------------------------------------------------------------------
"" FSwitch mappings
"-----------------------------------------------------------------------------
au BufEnter *.scala let b:fswitchlocs = 'reg:+/src/main/scala/+/src/test/scala/+,reg:+/src/test/scala/+/src/main/scala/+'
"if name is different:
"| let b:fswitchfnames='/$/Test/'
let b:fswitchdst = 'scala'
nmap <silent> ,of :FSHere<CR>
nmap <silent> ,ol :FSRight<CR>
nmap <silent> ,oL :FSSplitRight<CR>
nmap <silent> ,oh :FSLeft<CR>
nmap <silent> ,oH :FSSplitLeft<CR>
nmap <silent> ,ok :FSAbove<CR>
nmap <silent> ,oK :FSSplitAbove<CR>
nmap <silent> ,oj :FSBelow<CR>
nmap <silent> ,oJ :FSSplitBelow<CR>

"-----------------------------------------------------------------------------
"" resumes old cfg file
"-----------------------------------------------------------------------------
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" http://stackoverflow.com/questions/16743112/open-item-from-quickfix-window-in-vertical-split
autocm! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>Ld

" When the page starts to scroll, keep the cursor 8 lines from the top and 8 lines from the bottom
set scrolloff=8

" ZoomWin
nmap <leader>o <c-w>o

" workaround git gutter warning message
let g:gitgutter_max_signs=9999
