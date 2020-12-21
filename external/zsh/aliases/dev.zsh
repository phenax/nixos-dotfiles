
alias aws="docker run --rm -it amazon/aws-cli"

nrx() { nix-shell -p nodejs-14_x --run "npm run $1"; }

with_node_14() { nix-shell -p nodejs-14_x --run 'WITH_NIX_PREFIX="node14" zsh'; }

nix-zshell() { nix-shell --run 'WITH_NIX_PREFIX=":" zsh' "$@"; }

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

