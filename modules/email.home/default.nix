{ config, ... }:
# Create private.nix with work.email, work.name
# Setup with `notmuch setup`
# Authenticate with `take ~/mail/account.gmail/ && gmi init <email>`
let
  private = import ./private.nix;
  theme = import ./aerc.theme.nix;
  maildir = "${config.home.homeDirectory}/mail";
  work-maildir = "${maildir}/account.gmail";
in {
  imports = [ ./mailbox-sync.module.nix ];

  services.mailbox-sync = {
    enable = true;
    name = "work";
    maildir = work-maildir;
    sync.frequency = "*:0/10";
    notify.enable = true;
  };

  programs.notmuch = {
    enable = true;
    new = {
      tags = ["new"];
      ignore = ["/.*[.](json|lock|bak)$/"];
    };
    extraConfig = {
      database = {
        path = maildir;
      };
      user = {
        name = private.work.name;
        primary_email = private.work.email;
      };
      search = {
        exclude_tags = "ignored";
      };
    };
  };

  programs.aerc = {
    enable = true;

    extraAccounts.Work = {
      from              = "${private.work.name} <${private.work.email}>";
      source            = "notmuch://${maildir}";
      outgoing          = "gmi send -t -C ${work-maildir}";
      query-map         = "${./query-map.conf}";
      folders-sort      = "Inbox,Unread,Important,_sent,_spam";
      default           = "INBOX";
      copy-to           = "Sent";
      postpone          = "[Gmail]/Drafts";
      cache-headers     = true;
    };

    extraConfig = builtins.readFile ./aerc.conf;
    extraBinds = builtins.readFile ./aerc-binds.conf;

    stylesets.default = theme;
  };

  xdg.desktopEntries.aerc-window = {
    name = "aerc";
    exec = "sensible-terminal -e aerc %u";
    terminal = false;
    mimeType = ["x-scheme-handler/mailto"];
    genericName = "Mail Client";
    comment = "Launches the aerc email client";
    categories = ["Office" "Network" "Email" "ConsoleOnly"];
    type = "Application";
    icon = "utilities-terminal";
    settings = {
      Keywords = "Email;Mail;IMAP;SMTP";
      Version = "1.0";
    };
  };
}
