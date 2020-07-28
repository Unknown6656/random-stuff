case $- in
    *i*) ;;
      *) return;;
esac

function function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429).
    # Lack of such support is extremely rare, and such a case would tend to support setf rather than setaf.
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1T="${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w"
    PS2="\e[33m\e[1m(continued)\e[m> "
else
    PS1T="${debian_chroot:+($debian_chroot)}\u@\h:\w"
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#    PS1T='\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1T'
#    ;;
#*)
#    ;;
#esac

PS1PREFIX="${PS1T}\[\e[96m\]"
PS1SUFFIX="\[\e[0;34m\]λ \[\e[0m\]"

if [ -f ~/git-prompt.sh ]; then
    source /etc/bash_completion.d/git-prompt
    source ~/git-prompt.sh
fi

if typeset -f __git_ps1 > /dev/null; then
    export PS1="${PS1PREFIX}$(__git_ps1 " (%s)")${PS1SUFFIX}"
else
    export PS1="${PS1PREFIX}${PS1SUFFIX}"
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

alias cls='clear'
alias ll='ls -lah --group-directories-first'
alias l='ls -CF'
alias df='df -ah'
alias cp='rsync -ahv --progress'
alias rm='rm -i'
alias apt-upgrade='apt clean; apt update; apt list --upgradable; apt dist-upgrade'
alias gnome-restart='service gdm3 stop; service gdm3 start'
# alias vlc-ascii='vlc --enable-caca --enable-aa'
alias vlc-ascii='vlc -V caca'
alias find-links='find . -type l -ls'
alias explorer='nautilus'
alias dump-tcp='tcpdump -s 0 -U -n -w - -i eno1 not port 22'
alias python='python3'
alias temp='vcgencmd measure_temp'

function fhash() {
    pee crc32 md5sum sha1sum sha224sum sha256sum sha384sum sha512sum < "$1"
}

function gitfa() {
    original_dir="$PWD"
    ignore_file="$original_dir/gfa.ignore"

    echo $ignore_file

    if [ $# -eq 0 ]; then
        git_command="git status"
    else
        git_command="git $@"
    fi;

    for i in $(ls .); do
        if [ -d $i ]; then
            cd $i
            dir_name="\033[1;34m$i\033[0m"
            echo -e $dir_name

            if [ -f $ignore_file ] && grep -Fxq $i $ignore_file
            then
                echo "In ignore list."
                cd $original_dir
                continue
            #else
            #    echo "No ignore file or not in list."
            fi

            if [ -d ".git" ]; then
                if [ -f "CATKIN_IGNORE" ]; then
                    echo "CATKIN_IGNORE"
                else
                    $git_command
                fi
            else
                echo "No git repository."
            fi

            cd $original_dir
        fi
    done
}
