"=============================================================================
"  __      __________   ______   
" /  \    /  \_____  \ /  __  \  plugins.vim --- plugins configuration using dein plugin manager
" \   \/\/   //  ____/ >      <  Copyright (c) 2021 Sourajyoti Basak
"  \        //       \/   --   \ Author: Sourajyoti Basak < wiz28@protonmail.com >
"   \__/\  / \_______ \______  / URL: https://github.com/wizard-28/dotfiles/
"        \/          \/      \/  License: MIT
"=============================================================================
set runtimepath+=/home/pop-os/.cache/nvim/dein/repos/github.com/Shougo/dein.vim

"=============================================================================
" Plugins
"=============================================================================
call dein#begin('/home/pop-os/.cache/nvim/dein')
call dein#add('/home/pop-os/.cache/nvim/dein/repos/github.com/Shougo/dein.vim')

call dein#add('wsdjeg/dein-ui.vim', { 'on_cmd': 'DeinUpdate' })			" Dein-UI
call dein#add('morhetz/gruvbox')						" Gruvbox baby
call dein#add('mhinz/vim-startify')						" Startify
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })	" FZF
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })				" FZF.vim

call dein#end()
"=============================================================================
if dein#check_install()
	call dein#install()
endif
