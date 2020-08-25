
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/wizard/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/wizard/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/wizard/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/wizard/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/wizard/.sdkman"
[[ -s "/home/wizard/.sdkman/bin/sdkman-init.sh" ]] && source "/home/wizard/.sdkman/bin/sdkman-init.sh"
