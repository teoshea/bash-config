SSH_ASKPASS=/usr/bin/ssh-askpass

## PATH
PATH=$home/bin:$PATH

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

cd $HOME
