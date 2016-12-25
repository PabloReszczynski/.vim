
set nocompatible                         " be iMproved, required
filetype off                             " required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'            " Vundle
Plugin 'scrooloose/nerdtree'             " NERDTree
Plugin 'jiangmiao/auto-pairs'            " Auto bracket matching
Plugin 'chriskempson/base16-vim'         " Base16
Plugin 'vim-airline/vim-airline'         " Airline
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'                  " C-p fuzzy finder
Plugin 'weynhamz/vim-plugin-minibufexpl' " Tabs
Plugin 'neovimhaskell/haskell-vim'       " Haskell
" Plugin 'ethereum/vim-solidity'           " Solidity syntax
" Plugin 'justinmk/vim-syntax-extra'       " C syntax extra
Plugin 'davidhalter/jedi-vim'            " Auto completion
Plugin 'pangloss/vim-javascript'         " Javascript
Plugin 'elixir-lang/vim-elixir'          " Elixir
" Plugin 'mxw/vim-jsx'                     " React Jsx syntax
Plugin 'Shougo/neocomplete'              " Auto completion
Plugin 'bmatheny/vim-scala'              " Scala
Plugin 'majutsushi/tagbar'               " Tagbar
Plugin 'tpope/vim-surround'              " (surround)
call vundle#end()
filetype plugin indent on

" Folding
set foldmethod=indent
set foldlevel=99

" Mappings
nmap <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

" UI
set nu
set showcmd
set wildmenu
set wildmode=list:longest,full
set showmatch
set ruler
set laststatus=2

let base16colorspace=256
set background=dark
colorscheme base16-embers

set t_md =                              " disable bold

syntax on

" MacVim
set guioptions-=m                       " remove menu bar
set guioptions-=T                       " remove toolbar
set guioptions-=r                       " remove right-hand scroll bar
set guioptions-=L                       " remove left-hand scroll bar
set guioptions+=e                       " gui tabs

set guifont=Fantasque\ Sans\ Mono:h14

highlight Comment gui=italic

" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='base16'

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Movement
nnoremap j gj
nnoremap k gk

" Backspace
set backspace=indent,eol,start

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.o$']

" Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

" Column
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Other
set autoread
if has('mouse')
  set mouse=a
endif
set encoding=utf8
set ffs=unix,dos,mac

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Autoreload
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end

" Quit NERDTree
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END

  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

" Python
au BufNewFile, BufRead *.py
  \ set tabstop=4
  \ set softtabstop=4
  \ set shiftwidth=4
  \ set textwidth=79
  \ set expandtab
  \ set autoindent
  \ set fileformat=unix
let python_highlight_all=1
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Haskell
au BufNewFile, BufRead *.hs
  \ set tabstop=8
  \ set softtabstop=4
  \ set shiftwidth=4
  \ set textwidth=80
  \ set shiftround
  \ set expandtab
  \ set autoindent
  \ set fileformat=unix
let g:haskell_enable_quantification=1 " forall
let g:haskell_enable_recursivedo=1 " mdo rec
let g:haskell_enable_arrowsyntax=1 "proc
let g:haskell_enable_pattern_synonyms=1 " pattern
let g:haskell_enable_typeroles=1 " typeroles
let g:haskell_enable_static_pointers=1 "static
let g:haskell_indent_if=3
let g:haskell_indent_case=2
let g:haskell_indent_let=4
let g:haskell_indent_where=6
let g:haskell_indent_do=3
let g:haskell_indent_in=1
let g:haskell_indent_guard=2

" NeoComplete
let g:acp_enableAtStartup=0
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#sources#syntax#min_keyword_length=3

autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
