"=============================================================================
"  __      __________   ______   
" /  \    /  \_____  \ /  __  \  init.vim --- initialization file for vim
" \   \/\/   //  ____/ >      <  Copyright (c) 2021 Sourajyoti Basak
"  \        //       \/   --   \ Author: Sourajyoti Basak < wiz28@protonmail.com >
"   \__/\  / \_______ \______  / URL: https://github.com/wizard-28/dotfiles/
"        \/          \/      \/  License: MIT
"=============================================================================

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/settings.vim

for config in split(glob('$HOME/.config/nvim/plugins.conf/*.vim'), '\n')
	exe 'source' config
endfor
