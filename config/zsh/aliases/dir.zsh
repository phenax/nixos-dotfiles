take() { mkdir -p $@ && cd ${@:$#}; }

alias ..='cd ..';
alias ...='cd ../..';

alias gdv='cd ~/dev/';

alias gpic='cd ~/Pictures';
alias gdl='cd ~/Downloads/dl';
alias gm='cd ~/Downloads/music';

NIXCONF=$HOME/nixos;

alias gnotes="cd $NIXCONF/extras/notes";
alias gqute="cd $NIXCONF/config/qutebrowser";

alias gnix="cd $NIXCONF";
alias gvim="cd $NIXCONF/config/nvim";
alias gemacs="cd $NIXCONF/config/emacs";
alias gcmd="cd $NIXCONF/scripts/commands";
alias gzsh="cd $NIXCONF/config/zsh";

alias gdwm="cd $NIXCONF/packages/dwm/source";
alias gbar="cd $NIXCONF/packages/dwmblocks/source";
alias gkey="cd $NIXCONF/packages/shotkey/source";

