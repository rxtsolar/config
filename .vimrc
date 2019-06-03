"" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'valloric/youcompleteme'
Plugin 'scrooloose/nerdtree'
" Plugin 'ajh17/vimcompletesme'
" Plugin 'ludovicchabant/vim-gutentags'
" Plugin 'OmniCppComplete'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"" YCM
nnoremap gk :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:ycm_confirm_extra_conf=0
let g:ycm_enable_diagnostic_signs=0
let g:ycm_add_preview_to_completeopt=0
let g:ycm_auto_trigger = 0
let g:ycm_key_invoke_completion = '<Tab>'
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
set completeopt-=preview

"" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" General
set nocompatible               " VIM extensions, not very VI compatible;
                               "   this setting must be set because when vim
                               "   finds a .vimrc on startup, it will set
                               "   itself as "compatible" with vi

"" Display
syntax on                      " enable syntax highlighting
colorscheme default            " load a colorscheme, it's redundant to use
                               "   'default', but this setting is here to be
                               "   modified
set showmatch                  " show matching brackets/parenthesis
set showmode                   " display the current mode
set ruler                      " show the ruler
set number
set hlsearch
" a ruler on steroids
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd                " show partial commands in status line and
                           "   selected characters/lines in visual mode
set laststatus=2           " show statusline only if there are > 1 windows
" a statusline, also on steroids
set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P
set cursorline
set title
set textwidth=80
set colorcolumn=+1
" Trailing whitespace and tabs are forbidden, so highlight them.
highlight ForbiddenWhitespace ctermbg=red guibg=red
match ForbiddenWhitespace /\s\+$\|\t/
" Do not highlight spaces at the end of line while typing on that line.
autocmd InsertEnter * match ForbiddenWhitespace /\t\|\s\+\%#\@<!$/

"" Control
set backspace=indent,eol,start " backspace for dummys
set wildmenu                   " command <Tab> completion
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn,.git,*.o,*~
set wildmode=list:longest
set shortmess+=filmnrxoOtT     " abbrev. of messages (avoids 'hit enter')
set ttyfast
set scrolloff=5
" copy paste across files
noremap <C-y> "*y
noremap <C-p> "*p

"" Editing
filetype on                    " enable filetype detection
set nowrap                     " no wrap long lines
set smartindent                " smart indent
set autoindent                 " indent at the same level of the previous line
set shiftwidth=4               " use indents of 4 spaces
set tabstop=4                  " use tabs of 4 spaces
set matchpairs+=<:>            " match, to be used with %
set expandtab                  " spaces instead of tabs, CTRL-V<Tab> to insert
                               " a real space
set pastetoggle=<F11>          " pastetoggle (sane indentation on pastes)
                               "   just press F11 when you are going to
                               "   paste several lines of text so they won't
                               "   be indented
                               "   When in paste mode, everything is inserted
                               "   literally.

"" C stuff
autocmd FileType c,cpp call <SID>cstuff()
function <SID>cstuff()
    set cindent
    set formatoptions+=croql
    set formatoptions-=t
    set cinoptions=:0,l1,t0,g0
endfunction

"" Misc
set nobackup                   " real men _never_ _ever_ do backups
set noswapfile                 " real men _never_ _ever_ do backups
set belloff=all
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %
" jump to last opened position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" allow tabs in Makefiles.
autocmd FileType make,automake set noexpandtab shiftwidth=8 softtabstop=8
" comment and uncomment
au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,cc,h,java let b:comment_leader = '// '
au FileType sh,make,txt,python let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '
noremap <silent> <C-C> :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> <C-X> :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
" allow external vimrc
set exrc
set secure
