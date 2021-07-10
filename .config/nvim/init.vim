"=============================================================================
"  __      __________   ______   
" /  \    /  \_____  \ /  __  \  init.vim --- initialization file for vim
" \   \/\/   //  ____/ >      <  Copyright (c) 2021 Sourajyoti Basak
"  \        //       \/   --   \ Author: Sourajyoti Basak < wiz28@protonmail.com >
"   \__/\  / \_______ \______  / URL: https://github.com/wizard-28/dotfiles/
"        \/          \/      \/  License: MIT
"=============================================================================

let $PLUGIN_CONF_DIR=expand('~/.config/nvim/plugins.conf')
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/settings.vim

source $PLUGIN_CONF_DIR/vim-which-key.vim
source $PLUGIN_CONF_DIR/fzf.vim
