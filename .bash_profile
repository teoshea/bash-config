SSH="/usr/bin/ssh"
SSH_ENV="$HOME/.ssh/environment"

# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.

env=$HOME/.ssh/agent.env

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
        # ssh-add returns:
        #   0 = agent running, has keys
        #   1 = agent running, no keys
        #   2 = agent not running
        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
        false
    fi
}

agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
    . "$env" >/dev/null
}

agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
}

if ! agent_is_running && [ -s "$env" ]; then
    agent_load_env
fi

if ! agent_is_running; then
    ssh-agent >"$env"
    . "$env" > /dev/null
fi

# if your keys are not stored in ~/.ssh/id_rsa.pub or ~/.ssh/id_dsa.pub, you'll need
# to paste the proper path after ssh-add
if ! agent_is_running; then
    agent_start
    ssh-add
elif ! agent_has_keys; then
  ssh-add
fi

unset env

## BASH PROMPT

PS1='\[\033]0;Git Bash\007\]' # set window title
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\[\033[32m\]'       # change to green
PS1="$PS1"'\u@\h '             # user@host<space>
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[36m\]'       # change color to cyan
PS1="$PS1"'`__git_ps1`'   	   # bash function
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$ '                 # prompt: always $

# Globals (aliases etc. for all shells)
alias msbuild='/c/Windows/Microsoft.NET/Framework64/v4.0.30319/MSBuild.exe'

# Then get bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi


