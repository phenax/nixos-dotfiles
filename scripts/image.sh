#!/usr/bin/env bash
source "`ueberzug library`";

readonly ID_PREVIEW="preview";

#case "$1" in
  #"clear") ImageLayer 0< <(
      #ImageLayer::remove [identifier]="$ID_PREVIEW"
  #) ;;
  #"draw") ImageLayer 0< <(
      #ImageLayer::add \
        #[identifier]="$ID_PREVIEW" \
        #[x]="$3" [y]="$4" \
        #[max_width]="$5" [max_height]="$6" \
        #[path]="$2";
      #read -ern 1;
  #) ;;
  #"*") echo "Unknown command: '$1'" ;;
#esac

LAST_IMAGE=$([[ -f "$LAST_IMAGE_F" ]] && cat $LAST_IMAGE_F);

clear_img() {
  echo "" > $FIFO_UEBERZUG;

  if [[ ! -z "$LAST_IMAGE" ]]; then
    declare -p -A cmd=([action]=remove [identifier]="$LAST_IMAGE") \
      > "$FIFO_UEBERZUG";
  fi;
}

clear_img;

case "$1" in
  "clear") clear_img ;;
  "draw")
    LAST_IMAGE="preview-$2";
    declare -p -A cmd=([action]=add [identifier]="$LAST_IMAGE" \
      [x]="$3" [y]="$4" [max_width]="$5" [max_height]="$6" \
      [path]="$2") > "$FIFO_UEBERZUG";
    echo -e "$LAST_IMAGE" > $LAST_IMAGE_F;
  ;;
  "*") echo "Unknown command: '$1', '$2'" ;;
esac

