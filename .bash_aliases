if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias cls='clear'
alias ll='ls -lah --group-directories-first'
alias l='ls -CF'
alias df='df -ah'
alias cp='rsync -ahv --progress'
alias rm='rm -i'
alias beep="echo -ne '\007'"

alias apt-upgrade='apt clean; apt update; apt list --upgradable; apt dist-upgrade'

alias gnome-restart='service gdm3 stop; service gdm3 start'
# alias vlc-ascii='vlc --enable-caca --enable-aa'
alias vlc-ascii='vlc -V caca'
alias find-links='find . -type l -ls'
alias explorer='nautilus'
alias dump-tcp='tcpdump -s 0 -U -n -w - -i eno1 not port 22'

alias temp='vcgencmd measure_temp'

alias git-graph='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'

alias python='python3'
alias d="docker compose"
alias dk='docker stop $(docker ps -a -q)'
alias dl="d logs --follow"
alias dw="d down; docker system prune -f"
alias db="d up --build"
alias dp="d ps -a"
alias dbn="db --no-recreate"
