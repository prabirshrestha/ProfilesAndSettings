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
	
" }

" Vim UI {
	color prabirdark   	       		" load a colorscheme
	set showmode                   	" display the current mode
" }