
export TRASH_TMP_DIR=/tmp/.trash-cache;

[[ ! -d "$TRASH_TMP_DIR" ]] && mkdir $TRASH_TMP_DIR;

#export rmrf() {
  #for var in "$@"; do
    #mv $var $TRASH_TMP_DIR;
  #done
#}

