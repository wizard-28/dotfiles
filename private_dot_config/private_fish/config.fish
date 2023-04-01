# =============================================================================
#  __      __________   ______
# /  \    /  \_____  \ /  __  \
# \   \/\/   //  ____/ >      <
#  \        //       \/   --   \
#   \__/\  / \_______ \______  /
#        \/          \/      \/
# config.fish --- config for fish
# Copyright (c) 2021 Sourajyoti Basak
# Author: Sourajyoti Basak < wiz28@protonmail.com >
# URL: https://github.com/wizard-28/dotfiles/
# License: MIT
# =============================================================================

if status --is-interactive

    starship init fish | source &
    zoxide init fish | source &

    alias l="exa --icons -F"
    alias la="exa --icons -aF"
    alias ll="exa --icons -Flah"

    alias tree="et"

    function fish_user_key_bindings
        bind --mode insert \co dev
    end

    fish_vi_cursor
    export PATH="/home/pop-os/.local/bin:$PATH"
    export RUSTC_WRAPPER=sccache

    function gsync
        git reset --hard HEAD~1
        git push -f
        git pull upstream $argv --rebase
        git push
    end

    function pm
        set -l paths
        set -l pacscripts btop-bin caprine-deb dust-bin emacs fennel hyperfine-bin i3-gaps libressl librewolf-app oil opera-deb qogir-gtk-theme-bin qogir-icon-theme-bin shfmt-bin telegram-bin tmpmail-bin uwufetch walc-app zentile-bin fnlfmt fennel-bin
        for pacscript in $pacscripts
            set -a paths "~/code/bash/pacstall-programs/packages/$pacscript/$pacscript.pacscript"
        end
        cd ~/code/bash/pacstall-programs && pacup --ship $paths
    end

    function qrcode
        set input "$argv"
        [ -z "$input" ] && local input="@/dev/stdin"
        curl -d "$input" https://qrcode.show
    end

end

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/wizard/.ghcup/bin $PATH # ghcup-env

# pnpm
set -gx PNPM_HOME "/home/wizard/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

fish_add_path /home/wizard/.spicetify
fish_add_path /home/wizard/.local/share/cabal/bin
fish_add_path /home/wizard/.local/share/nvim/mason/bin/

# Wasmer
export WASMER_DIR="/home/wizard/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
