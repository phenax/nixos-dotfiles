
# Node aliases
alias nr="npm run";
alias ns="npm start";
alias nt="npm test";

run_npm_script() {
  [[ ! -f "package.json" ]] && return 1;

  local commands=$(node -e 'const pkg = require("./package.json"); Object.entries(pkg.scripts || {}).map(([key, value]) => console.log(`${key}\t\t  "${value}"`))');

  local result=$(echo -e "$commands" | fzf | cut -f1);

  [[ -z "$result" ]] && return 1;
  yarn "$result";
}

zle -N run_npm_script;
bindkey '^B' run_npm_script;

