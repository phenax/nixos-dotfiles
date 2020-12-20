setopt prompt_subst

# Theme
COL_ACCENT=13;

COL_DIR=$COL_ACCENT;

COL_STATUS_ERROR=red;
COL_STATUS_BG=cyan;

COL_GIT_DIRTY=yellow;
COL_GIT_NORMAL=green;


segment() { echo -n "%K{$2}%F{$3} $1 %f%k"; }
git_changes() { git status --porcelain 2> /dev/null | wc -l; }

# Prompt dir
p_dir() {
  segment "%2~" $COL_DIR white;
}

# Prompt terminal status
p_status() {
  echo -n "%(?..$(segment 'x' black $COL_STATUS_ERROR))"
  echo -n "%(1j.$(segment '(jobs: %j)' black $COL_STATUS_BG).)"
}

p_git() {
  local ref dirty mode repo_path color;

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null);
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)";

    changes=$(git_changes);
    color=$([[ ! $changes = "0" ]] && echo $COL_GIT_DIRTY || echo $COL_GIT_NORMAL);
    dirty=$([[ ! $changes = "0" ]] && echo " ($changes)");

    segment "${ref/refs\/heads\//}$dirty" $color black;
  fi
}

prompt() {
  RETVAL=$?;
  p_status;
  p_dir;
  echo -n '$(p_git)';
  segment "$" black white;
}

export PROMPT="$(prompt) ";
#export RPROMPT='wow'

