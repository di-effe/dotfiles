### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message


### Load all saved ssh keys ###
/usr/bin/ssh-add -A ^/dev/null




### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### SETTING MACCHINA PROMPT ###
macchina

### SETTING COLORLS ###
alias lc='colorls -lA --sd --dark'




### ALIASES ###

# reload FISH
alias reload='exec fish'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Colorize grep output 
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"



### FUNCTIONS ###

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

