# Remove welcome message
set -g -x fish_greeting ''

# Load all saved ssh keys
/usr/bin/ssh-add -A ^/dev/null

# Starship prompt
starship init fish | source

# Machina-cli info
macchina

# Colorls
alias lc='colorls -lA --sd --dark'

# aliases
alias reload='exec fish'
