" File:        .vimrc
" Author:      Gustavo Picon <tabo@aurealsys.com>
" Last Change: 2005 Feb 11 (Vim 6.3)
" Download:    http://tabo.aurealsys.com/code/vimrc
" Home:        http://tabo.aurealsys.com/
" License:     This file is placed in the publid domain
" Disclaimer:  Published as-is, no support, no warranty


set nocompatible               " VIM extensions, not very VI compatible;
                               "   this setting must be set because when vim
                               "   finds a .vimrc on startup, it will set
                               "   itself as "compatible" with vi

"
" User Interface
"

" Syntax highlighting, only if the feature is available and the terminal can
" display colors
" (tabo@20040210) had to fix this because t_Co doesn't work in gvim@win32
if has('syntax') && (&t_Co > 2 || has('win32'))
    syntax on                  " enable syntax highlighting
    colorscheme default        " load a colorscheme, it's redundant to use
                               "   'default', but this setting is here to be
                               "   modified
endif


set backspace=indent,eol,start " backspace for dummys
set showmatch                  " show matching brackets/parenthesis
set wildmode=list:longest,full " comand <Tab> completion, list matches and
                               "   complete the longest common part, then,
			       "   cycle through the matches
set shortmess+=filmnrxoOtT     " abbrev. of messages (avoids 'hit enter')
set showmode                   " display the current mode

if has('cmdline_info')
    set ruler                  " show the ruler
    " a ruler on steroids
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd                " show partial commands in status line and
                               "   selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=1           " show statusline only if there are > 1 windows
    " a statusline, also on steroids
    set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P
endif

"
" Editing
"

filetype on                    " enable filetype detection
set wrap                       " wrap long lines
set autoindent                 " indent at the same level of the previous line
"set shiftwidth=4               " use indents of 4 spaces
"set tabstop=4                  " use tabs of 4 spaces
set textwidth=0                " no auto wrapping
"set formatoptions+=tcq        " basic formatting of text and comments
set matchpairs+=<:>            " match, to be used with % 
"set expandtab                  " spaces instead of tabs, CTRL-V<Tab> to insert
                               " a real space
set pastetoggle=<F12>          " pastetoggle (sane indentation on pastes)
                               "   just press F12 when you are going to
                               "   paste several lines of text so they won't
                               "   be indented
                               "   When in paste mode, everything is inserted
                               "   literally.
set cinoptions=:0,l1,t0,g0

autocmd FileType c,cpp call <SID>cstuff()
function <SID>cstuff()
    set cindent
    set formatoptions+=croql
    set formatoptions-=t
endfunction

"
" gvim- (here instead of .gvimrc)
"

if has('gui_running') 
    set guioptions-=T          " remove the toolbar
    set lines=40               " 40 lines of text instead of 24,
                               "   perfect for 1024x768
endif

"
" misc, there is _always_ a misc section
"

set nobackup                   " real men _never_ _ever_ do backups

" i have been working with cobol lately, the horror
au BufNewFile,BufRead *.CBL,*.cbl,*.cob     setf cobol



" to please the gods
iabbrev cthuf Ia! Ia! Cthulhu fhtagn! Ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn! Cthulhu fhtagn! Cthulhu fhtagn!


" vim: set sw=4 ts=8 sts=0 et tw=78 nofen fdm=indent ft=vim :

map <F5> $a<CR><Home><ESC>d$a/* Modified by JW Wang */<CR><CR><HOME>/***********************/<HOME><UP><ESC>
map <F6> $a<CR><Home><ESC>d$a#if defined(__DIFT_ENABLED__)<CR><CR><HOME>#endif<UP>
map <F7> <F5><UP><F6>

if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
    set cscopetag
    set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
endif

map <F8> <ESC>:call QFSwitch()<CR>
function! QFSwitch()
redir => ls_output
execute ':silent! ls'
redir END

let exists = match(ls_output, "[Quickfix List")
if exists == -1
execute ':copen'
else
execute ':cclose'
endif
endfunction

nmap <C-[>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-[>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-[>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

map q<LEFT> :WMToggle<cr> 

set ls=2
set nobackup
set cursorline
set title
set scrolloff=5
set foldmethod=syntax
set foldlevel=99
set foldnestmax=10
set smartindent
highlight Folded ctermbg=NONE ctermfg=green
highlight Macro ctermfg=LightBlue
map z<RIGHT> zo
map z<LEFT> zc

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

set number

" *********************************************************************************************
" comments.vim  
" *********************************************************************************************
" Description : Global Plugin to comment and un-comment different 
"               source files in both normal and visual <Shift-V> mode
" Last Change : 26th April, 2006
" Created By  : Jasmeet Singh Anand <jasanand@hotmail.com>
" Version     : 2.2
" Usage       : For VIM 6 -
"               Stick this file in your ~/.vim/plugin directory or 
"               in some other 'plugin' directory that is in your runtime path
"               For VIM 5 -
"               Stick this file somewhere and 'source <path>/comments.vim' it from
"               your ~/.vimrc file
" Note        : I have provided the following key mappings
"               To comment    <Ctrl-C> in both normal and visual <Shift-V> range select mode
"               To un-comment <Ctrl-X> in both normal and visual <Shift-V> range select mode
"               These can be changed based on user's likings or usage
" Contact     : For any comments or bug fixes email me at <jasanand@hotmail.com>
" *********************************************************************************************
 "Modification:
" *********************************************************************************************
" Jasmeet Anand  26th April, 2006 v2.0 
" Fixed C commenting where a single line already had previous comments.
" int x=0; /*this is an x value*/
" Still working on situations like
" Issue A:
" 1 int x=0; /*this
" 2           is 
" 3           an
" 4           x
" 5           value*/
" *********************************************************************************************
" Jasmeet Anand  26th April, 2006 v2.1
" Provided more granule checking for C Code but still working on Issue A
" *********************************************************************************************
" Jasmeet Anand  27th April, 2006 v2.2
" Fixed another minor C code commenting bug
" Provided for .csh, .php, .php2 and .php3 support
" Resolved Issue A with the following logic 
" 1 /* int x=0; */ /*this*/
" 2           /*is*/ 
" 3           /*an*/
" 4           /*x*/
" 5           /*value*/
" However care should be taken when un-commenting it
" in order to retain the previous comments  
" *********************************************************************************************
" Jasmeet Anand  1st May 2006 v2.3
" Provided [:blank:] to accomodate for space and tab characters
" *********************************************************************************************
" Jasmeet Anand  1st May 2006 v2.4
" Provided support for .css as advised by Willem Peter
" *********************************************************************************************
" Jasmeet Anand  2nd May 2006 v2.5
" Removed auto-indenting for .sql, .sh and normal files when un-commenting
" *********************************************************************************************
" Jasmeet Anand  5th June 2006 v2.6
" Added support for .html, .xml, .xthml, .htm, .vim, .vimrc
" files as provided by Jeff Buttars
" *********************************************************************************************
" Smolyar "Rastafarra" Denis 7th June 2007 v2.7
" Added support for .tex
" *********************************************************************************************
" Jasmeet Anand  5th June 2006 v2.8
" Added support for Fortran .f, .F, .f90, .F90, .f95, .F95
" files as provided by Albert Farres
" *********************************************************************************************
" Jasmeet Anand  8th March 2008 v2.9
" Added support for ML, Caml, OCaml .ml, mli, PHP (v.4) .php4, PHP (v.5) .php5
" files as provided by Denis Smolyar
" Added support for noweb (requires only a small enhancement to the tex type)
" as provided by Meik "fuller" Teßmer
" Added support for vhdl files provided by Trond Danielsen
" *********************************************************************************************
" Jasmeet Anand 20 th March 2008 v2.10
" Bug fixes for php files as pointed by rastafarra
" *********************************************************************************************
" Jasmeet Anand 29th November 2008 v2.11
" Added support for haskel
" files as provided by Nicolas Martyanoff
" File Format changed to UNIX
" *********************************************************************************************
" Jasmeet Anand 11th January 2009 v2.12
" bug fix for haskel files as prpvided by Jean-Marie
"

" Exit if already loaded
if exists("loaded_comments_plugin")
  finish
endif

let loaded_comments_plugin="v2.10"

" key-mappings for comment line in normal mode
noremap  <silent> <C-C> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <C-C> :call RangeCommentLine()<CR>

" key-mappings for un-comment line in normal mode
noremap  <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>

" function to comment line in normal mode
function! CommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java or .C files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal ^i//\<ESC>==\<down>^"
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    " if there are previous comments on this line ie /* ... */
    if stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\([^\\/\\*]*\\)\\(\\/\\*.*\\*\\/\\)/\\1\\*\\/\\2/\<CR>:s/\\([^[:blank:]]\\+\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there is a /* but no */ like line 1 in Issue A above
    elseif stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\)\\(\\/\\*.*$\\)/\\/\\*\\1\\*\\/\\2\\*\\//\<CR>:nohlsearch\<CR>=="
    " if there is a */ but no /* like line 5 in Issue A above
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\*\\/\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there are no comments on this line
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal ^i/*\<ESC>$a*/\<ESC>==\<down>^"
    endif
  "for .ml or .mli files use (* *)
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli$'
    if stridx(getline("."), "\(\*") == -1 && stridx(getline("."), "\*)") == -1
      execute ":silent! normal ^i(*\<ESC>$a*)\<ESC>==\<down>^"
    endif
    " .html,.xml,.xthml,.htm
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    if stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) != -1
    elseif stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) == -1
        "  open, but a close "
       execute ":silent! normal ^A--\>\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) != -1
       execute ":silent! normal ^i\<\!--\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) == -1
       execute ":silent! normal ^i\<\!--\<ESC>$a--\>\<ESC>==\<down>^"
    endif
  " for .vim files use "
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
	 execute ":silent! normal ^i\"\<ESC>\<down>^"
  " for .sql files use --
  elseif file_name =~ '\.sql$'
    execute ":silent! normal ^i--\<ESC>\<down>^"
  " for .ksh or .sh or .csh or .pl or .pm files use #
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal ^i#\<ESC>\<down>^"
  " for .tex files use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal ^i%\<ESC>\<down>^"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^gIC\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal ^i!\<ESC>\<down>^"
  " for VHDL and Haskell files use -- 
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal ^gI-- \<ESC>\<down>^"
  " for all other files use # 
  else
    execute ":silent! normal ^i#\<ESC>\<down>^"
  endif
endfunction

" function to un-comment line in normal mode
function! UnCommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java or .C files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\/\\///\<CR>:nohlsearch\<CR>=="
  " for .ml or .mli
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli$'
    execute ":silent! normal :nohlsearch\<CR>:s/(\\*//\<CR>:nohlsearch\<CR>"
	execute ":silent! normal :nohlsearch\<CR>:s/\\*)//\<CR>:nohlsearch\<CR>=="
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\/\\*//\<CR>:s/\\*\\///\<CR>:nohlsearch\<CR>=="
  " for .vim files use "
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\\"//\<CR>:nohlsearch\<CR>"
  " for .sql files use --
  elseif file_name =~ '\.sql$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\-\\-//\<CR>:nohlsearch\<CR>"
  " for .ksh or .sh or .csh or .pl or .pm files use #
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\#//\<CR>:nohlsearch\<CR>"
  " for .xml .html .xhtml .htm use <!-- -->
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    execute ":silent! normal :nohlsearch\<CR>:s/<!--//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/-->//\<CR>=="
  " for .tex use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal :nohlsearch\<CR>:s/%/\<CR>:nohlsearch\<CR>"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^x\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal :nohlsearch\<CR>:s/!//\<CR>:nohlsearch\<CR>"
  " for VHDL and Haskell files use --
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal :nohlsearch\<CR>:s/-- //\<CR>:nohlsearch\<CR>"
  " for all other files use # 
  else
    execute ":silent! normal :nohlsearch\<CR>:s/\\#//\<CR>:nohlsearch\<CR>"
  endif
endfunction

" function to range comment lines in visual mode
function! RangeCommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java or .C files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal :s/\\S/\\/\\/\\0/\<CR>:nohlsearch<CR>=="
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    " if there are previous comments on this line ie /* ... */
    if stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\([^\\/\\*]*\\)\\(\\/\\*.*\\*\\/\\)/\\1\\*\\/\\2/\<CR>:s/\\([^[:blank:]]\\+\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there is a /* but no */ like line 1 in Issue A above
    elseif stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\)\\(\\/\\*.*$\\)/\\/\\*\\1\\*\\/\\2\\*\\//\<CR>:nohlsearch\<CR>=="
    " if there is a */ but no /* like line 5 in Issue A above
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\*\\/\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there are no comments on this line
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal :s/\\(\\S.*$\\)/\\/\\*\\1\\*\\//\<CR>:nohlsearch\<CR>=="
    endif
  " .html,.xml,.xthml,.htm
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    if stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) != -1
    elseif stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) == -1
        "  open, but a close "
       execute ":silent! normal ^A--\>\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) != -1
       execute ":silent! normal ^i\<\!--\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) == -1
       execute ":silent! normal ^i\<\!--\<ESC>$a--\>\<ESC>==\<down>^"
    endif
   " for .ml, .mli files use (* *)
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli'
    if stridx(getline("."), "\(\*") == -1 && stridx(getline("."), "\*)/") == -1
      execute ":silent! normal ^i\(*\<ESC>$a*)\<ESC>==\<down>^"
	endif
  " for .vim files use --
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
    execute ":silent! normal :s/\\S/\\\"\\0/\<CR>:nohlsearch<CR>"
  " for .sql files use --
  elseif file_name =~ '\.sql$'
    execute ":silent! normal :s/\\S/\\-\\-\\0/\<CR>:nohlsearch<CR>"
  " for .ksh or .sh or .csh or .pl or .pm files use #
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal :s/\\S/\\#\\0/\<CR>:nohlsearch<CR>"
  " for .tex use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal :s/\\S/\\%\\0/\<CR>:nohlsearch<CR>"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^gIC\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal :s/\\S/!\\0/\<CR>:nohlsearch<CR>"
  " for VHDL and Haskell files use --
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal ^gI-- \<ESC>\<down>^"
  " for all other files use #  
  else
    execute ":silent! normal :s/\\S/\\#\\0/\<CR>:nohlsearch<CR>"
  endif
endfunction

" function to range un-comment lines in visual mode
function! RangeUnCommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal :s/\\/\\///\<CR>:nohlsearch\<CR>=="
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\/\\*//\<CR>:s/\\*\\///\<CR>:nohlsearch\<CR>=="
  " for .vim files use " 
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
    execute ":silent! normal :s/\\\"//\<CR>:nohlsearch\<CR>"
  " for .sql files use -- 
  elseif file_name =~ '\.sql$'
    execute ":silent! normal :s/\\-\\-//\<CR>:nohlsearch\<CR>"
  " for .ml .mli
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli$'
    execute ":silent! normal :nohlsearch\<CR>:s/(\\*//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/\\*)//\<CR>=="
  " for .xml .html .xhtml .htm use <!-- -->
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    execute ":silent! normal :nohlsearch\<CR>:s/<!--//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/-->//\<CR>=="
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal :s/\\#//\<CR>:nohlsearch\<CR>"
  " for .tex use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal :s/%/\<CR>:nohlsearch\<CR>"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^x\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal :s/!//\<CR>:nohlsearch\<CR>"
  " for VHDL and Haskell files use --
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal :s/-- //\<CR>:nohlsearch\<CR>"
  " for all other files use # 
  else
    execute ":silent! normal :s/\\#//\<CR>:nohlsearch\<CR>"
  endif
endfunction

"let g:xml_syntax_folding=1
au syntax mason so /usr/share/vim/vim73/syntax/mason.vim
au BufNewFile,BufRead *.mas,*.mi set ft=mason
set hlsearch

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au BufRead /tmp/mutt-* set tw=72

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
"set colorcolumn=80

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
