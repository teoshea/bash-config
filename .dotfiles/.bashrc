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

INIT_FOLDER="$HOME/.init"
SPECIFIC_INIT_FOLDER="$HOME/.init/$GIT_HOME_CONFIG"

## HOST SPECIFIC PRE-SETUP
if [ -d $SPECIFIC_INIT_FOLDER ] ; then
  __source_files $SPECIFIC_INIT_FOLDER "PRE"
fi

## GENERIC SETUP
if [ -d $INIT_FOLDER ] ; then
  __source_files $INIT_FOLDER ""
fi

## HOST SPECIFIC POST-SETUP
if [ -d $SPECIFIC_INIT_FOLDER ] ; then
  __source_files $SPECIFIC_INIT_FOLDER "POST"
fi

cd $HOME
