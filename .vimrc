" ************************************************************************
set exrc
set secure
set nocompatible
filetype off
set fileformats=unix,dos,mac
set viminfo=
" Windows Stuff
"source $VIMRUNTIME/mswin.vim
"behave mswin

" ************************************************************************
" Vundle Bundle Manager
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
" Let Vundle manage Vundle
" Required!
Bundle 'VundleVim/Vundle.vim'
" Additional Bundles
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bundings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle 'vim-scripts/closetag.vim'
Bundle 'fholgado/minibufexpl.vim'
" Optional for snipmate:
Bundle "honza/vim-snippets"
Bundle "tclem/vim-arduino"
" Text doc stuff
Bundle "jceb/vim-orgmode"
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" ************************************************************************
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" ************************************************************************
" Settings

" Tabs and indents
set autoindent                          " set the cursor at same indent as line above
set smartindent                         " try to be smart about indenting (C-style)
set expandtab                           " expand <Tab>s with spaces; death to tabs!
set shiftwidth=4                        " spaces for each step of (auto)indent
set softtabstop=4                       " set virtual tab stop (compat for 8-wide tabs)
set tabstop=8                           " for proper display of files with tabs
set shiftround                          " always round indents to multiple of shiftwidth
set copyindent                          " use existing indents for new indents
set preserveindent                      " save as much indent structure as possible
filetype plugin indent on               " load filetype plugins and indent settings

" Text editing and searching
set nohlsearch                          " turn off highlighting for searched expressions
set incsearch                           " highlight as we search however
set matchtime=5                         " blink matching chars for .x seconds
"set mouse=a                            " try to use a mouse in the console (wimp!)
set ignorecase                          " set case insensitivity
set smartcase                           " unless there's a capital letter
set completeopt=menu,longest,preview    " more autocomplete <Ctrl>-P options
set nostartofline                       " leave my cursor position alone!
set backspace=2                         " equiv to :set backspace=indent,eol,start
set textwidth=80                        " we like 80 columns
set showmatch                           " show matching brackets
set formatoptions=tcrql         

set ls=2
set nowrap
set backspace=indent,eol,start 
set hlsearch
set incsearch
set number
set showmatch
set title
set cmdheight=2
set ttyfast
set lazyredraw
set scrolloff=5
" set linebreak " Don't wrap words by default
set textwidth=0 
" set nobackup 
set viminfo='20,\"50 
set history=500
set ruler 
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set wildmenu
set wildmode=list:longest,full
set foldmethod=indent
set foldlevel=99
set autochdir
set background=dark
syntax on
colorscheme lucius
set colorcolumn=110
highlight ColorColumn ctermbg=darkgrey
set showcmd 
set autowrite 
set noerrorbells
set report=0
set visualbell

set makeprg=make\ -C\ ../build\ -j9

if has("gui_running")
	set guifont=Droid_Sans_Mono:h11
	set guioptions-=m  "remove menu bar
	set guifont=Droid\ Sans\ Mono\ 13
        nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set lines=40
	set columns=132
	set selectmode=mouse,key,cmd
	set mouse=a
else
	" nowt
endif

" ************************************************************************
" Key bindings
"
" Toggle Whitespace display

nmap <leader>l :set list!<CR>

map <F3> :sp ~/.vim/gerryhelp<CR>

vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Disable arrows to force use of hjkl

"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk

" ************************************************************************
" Terminal Colour Settings 

if &term =~ "xterm-debian" || &term =~ "xterm-xfree86" || &term =~ "xterm"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" ************************************************************************
" Auto commands

if has("autocmd")
    filetype plugin on
    filetype indent on
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    " Filetypes (au = autocmd)
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

    " When using mutt, text width=72
    au FileType mail,tex set textwidth=72
    "au FileType cpp,c,java,sh,pl,php,phtml,asp  set autoindent
    au FileType cpp,c,java,sh,pl,php,phtml,asp,xml,javascript  set smartindent
    nnoremap <C-p> :set invpaste paste?<CR>
    set pastetoggle=<C-p>
    set showmode
    "au FileType cpp,c,java,sh,pl,php,phtml,asp  set cindent
    au BufRead mutt*[0-9] set tw=72
    " Automatically chmod +x Shell and Perl scripts
    "au BufWritePost   *.sh             !chmod +x %
    "au BufWritePost   *.pl             !chmod +x %
    " File formats
    au BufRead,BufNewFile *.pde set filetype=arduino
    au BufRead,BufNewFile *.ino set filetype=arduino
    au BufNewFile,BufRead  *.phtml  set syntax=php
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
    " Ctrl+X O
    " Don't use Omnicomplete for Python... we use Python-Mode istead
    " autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType cpp set omnifunc=ccomplete#Complete
    autocmd FileType php noremap <C-L> :!php -l %<CR>
    autocmd Filetype html,xml,xsl source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
    " autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class 
    " autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``	

    " Make Sure that Vim returns to the same line when we reopen a file"
    augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
    augroup END
    
    augroup vimrc_autocmds
        autocmd!
        " Highlight characters after column 80 (Python PEP8)
        autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
        autocmd FileType python match Excess /\%80v.*/
        autocmd FileType python set nowrap
    augroup END

    augroup filetype
        au BufRead reportbug.* set ft=mail
        au BufRead reportbug-* set ft=mail
    augroup END

    augroup project
        autocmd!
        autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
    augroup END

endif " has ("autocmd")

" ************************************************************************
try
  if filereadable('/etc/papersize')
    let s:papersize = matchstr(system('/bin/cat /etc/papersize'), '\p*')
    if strlen(s:papersize)
      let &printoptions = "paper:" . s:papersize
    endif
    unlet! s:papersize
  endif
catch /E145/
endtry

" ************************************************************************
" Plugin Settings "
" Powerline Setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

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
let g:pymode_lint_checker = ["pep8","pyflakes"]
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

let g:pymode_indent = 1

" wildmenu options
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

" Mapping to NERDTree
nnoremap <F2> :NERDTreeToggle<cr>
"nnoremap <C-n> :NERDTreeToggle<cr>

" Mini Buffer some settigns." (Deprecated)
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"

" Key mappings for global & local search/replace - refactor renames.
" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" " For global replace
 nnoremap gR gD:%s/<C-R>///gc<left><left><left>
" New MiniBufExplorer settings
nmap <F4> :MBEToggle<CR>
noremap <C-TAB> :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>
noremap <M-.> :MBEbn<CR>
noremap <M-,> :MBEbp<CR>
" Hack for Putty
noremap <ESC>[B  <C-W>j
noremap <ESC>[A  <C-W>k
noremap <ESC>[D  <C-W>h
noremap <ESC>[C  <C-W>l
" Standard Arrow Keys
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l

map <F5> :Bs

" Tagbar key bindings."
"nmap <leader>l <ESC>:TagbarToggle<cr>
"imap <leader>l <ESC>:TagbarToggle<cr>i
nmap <F8> :TagbarToggle<CR> 

" Tasklist keybindings
map T :TaskList<CR>
map P :TlistToggle<CR>


" ************************************************************************
" A B B R E V I A T I O N S 

abbr #b /************************************************************************
abbr #e  ************************************************************************/

"abbr hosts C:\WINNT\system32\drivers\etc\hosts

" abbreviation to manually enter a timestamp. Just type YTS in insert mode 

iab YTS <C-R>=TimeStamp()<CR>

" Date/Time stamps
" %a - Day of the week
" %b - Month

" %d - Day of the month
" %Y - Year
" %H - Hour
" %M - Minute
" %S - Seconds
" %Z - Time Zone

iab YDATETIME <c-r>=strftime(": %a %b %d, %Y %H:%M:%S %Z")<cr>

" ************************************************************************
"  F U N C T I O N S

" first add a function that returns a time stamp in the desired format 
if !exists("*TimeStamp")
    fun TimeStamp()

        return "Last-modified: " . strftime("%d %b %Y %X")
    endfun
endif

" searches the first ten lines for the timestamp and updates using the
" TimeStamp function
if !exists("*UpdateTimeStamp")
function! UpdateTimeStamp()

   " Do the updation only if the current buffer is modified 
   if &modified == 1
       " go to the first line
       exec "1"

      " Search for Last modified: 
      let modified_line_no = search("Last-modified:")
      if modified_line_no != 0 && modified_line_no < 10

         " There is a match in first 10 lines 
         " Go to the : in modified: 
         exe "s/Last-modified: .*/" . TimeStamp()
     endif

 endif
 endfunction
endif

function! BufSel(pattern)
    let bufcount = bufnr("$")
    let currbufnr = 1
    let nummatches = 0
    let firstmatchingbufnr = 0
    while currbufnr <= bufcount
        if(bufexists(currbufnr))
            let currbufname = bufname(currbufnr)
            if(match(currbufname, a:pattern) > -1)
                echo currbufnr . ": ". bufname(currbufnr)
                let nummatches += 1
                let firstmatchingbufnr = currbufnr
            endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
    if(nummatches == 1)
        execute ":buffer ". firstmatchingbufnr
    elseif(nummatches > 1)
        let desiredbufnr = input("Enter buffer number: ")
        if(strlen(desiredbufnr) != 0)
            execute ":buffer ". desiredbufnr
        endif
    else
    	echo "No matching buffers"
    endif
endfunction

command! -nargs=1 Bs :call BufSel("<args>")

