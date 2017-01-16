" = init.vim =

" Link: https://github.com/vonbrownie/dotfiles

" == General Configuration ==

set nocompatible

"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set mouse=v         " middle-click paste with mouse
set hlsearch		" highlight search results
set tabstop=4		" number of columns occupied by a tab character
set expandtab		" converts tabs to white space
set softtabstop=4	" see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4	" width for autoindents
set autoindent      " indent a new line the same amount as the line just typed
set number          " add line numbers
set wildmode=longest,list  " get bash-like tab completions
set cc=80           " set column border
hi ColorColumn ctermbg=DarkBlue guibg=DarkBlue

" date+time stamp
inoremap ,d <C-R>=strftime("%Y-%m-%dT%H:%M")<CR>

" vimwiki 
let g:vimwiki_list = [{'path': '~/doc/wiki/', 'path_html': '~/doc/wiki/html/'}]

" == Plugins ==

filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vimwiki/vimwiki'
Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end() 
filetype plugin indent on  " allows auto-indenting depending on file type
