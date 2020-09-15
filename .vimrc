"
"> Daniel Wayne Armstrong
"> https://github.com/dwarmstrong/dotfiles
"> https://www.dwarmstrong.org
"

" == General configuration ==

set nocompatible            " disable compatibility to old-time vi
set background=dark         " adjust default colours for better contrast
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set colour columns for good coding style
" python programming
syntax on                   " syntax highlighting
filetype plugin indent on   " allow auto-indenting depending on file type
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " convert tabs to white space
set shiftwidth=4            " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing

" == Colors ==

colorscheme default     " `default` picks up colors defined in `~/.Xresources`

" == Mode mappings ==

" normal mode map -- `:nnoremap`
" insert mode map -- `:inoremap`

" map leader
let g:mapleader = ','

" toggle spelling
nnoremap <leader>s :set invspell<CR>
" when invoking an Ex command from a map, `<CR>` is added at the end

" date+time stamp
inoremap <leader>d <C-R>=strftime("%Y-%m-%dT%H:%M")<CR>
" `<C-R>=` is used to insert the result of an expression at the cursor

" == Plugins ==

" managed by [vim-plug](https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'vimwiki/vimwiki'
call plug#end()

" == Extras ==

" vimwiki 
let g:vimwiki_list = [{'path': '~/doc/wiki/', 'path_html': '~/doc/wiki/html/'}]
