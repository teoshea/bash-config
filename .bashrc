########################################################################
#                                                                      #
#   This .bashrc is executed by each bash shell as it starts.          #
#                                                                      #
#   This file is provided by Maths for new users.  We strongly suggest #
#   you do NOT delete it unless you are ABSOLUTELY sure you know what  #
#   you are doing.  You may modify it by adding commands at the end.   #
#                                                                      #
########################################################################

#
# Execute the global Maths Bashrc
#

if [ -r /alt/ssetup/shellconfig/Bashrc ]; then
    . /alt/ssetup/shellconfig/Bashrc
fi

#
# Add personal customisation commands after this line ------------------
#

if [ -r ~/.dotfiles/.bashrc ] ; then
    . ~/.dotfiles/.bashrc
fi

export PATH=/alt/applic/user-maint/mr349/netbeans-8.0.1/bin:$PATH

# Set umask to 077.  This means that by default new files will only be
# readable and writable by you.  If you want others to be able to read
# new files you create, replace this line with umask 0022

umask 0077
