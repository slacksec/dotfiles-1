#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

export ZDOTDIR="$HOME/.dotfiles/zsh"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### functions
# credit to grml for this function
# Check if we can read given files and source those we can.
xsource() {
    if (( ${#argv} < 1 )) ; then
        printf 'usage: xsource FILE(s)...\n' >&2
        return 1
    fi

    while (( ${#argv} > 0 )) ; do
        [[ -r "$1" ]] && source "$1"
        shift
    done
    return 0
}

#if (( $+commands[gvim] )) ; then
#    alias vim="gvim -v"
#fi

# report about cpu-/system-/user-time of command if running longer than 5 seconds
REPORTTIME=5

### functions
# simple webserver
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

### CD frecency (a portmateau of frequency and recent)
. ~/.dotfiles/zsh/z_cd_jumper/z.sh

### Vi Mode Enhancements
export KEYTIMEOUT=1

### Python Environments
xsource /usr/bin/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT=1
alias rmpyc='find . -name "*.pyc" -exec rm -rf {} \;'

### aliases
# systems stuff
alias llog="sudo tail -f /var/log/messages -n46" # colorized live log
alias lsec2="list_instances -H ID,Zone,T:Name,Key,Hostname,State"
alias rsync="noglob rsync -hv --progress"
alias fuck="pkill -9 -f"
alias jq="/usr/local/bin/jq -C"
function jql {
    /usr/local/bin/jq -C "${@}" | less
}
alias jqn="/usr/local/bin/jq"

alias shuffledir="mplayer -quiet -novideo -playlist <(find \$PWD -type f|sort -R)"
alias musicfind="grep -R --include=\"*.txt\" "
alias dupfind="find -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 33 | cut -c 35-"
alias chkansible="find . -name '*.yml' -not -path './roles/\*/files/\*' | xargs -t -n1 ansible-playbook --syntax-check"

alias tm="tmux"

alias psd="python setup.py develop"
alias psi="python setup.py install"

# remove HTML tags from file or in a pipeline
alias nohtml="awk '{gsub(\"<[^>]*>\", \"\")}1'"

# taskwarrior
alias t="task"
alias thudl="task add +hudl"
alias ta="task add"

xsource ~/.dotfiles/zsh/extrafuncs/*.zsh
