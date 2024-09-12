let
  opener = c: "~/.config/newsboat/opener.sh ${c}";
  openCmd = opener "'%t' %u";
  openLinkWith = c: ''set browser "${c}"; open-in-browser; set browser "${openCmd}"'';
  pipeTo = c: "pipe-to \"${c}\"";
in {
  config = {
    reload-threads = 6;
    # max-items = 20;
    browser = openCmd;
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
    n = "next-unread";
    p = "prev-unread";
  };

  macros = {
    y = openLinkWith (opener "copy %u");
    t = pipeTo (opener "tts");
    s = openLinkWith (opener "torrent-stream '%u'");
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
