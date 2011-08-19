" Environment {
	" Basics {
		set nocompatible 		" must be first line
		set background=dark     " Assume a dark background
	" }

	" Windows Compatible {
		" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
		" across (heterogeneous) systems easier. 
		if has('win32') || has('win64')
			set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
			" Tell vim to remember certain things when we exit
			"  '10  :  marks will be remembered for up to 10 previously edited files
			"  "100 :  will save up to 100 lines for each register
			"  :20  :  up to 20 lines of command-line history will be remembered
			"  %    :  saves and restores the buffer list
			"  n... :  where to save the viminfo files

			set viminfo='10,\"100,:20,%,n~/.viminfo
		endif
	" }
     
	" Setup Bundle Support {
	" The next two lines ensure that the ~/.vim/bundle/ system works
		runtime! autoload/pathogen.vim
		silent! call pathogen#helptags()
		silent! call pathogen#runtime_append_all_bundles()
	" }

" }

" General {
	set background=dark         " Assume a dark background
    if !has('win32') && !has('win64')
        set term=$TERM       " Make arrow and other keys work
    endif
	filetype plugin indent on  	" Automatically detect file types.
	syntax on 					" syntax highlighting
	set mouse=a					" automatically enable mouse usage
	set hidden
    set wildmenu                " turn on command line completion wild sytle
    set wildmode=list:longest   " turn on wild mode huge list
    set visualbell
    set ttyfast
    set ruler
    set backspace=indent,eol,start
    set laststatus=2
    set relativenumber
    set undofile
    let mapleader = ","
" }

" Vim UI {
	color prabirdark   	       		" load a colorscheme
	set showmode                   	" display the current mode
    set showcmd
	set cursorline  				" highlight current line
    "set cursorcolumn                " highlight the current column
	set nu							" Line numbers on
    set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldenable  				" auto fold code

" }

" Formatting {
    set encoding=utf-8
	set nowrap                     	" wrap long lines
	set autoindent                 	" indent at the same level of the previous line
	set shiftwidth=4               	" use indents of 4 spaces
	set expandtab 	  	     		" tabs are spaces, not tabs
	set tabstop=4 					" an indentation every four columns
	set softtabstop=4 				" let backspace delete indent
	"set matchpairs+=<:>            " match, to be used with % 
	set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	" Remove trailing whitespaces and ^M chars
	autocmd FileType c,cs,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" Searching {
    nnoremap / /\v
    vnoremap / /\v
    		set incsearch					" find as you type search
	set hlsearch					" highlight search terms
	set ignorecase					" case insensitive search
	set smartcase					" case sensitive when uc present
    set gdefault
    set incsearch
    set showmatch
    set hlsearch
    nnoremap <leader><space> :noh<cr>
    nnoremap <tab> %
    vnoremap <tab> %
" }

" Handle long lines correctly {
    set wrap
    set textwidth=79
    set formatoptions=qrn1
    set colorcolumn=85
" }

" Folding {
    set foldmethod=indent   " fold based on indent
    set foldnestmax=10      " deepest fold is 10 level
    set nofoldenable        " don't fold by default
    set foldlevel=1
"}

set list
set listchars=tab:?\ ,eol:¬

" Disable Arrow Keys { 
    nnoremap <up> <nop>
    nnoremap <down> <nop>
    nnoremap <left> <nop>
    nnoremap <right> <nop>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>
    nnoremap j gj
    nnoremap k gk
" }

" Disable F1 help when hitting escape {
    inoremap <F1> <ESC>
    nnoremap <F1> <ESC>
    vnoremap <F1> <ESC>
" }

" Save on lose focus {
   " au FocusLost * :wa
" }

"nnoremap ; :

" Html fold tag function
nnoremap <leader>ft Vatzf  
" CSS properties sorted
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Select text that i just pasted
nnoremap <leader>v V`]

" Horizontal split
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

au BufNewFile,BufRead *.cshtml set filetype=html

" Autocommands {
    " Ruby {
        " ruby standard 2 spaces, always
            au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2 
            au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2 
        " }
" }

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME 
  let prefix = '.vim'
  let dir_list = { 
			  \ 'backup': 'backupdir', 
			  \ 'views': 'viewdir', 
              \ 'undo': 'undodir',
			  \ 'swap': 'directory' }

  for [dirname, settingname] in items(dir_list)
	  let directory = parent . '/' . prefix . dirname . "/"
	  if exists("*mkdir")
		  if !isdirectory(directory)
			  call mkdir(directory)
		  endif
	  endif
	  if !isdirectory(directory)
		  echo "Warning: Unable to create directory: " . directory
		  echo "Try: mkdir -p " . directory
	  else  
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
	  endif
  endfor
endfunction
call InitializeDirectories() 
