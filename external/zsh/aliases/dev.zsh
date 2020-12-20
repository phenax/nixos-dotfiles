
alias aws="docker run --rm -it amazon/aws-cli"

# :: Filename Pattern Replacetext
far() {
  local file_r="$1"; shift;
  local matcher_r="$1"; shift;
  local result="$1"; shift;
  fd "$file_r" | sad "$matcher_r" "$result" -p diff-so-fancy "$@";
}

# :: FileType Filename
codi() {
  local syntax="${1:-python}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

