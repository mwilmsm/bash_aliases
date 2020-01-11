# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Sets the lines in history to unlimited, both in number of lines and file size for the history file.
HISTSIZE=-1
HISTFILESIZE=-1

# The bash_aliases command is here by default, bash_functions is for longer shortcuts that require functions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi
