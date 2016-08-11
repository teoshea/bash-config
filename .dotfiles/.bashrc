SSH_ASKPASS=/usr/bin/ssh-askpass

## PATH
PATH=$home/bin:$PATH

## BASH PROMPT
## TODO Move this to generic setup
# PS1="$PS1"'\n'                 # new line
# PS1="$PS1"'\[\033[32m\]'       # change to green
# PS1="$PS1"'\u@\h '             # user@host<space>
# PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
# PS1="$PS1"'\w'                 # current working directory
# PS1="$PS1"'\[\033[36m\]'       # change color to cyan
# PS1="$PS1"'`__git_ps1`'        # bash function
# PS1="$PS1"'\[\033[0m\]'        # change color
# PS1="$PS1"'\n'                 # new line
# PS1="$PS1"'$ '                 # prompt: always $

__source_files()
{
	for f in `find -L $1 -maxdepth 1 -type f \( -name "*$2*" -and ! -iname ".*" \) | sort -h`
	do
		. $f
	done
}

INIT_FOLDER="$HOME/.init/`hostname`"

## HOST SPECIFIC PRE-SETUP
if [ -d $INIT_FOLDER ] ; then
  __source_files $HOME/.init/`hostname` "PRE"
fi

## GENERIC SETUP
if [ -d $INIT_FOLDER ] ; then
  __source_files $HOME/.init ""
fi

## HOST SPECIFIC POST-SETUP
if [ -d $INIT_FOLDER ] ; then
  __source_files $HOME/.init/`hostname` "POST"
fi

#cd $HOME
#initialise_repos
#cd $git_root



