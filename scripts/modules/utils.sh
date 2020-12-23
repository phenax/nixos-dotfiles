
trim() { sed '/^$/ d'; }
trim_line() { sed -e 's/^\s*//' -e 's/\s*$//'; }

clipboard() { xclip -selection clipboard "$@"; }

copy() { clipboard -i; }
read_clipboard() { clipboard -o; }

copy_str() { echo -n "$@" | copy; }
