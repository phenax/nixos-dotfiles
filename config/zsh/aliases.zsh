
for f in $ZSH_CUSTOM_CONF_FILES/aliases/*.zsh; do source $f; done;

alias grep="grep --color=auto";

# Application shortcuts
alias emedit="emacsclient -c -n";
alias e="sensible-editor";
alias v="nvim";
alias o='open $(fzf)';

alias j='just';
alias jl='just -l';
alias je='just -e';
alias jc='just --choose';

# Load work aliases
# source "$HOME/.work-config/zshconf/aliases.zsh";

# Utility stuff
alias clock="tty-clock -t -b -c";
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"';
alias show-mobile-screen="adb shell screenrecord --output-format=h264 - | ffplay -";

# QR file transfer
alias qr-send="qrcp";
alias qr-get="qrcp receive";
qr-str() { curl qrenco.de/$1; }

# Audio download
alias dl-audio="youtube-dl --ignore-errors --output '%(title)s.%(ext)s' --extract-audio";

# Swallow window
alias smpv="swallow mpv";
alias ssxiv="swallow sxiv";
alias szathura="swallow zathura";

# Dictionary
dict() { curl dict://dict.org/d:$1; }

