
alias aws="docker run --rm -it amazon/aws-cli"

# nix shell with zsh
nix-zsh() { nix-shell --run "WITH_NIX_PREFIX='${NX_PREFIX:-':'}' zsh" "$@"; }

# shell for node 14
with_node_14() { NX_PREFIX="node14" nix-zsh -p nodejs-14_x "$@"; }

# shell for docker-compose
with_dcomp() { TMPDIR=$HOME/dump/tempdir NX_PREFIX=docker-compose nix-zsh -p docker-compose; }

# npm run for node_14
nrx() { with_node_14 --run "npm run $*"; }

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

