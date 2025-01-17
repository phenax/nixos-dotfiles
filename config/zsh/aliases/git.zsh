#function git_current_branch() {
  #local ref
  #ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  #local ret=$?
  #if [[ $ret != 0 ]]; then
    #[[ $ret == 128 ]] && return  # no git repo.
    #ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  #fi
  #echo ${ref#refs/heads/}
#}

# reset-origin a2_develop
reset-origin() {
  if [[ -z $(git status -s) ]];
    then
      currentBranch="$(git rev-parse --abbrev-ref HEAD)";
      branch="$1";
      git checkout $branch &&
      git pull &&
      git reset --hard origin/production &&
      git push -u origin $branch -f &&
      git checkout $currentBranch;
    else
      echo "Your branch is dirty. Stash or commit changed before proceeding";
  fi
}

# Git aliases
alias g='git'

alias ga='git add'
alias gaa='git add --all'

alias gco='git checkout'
alias gb='git branch'

alias gc='git commit -v'
alias gcm='git commit -v -m'
alias gc!='git commit -v --amend'

alias gst='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'

alias gp='git push'

alias gr='git rebase'
alias gri='git rebase -i'
alias grm='git rebase origin/master'
alias grc='git rebase --continue'

# Open files changed in a commit
# egc         : Open files in last commit
# egc HEAD~1  : Open files in commit before the last one
egc() {
  nvim $(git show --name-only --pretty="" "$@");
}

# Open files in diff
# egd              : Open files changed (HEAD)
# egd origin/main  : Open files diff between origin/main
egd() {
  nvim $(git diff --name-only ${1:-HEAD});
}

grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

g_most_edited() {
  git log --pretty=format: --name-only "$@" | \
    sort | \
    uniq -c | \
    sort -rg | \
    grep -E -v '.(html|scss|json)$' | \
    head -n 10 \
  ;
}

