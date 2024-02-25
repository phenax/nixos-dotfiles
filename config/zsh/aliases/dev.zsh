
alias remi="wyrd $REMINDER_FILE";

alias aws="docker run --rm -it amazon/aws-cli"

# nix shell with zsh
nix-zsh() { nix-shell --run "WITH_NIX_PREFIX='${NX_PREFIX:-':'}' zsh" "$@"; }

# Gitignore locally per-project
# Eg - gitignore-locally flake.nix flake.lock
gitignore-locally() {
  git add --intent-to-add "$@";
  git update-index --assume-unchanged "$@";
}

# :: Filename Pattern Replacetext
far() {
  local file_r="$1"; shift;
  local matcher_r="$1"; shift;
  local result="$1"; shift;
  fd "$file_r" | sad "$matcher_r" "$result" -p diff-so-fancy "$@";
}

# :: FileType Filename
calc() {
  local syntax="${1:-javascript}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

get_node_script_runner() {
  if [[ -f ./yarn.json ]]; then echo "yarn";
  elif [[ -f ./pnpm-lock.yaml ]]; then echo "pnpm";
  else echo "npm run"; fi;
}

# Npm run key binding
# local commands=$(node -e 'const pkg = require("./package.json"); Object.entries(pkg.scripts || {}).map(([key, value]) => console.log(`${key}\t\t\t"${value}"`))');
# local result=$(echo -e "$commands" | fzf | cut -f1);
p__run_npm_script() {
  [[ ! -f "package.json" ]] && return 1;

  local result=$(cat package.json | jq -r '.scripts | to_entries | map([.key, .value] | join("\t\t\t")) | .[]' | fzf | cut -f1);
  [[ -z "$result" ]] && return 1;

  print -Rz - "$(get_node_script_runner) $result ";
  zle send-break
}

zle -N p__run_npm_script;
bindkey '^B' p__run_npm_script;

fix-interpreter() {
  nix-shell -p patchelf --run "patchelf --set-interpreter \$(patchelf --print-interpreter \$(which mkdir)) $@"
}


# Terminal through neovim
vt() {
  nvim +term \
    +'norm i' \
    +"lua vim.fn.feedkeys([[$1]])" \
    +'set nonumber norelativenumber signcolumn=no' \
    +'autocmd TermClose * execute "qa"' \
    +'hi @_phenax.term-title guibg=#1a1824 guifg=#8e7ae3 gui=bold' \
    +'set winbar=%#@_phenax.term-title#%=nvim-term%=';
}

p__nvim_virtual_terminal() { vt "$BUFFER"; }
zle -N p__nvim_virtual_terminal;
bindkey '^T' p__nvim_virtual_terminal;
