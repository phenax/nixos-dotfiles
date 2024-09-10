let
  tag = t: ''tags # \"${toString t}\"'';
  youtube = title: id: tags:
    { title = "[yt] ${title} youtube"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=${id}"; tags = ["youtube"] ++ tags; };
in {
  queries = {
    "dev tag" = tag "dev";
    "news tag" = tag "news";
    "opensource tag" = tag "opensource";
    "youtube tag" = tag "youtube";
    "funny tag" = tag "funny";
    "science tag" = tag "sci";
  };

  visible = [
    { url = "https://mshibanami.github.io/GitHubTrendingRSS/weekly/all.xml"; tags = ["latest"]; }
    { url = "https://dotfyle.com/this-week-in-neovim/rss.xml"; tags = ["opensource" "latest"]; }
    { url = "https://www.reddit.com/r/neovim.rss"; tags = ["reddit"]; title = "r/neovim"; }
  ];

  hidden = [
    { url = "https://www.nasa.gov/feeds/iotd-feed"; tags = ["sci"]; }
    { url = "https://www.nasa.gov/news-release/feed/"; tags = ["sci"]; }
    { url = "https://www.nature.com/nature.rss"; tags = ["sci"]; }
    { url = "https://what-if.xkcd.com/feed.atom"; tags = ["sci"]; }
    { url = "https://overreacted.io/rss.xml"; tags = ["dev"]; }

    { url = "https://overreacted.io/rss.xml"; tags = ["dev"]; }
    { url = "https://kentcdodds.com/blog/rss.xml"; tags = ["dev"]; }
    { url = "https://developer.chrome.com/blog/feed.xml"; tags = ["dev"]; }
    { url = "https://programmingisterrible.com/rss"; tags = ["dev"]; }
    { url = "https://cprss.s3.amazonaws.com/javascriptweekly.com.xml"; tags = ["dev"]; }
    { url = "https://cprss.s3.amazonaws.com/react.statuscode.com.xml"; tags = ["dev"]; }
    { url = "https://dev.to/feed/tag/typescript"; tags = ["dev"]; title = "TS - dev.to"; }
    { url = "https://dev.to/feed/tag/haskell"; tags = ["dev"]; title = "Haskell - dev.to"; }
    { url = "https://nitter.privacydev.net/vim_tricks/rss"; tags = ["twitter" "dev" "opensource"]; }

    { url = "https://hnrss.org/frontpage"; tags = ["news"]; }
    { url = "https://hackernoon.com/feed"; tags = ["news"]; }
    { url = "https://nixos.org/blog/announcements-rss.xml"; tags = ["opensource" "news"]; }
    { url = "https://www.reddit.com/r/opensource.rss"; tags = ["reddit" "opensource"]; title = "r/opensource"; }
    { url = "https://www.cyberciti.com/feed/"; tags = ["opensource" "news"]; }
    { url = "https://itsfoss.com/rss/"; tags = ["opensource" "news"]; }

    { url = "https://xkcd.com/rss.xml"; tags = ["funny"]; }
    { url = "http://phdcomics.com/gradfeed.php"; tags = ["funny"]; }
    { url = "https://www.reddit.com/r/ProgrammerHumor.rss"; tags = ["funny" "reddit"]; title = "r/ProgrammerHumor"; }
    { url = "https://feeds.feedburner.com/TheDailyWtf"; tags = ["funny"]; }

    # Youtube channels
    (youtube "IamMoBo" "UCJswRv22oiUgmT1FuFeUekw" ["funny"])
    (youtube "NaturalHabitatShorts" "UCSb_Sui6FBxVS4_ROsrU_Iw" ["funny"])
    (youtube "InternetHistorian" "UCR1D15p_vdP3HkrH8wgjQRw" ["funny"])
    (youtube "Incognito Mode" "UC8Q7XEy86Q7T-3kNpNjYgwA" ["funny"])
    (youtube "Fireship" "UCsBjURrPoezykLs9EqgamOA" ["dev"])
    (youtube "No boilerplate" "UCUMwY9iS8oMyWDYIe6_RmoA" ["dev"])
    (youtube "TypeCraft" "UCo71RUe6DX4w-Vd47rFLXPg" ["dev"])
  ];
}
