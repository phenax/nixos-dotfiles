rec {
  config = {
    reload-threads = 6;
    max-items = 20;
    browser = "~/.config/newsboat/opener.sh '%t' %u";
    show-keymap-hint = false;
    refresh-on-startup = true;
    save-path = "~/Downloads/articles";
    articlelist-format = "%?T?| %-26T | %5i: ?%t";
    prepopulate-query-feeds = true;
  };

  keys = {
    j = "down";
    k = "up";
    l = "open";
    h = "quit";
    g = "home";
    G = "end";
    q = "hard-quit";
    n = "next";
    p = "prev";
  };

  macros = let
    copyCmd = "~/.config/newsboat/opener.sh copy %u";
  in {
    y = ''set browser "${copyCmd}"; open-in-browser; set browser "${config.browser}"'';
  };

  extraConfig = ''
color background          color223   default
color listnormal          color246   default
color listnormal_unread   color62    default bold
color listfocus           white      magenta
color listfocus_unread    white      magenta bold underline
color info                color8     default
color article             white      default

highlight article "^(Feed|Link|Title|Date|Author):.*$" color223 default bold
highlight article "\\[[0-9]+\\]" color62 default bold
highlight article "https?://[^ ]+" color117 default underline
highlight article "\\[image\\ [0-9]+\\]" color117 default bold
highlight articlelist "\\|[^|]*\\|" color253 default bold
highlight articlelist "\\| \\[yt\\][^|]*\\|" color1 default bold
highlight articlelist "\\| r/[^|]*\\|" color253 default
highlight articlelist "\\| VimTricks[^|]*\\|" color27 default
  '';
}
