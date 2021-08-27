#fastfetch

fish_vi_cursor

# git sync
function gsync
	git reset --hard HEAD~1
	git push -f
	git pull upstream $argv --rebase
	git push
end

# Aliases
alias l="exa --icons -F"
alias la="exa --icons -aF"
alias ll="exa --icons -Flah"

starship init fish | source
