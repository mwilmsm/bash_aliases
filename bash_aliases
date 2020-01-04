# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
 alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
 alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
 alias ll='ls -larth'                              # long list
 alias la='ls -A'                              # all but . and ..
 alias l='ls -CF'                              #

source ~/.bash_prompt.sh
PS1='\n[\t $(pwd) $( __git_ps1 " ( %s ) ")]\n\! $ '

#Navigation
alias cd..='cd ..'
alias cd-='cd -'
alias cd~='cd ~'
alias cdc='cd /mnt/c/'

#Git:
alias branch-name='git rev-parse --abbrev-ref HEAD'
alias publish='git push --set-upstream origin `branch-name`'
alias gitdiff='git diff --ignore-space-at-eol -b -w'
alias brnch='(for folder in ./*/ ; do (echo "    $folder `git -C $folder status`" | head -2 | grep -v "up to date" | grep -v Untracked | grep -v "a git repository"); done)'
alias gitlog='git log --graph --decorate --oneline'
alias gitlogmine='git log --no-merges master..'
alias gitauthor='git log --pretty=format:"%h%x09%an%x09%ad%x09%s"'
alias gitbranchbydate='git for-each-ref --sort=-committerdate refs/heads/ --format='"'"'%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"'"''
alias gitbrr='git branch -r | grep'
alias gitbr='git branch | grep'
alias fff='git fetch -p -P && git ff'
alias pullmaster='git fetch -p -P && git pull origin master --no-edit'
alias gitalias='git config --get-regexp alias'
alias gitmerged='git branch --merged | egrep -v "(^\*|master)"'

#Misc:
alias vibashaliases='vi /home/king/.bash_aliases'
alias sourcebashaliases='source /home/king/.bash_aliases'
alias vibashrc='vi /home/king/.bashrc'
alias sourcebashrc='source /home/king/.bashrc'
