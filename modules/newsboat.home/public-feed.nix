{ ... }:
let
  tag = t: ''tags # \"${toString t}\"'';
  youtube = title: id: tags: {
    title = "[yt] ${title} youtube";
    url = "https://www.youtube.com/feeds/videos.xml?channel_id=${id}";
    tags = ["youtube"] ++ tags;
  };
in {
  queries = [
    { title = "#dev-blog"; query = tag "dev-blog"; }
    { title = "#dev"; query = tag "dev"; }
    { title = "#nvim"; query = tag "nvim"; }
    { title = "#podcast"; query = tag "podcast"; }
    { title = "#opensource"; query = tag "opensource"; }
    { title = "#funny"; query = tag "funny"; }
    { title = "#youtube"; query = tag "youtube"; }
    { title = "#news"; query = tag "news"; }
    # { title = "#sci"; query = tag "sci"; }
  ];

  visible = [
    { url = "https://mshibanami.github.io/GitHubTrendingRSS/daily/all.xml"; tags = []; title = "Github trending"; }
  ];

  hidden = [
    { url = "https://www.reddit.com/r/neovim.rss"; tags = ["nvim" "reddit"]; title = "r/neovim"; }
    { url = "https://dotfyle.com/this-week-in-neovim/rss.xml"; tags = ["nvim"]; }
    { url = "https://dotfyle.com/neovim/plugins/rss.xml"; tags = ["nvim"]; }
    { url = "https://vimtricks.com/feed/"; tags = ["opensource" "nvim"]; }

    # { url = "https://www.nasa.gov/feeds/iotd-feed"; tags = ["sci"]; }
    # { url = "https://www.nasa.gov/news-release/feed/"; tags = ["sci"]; }
    # { url = "https://www.nature.com/nature.rss"; tags = ["sci"]; }
    # { url = "https://what-if.xkcd.com/feed.atom"; tags = ["sci"]; }

    { url = "https://feeds.transistor.fm/tomorrow"; tags = ["podcast"]; }
    { url = "https://feed.syntax.fm/"; tags = ["podcast"]; }
    { url = "https://changelog.com/podcast/feed"; tags = ["podcast"]; }
    { url = "https://seradio.libsyn.com/rss"; tags = ["podcast"]; }
    { url = "https://changelog.com/jsparty/feed"; tags = ["podcast"]; }
    { url = "https://feeds.buzzsprout.com/1952066.rss"; tags = ["podcast"]; }
    { url = "https://www.spreaker.com/show/6102064/episodes/feed"; tags = ["podcast"]; }
    { url = "https://feeds.soundcloud.com/users/soundcloud:users:206137365/sounds.rss"; tags = ["podcast"]; }
    { url = "http://shoptalkshow.com/feed/podcast"; tags = ["podcast"]; }
    { url = "https://anchor.fm/s/dd6922b4/podcast/rss"; tags = ["podcast"]; title = "devtools.fm"; }
    { url = "https://feeds.acast.com/public/shows/664fde3eda02bb0012bad909"; tags = ["podcast"]; }

    { url = "https://lexi-lambda.github.io/feeds/all.rss.xml"; tags = ["dev-blog"]; }
    { url = "https://overreacted.io/rss.xml"; tags = ["dev-blog"]; }
    { url = "https://tkdodo.eu/blog/rss.xml"; tags = ["dev-blog"]; }
    { url = "https://kentcdodds.com/blog/rss.xml"; tags = ["dev-blog"]; }
    { url = "https://world.hey.com/dhh/feed.atom"; tags = ["dev-blog"]; }
    { url = "https://developer.chrome.com/blog/feed.xml"; tags = ["dev-blog"]; }
    { url = "https://programmingisterrible.com/rss"; tags = ["dev-blog"]; }
    { url = "https://vercel.com/atom"; tags = ["dev-blog"]; }
    { url = "https://reacttraining.com/rss.xml"; tags = ["dev-blog"]; }
    { url = "https://www.developerway.com/rss.xml"; tags = ["dev-blog"]; }
    { url = "https://blog.haskell.org/atom.xml"; tags = ["dev-blog"]; }
    { url = "https://www.pschatzmann.ch/home/feed/"; tags = ["dev-blog"]; }

    { url = "https://cprss.s3.amazonaws.com/javascriptweekly.com.xml"; tags = ["dev"]; }
    { url = "https://cprss.s3.amazonaws.com/react.statuscode.com.xml"; tags = ["dev"]; }
    { url = "https://www.totaltypescript.com/rss.xml"; tags = ["dev"]; }
    { url = "https://dev.to/feed/tag/haskell"; tags = ["dev"]; title = "Haskell - dev.to"; }

    { url = "https://devblogs.microsoft.com/typescript/feed/"; tags = ["news"]; }
    { url = "https://dev.to/feed/tag/typescript"; tags = ["news"]; title = "TS - dev.to"; }
    # { url = "https://hnrss.org/frontpage"; tags = ["news"]; }
    # { url = "https://hackernoon.com/feed"; tags = ["news"]; }
    { url = "https://nixos.org/blog/announcements-rss.xml"; tags = ["opensource" "news"]; }
    { url = "https://www.cyberciti.com/feed/"; tags = ["opensource" "news"]; }
    { url = "https://itsfoss.com/rss/"; tags = ["opensource" "news"]; }
    { url = "https://www.reddit.com/r/opensource.rss"; tags = ["reddit" "opensource"]; title = "r/opensource"; }

    { url = "https://xkcd.com/rss.xml"; tags = ["funny"]; }
    { url = "http://phdcomics.com/gradfeed.php"; tags = ["funny"]; }

    # Youtube channels
    (youtube "IamMoBo" "UCJswRv22oiUgmT1FuFeUekw" ["funny"])
    (youtube "NaturalHabitatShorts" "UCSb_Sui6FBxVS4_ROsrU_Iw" ["funny"])
    (youtube "InternetHistorian" "UCR1D15p_vdP3HkrH8wgjQRw" ["funny"])
    (youtube "Incognito Mode" "UC8Q7XEy86Q7T-3kNpNjYgwA" ["funny"])
    (youtube "Fireship" "UCsBjURrPoezykLs9EqgamOA" ["dev"])
    (youtube "No boilerplate" "UCUMwY9iS8oMyWDYIe6_RmoA" ["dev"])
    (youtube "TypeCraft" "UCo71RUe6DX4w-Vd47rFLXPg" ["dev"])
    (youtube "exurb1a" "UCimiUgDLbi6P17BdaCZpVbg" ["think"])
    (youtube "Casually Explained" "UCr3cBLTYmIK9kY0F_OdFWFQ" ["funny"])
    (youtube "zefrank1" "UCVpankR4HtoAVtYnFDUieYA" ["funny"])
    (youtube "3Blue 1Brown" "UCYO_jab_esuFRV4b17AJtAw" ["think"])
  ];
}
