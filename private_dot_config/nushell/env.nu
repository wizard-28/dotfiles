# Nushell Environment Config File
#
# version = 0.78.0

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = {|| create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = {|| "> " }
let-env PROMPT_INDICATOR_VI_INSERT = {|| ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
let-env PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

let-env XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
let-env XDG_CONFIG_HOME = ($env.HOME | path join ".config")
let-env XDG_STATE_HOME = ($env.HOME | path join ".local" "state")
let-env XDG_CACHE_HOME = ($env.HOME | path join ".cache")

let-env DOTFILES_DIR = ($env.HOME | path join "dotfiles")

let-env CABAL_CONFIG = ($env.XDG_CONFIG_HOME | path join "cabal" "config")
let-env CABAL_DIR = ($env.XDG_DATA_HOME | path join "cabal")

let-env CARGO_HOME = ($env.XDG_DATA_HOME | path join "cargo")

let-env GHCUP_USE_XDG_DIRS = true

let-env GNUPGHOME = ($env.XDG_DATA_HOME | path join "gnupg")

let-env HISTFILE = ($env.XDG_STATE_HOME | path join "bash" "history")
let-env LESSHISTFILE = ($env.XDG_STATE_HOME | path join "less" "history")

let-env NPM_CONFIG_USERCONFIG = ($env.XDG_CONFIG_HOME | path join "npm" "npmrc")

let-env PYTHONSTARTUP = "/etc/python3/pythonrc"

let-env RUSTUP_HOME = ($env.XDG_DATA_HOME | path join "rustup")

let-env BAT_THEME = "Catppuccin-mocha"

let-env DOOMDIR = ($env.DOTFILES_DIR | path join "config" "doom")

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
let-env PATH = (
    $env.PATH | split row (char esep)
    | prepend ($env.HOME | path join ".local" "bin")
    | prepend ($env.HOME | path join ".emacs.d" "bin")
    | prepend ($env.HOME | path join ".rye" "shims")
    | prepend ($env.HOME | path join ".spicetify")
    | prepend ($env.HOME | path join $env.XDG_DATA_HOME "cabal" "bin")
    | prepend ($env.HOME | path join $env.XDG_DATA_HOME "nvim" "mason" "bin")
    | prepend ($env.HOME | path join "bin")
    | prepend ($env.CARGO_HOME | path join "bin")
    | reverse | uniq | reverse
)

starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell | save -f ~/.zoxide.nu

### packer.nu ###
let-env NU_PACKER_HOME = ('~/.local/share/nushell/packer' | path expand)
# recovery command
def 'packer compile' [] { nu -c $'use ($env.NU_PACKER_HOME)/start/packer.nu/api_layer/packer.nu; packer compile' }
# bootstrap packer.nu
if not ($'($env.NU_PACKER_HOME)/start/packer.nu/api_layer/packer_api.nu' | path exists) {
  print $'(ansi ub)Bootstrapping packer.nu...(ansi reset)'
  nu -c (http get https://raw.githubusercontent.com/jan9103/packer.nu/main/install.nu)
  print $'(ansi ub)Bootstrapped packer.nu.'
  print $'(ansi ub)Installing packages...(ansi reset)'
  nu -c $'use ($env.NU_PACKER_HOME)/start/packer.nu/api_layer/packer.nu; packer install'
  print $'(ansi ub)Installed packages.(ansi reset)'
}
# compile conditional package loader
# conditional packages have to be generated in the env, since you can't generate and import in the same file.
# PERF: Disabled due to performance reasons.
# nu -c 'use ~/.local/share/nushell/packer/start/packer.nu/api_layer/packer.nu; packer compile_cond_init ~/.local/share/nushell/packer/conditional_packages.nu'
if not ($'($env.NU_PACKER_HOME)/packer_packages.nu' | path exists) { 'export-env {}' | save $'($env.NU_PACKER_HOME)/packer_packages.nu' }
