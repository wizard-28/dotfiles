source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
for i in split(glob('$HOME/.config/nvim/plug-config/*.vim'), '\n')
 exe 'source' i
endfor
