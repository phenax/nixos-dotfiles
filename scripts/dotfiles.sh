#!/usr/bin/env bash

add() { yadm add "$@"; }
add-public-config() {
  # Base config
  add ~/README.md;
  add ~/.work-config;
  add ~/.gitmodules ~/.config/git-config;
  add ~/.config/linkedconf;
  #add ~/.config/vimwiki;
  #add ~/.config/password-store;
  add ~/.config/sitesettings;
  add ~/.config/crontab;
  add ~/.config/gnupg/gpg-agent.conf;

  # X and DM
  add ~/.config/{bspwm,sxhkd}
  add ~/.config/compton.conf;
  add ~/.config/sx;
  add ~/.config/xresources-schemes;
  add ~/.config/dunst;
  add ~/.config/xconfig;
  add ~/.config/autostart.sh;

  # Other config
  add ~/.config/{gtk-3.0,mimeapps.list};

  # Terminal and shell
  add ~/.bashrc ~/.profile;
  add ~/.zshrc ~/.zprofile ~/.config/{zshconf,zshplugins};

  # Dev
  add ~/scripts ~/.bin;
  add ~/.config/nvim;

  # Applications
  add ~/.config/suckless;
  add ~/.config/qutebrowser;
  add ~/.config/{lf,mpv,sxiv,zathura,newsboat,neofetch};
  add ~/.config/transmission-daemon/settings.json;
  add ~/.config/{transmission-remote-cli,stig,tremc,udiskie};
  add ~/.config/{calcurse,pet,shell-macros};
  add ~/.config/neomutt;
  add ~/.config/{ncmpcpp,mopidy,mpd};

  # Wallpapers
  add ~/.fehbg;
  add ~/Pictures/wallpapers;
}

should_run() { [[ -z "$2" ]] || [[ "$2" == _ ]] || [[ "$1" == "$2" ]]; } # Should run command
should_push() { [[ -z "$1" ]]; } # Should sync with remote

commit-push-all() {
  local oldir=$(pwd);
  cd "$1";
  git add .;
  git commit -m "$2";
  should_push "$3" && git push;
  cd $oldir;
}

# Sync dotfiles to github (uses yadm)
update-dotfiles() {
  # Passwords push
  if (should_run pass "$1"); then
    echo -e "\n\n##### Pushing passwords";
    should_push "$2" && pass git push;
  fi;

  # Vim wiki push
  if (should_run notes "$1"); then
    echo -e "\n\n##### Pushing vimwiki";
    commit-push-all ~/.config/vimwiki "Notes updated" "$2";
  fi;

  # Push private config
  if (should_run work "$1"); then
    echo -e "\n\n##### Pushing private config";
    commit-push-all ~/.work-config "Updated private config" "$2";
  fi;

  # Dotfiles
  if (should_run dot "$1"); then
    echo -e "\n\n##### Pushing public dotfiles";
    yadm status;
    add-public-config;
    yadm commit -m "Updates dotfiles" && \
    should_push "$2" && yadm push -u origin master;
  fi;
}

update-dotfiles "$@";
