
alias remi="wyrd $REMINDER_FILE";

alias aws="docker run --rm -it amazon/aws-cli"

# nix shell with zsh
nix-zsh() { nix-shell --run "WITH_NIX_PREFIX='${NX_PREFIX:-':'}' zsh" "$@"; }

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


# Npm run key binding
p__run_npm_script() {
  [[ ! -f "package.json" ]] && return 1;

  local commands=$(node -e 'const pkg = require("./package.json"); Object.entries(pkg.scripts || {}).map(([key, value]) => console.log(`${key}\t\t  "${value}"`))');
  # cat package.json | jq -r '.scripts | to_entries | map([.key, .value] | join("\t\t\t")) | .[]' | fzf | cut -f1

  local result=$(echo -e "$commands" | fzf | cut -f1);

  [[ -z "$result" ]] && return 1;
  yarn "$result";
}

zle -N p__run_npm_script;
bindkey '^B' p__run_npm_script;



# Load shell
p__load_nix_shell_file() {
  if [[ -f "./default.nix" ]]; then
    echo "";
    echo "ERR: default.nix already exists in directory";
    zle send-break;
    return 1;
  fi;

  local shells=$(ls ~/nixos/shell);
  local selected=$(echo -e "$shells" | fzf);
  [[ -z "$selected" ]] && return 1;
  cp ~/nixos/shell/$selected ./default.nix;
  zle send-break
}

zle -N p__load_nix_shell_file;
bindkey '^N' p__load_nix_shell_file;



# Enter shell
p__enter_nixshell() {
  if [[ -f "./default.nix" ]] || [[ -f "./shell.nix" ]]; then
    shell="nix-zsh"
    if [[ -f "./shell.nix" ]]; then
      shell="nix-zsh ./shell.nix"
    fi
    $shell
    zle send-break
    return 0;
  else
    echo "";
    echo "ERR: No default.nix or shell.nix in directory";
    zle send-break;
    return 1;
  fi;
}

zle -N p__enter_nixshell;
bindkey '^X' p__enter_nixshell;

fix-interpreter() {
  nix-shell -p patchelf --run "patchelf --set-interpreter \$(patchelf --print-interpreter \$(which mkdir)) $@"
}

