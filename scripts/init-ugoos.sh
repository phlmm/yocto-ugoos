if [ -n "$BASH_SOURCE" ]; then
	export ROOT=$(readlink -f $(dirname "$BASH_SOURCE"))
elif [ -n "$ZSH_NAME" ]; then
	export ROOT=$(readlink -f $(dirname "$0"))
else
	export ROOT=$(readlink -f ${PWD})
fi

export TEMPLATECONF=$ROOT/sources/meta-ugoos/conf
export PATH=$PATH:$ROOT/scripts
source $ROOT/sources/poky/oe-init-build-env "$@"
