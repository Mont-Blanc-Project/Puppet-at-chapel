#----------------------------------------------------------------------#
# system-wide profile.modules                                          #
# Initialize modules for all sh-derivative shells                      #
#----------------------------------------------------------------------#
trap "" 1 2 3

case "$0" in
	-bash|bash|*/bash) . /apps/modules/3.2.10/Modules/default/init/bash ;;
-ksh|ksh|*/ksh) . /apps/modules/3.2.10/Modules/default/init/ksh ;;
-zsh|zsh|*/zsh) . /apps/modules/3.2.10/Modules/default/init/zsh ;;
*) . /apps/modules/3.2.10/Modules/default/init/sh ;; # sh and default for scripts
esac

trap 1 2 3
