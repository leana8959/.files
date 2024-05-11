{ config, ... }:
{
  # git plugins
  programs.git = {
    lfs = {
      enable = true;
      skipSmudge = true;
    };
    delta = {
      enable = true;
      options = {
        syntax-theme = "OneHalfLight";
        features = "side-by-side";
      };
    };
  };

  # git itself
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "mistress"; # haha gay haha
      push.autoSetupRemote = true;
      pull.ff = "only";
      rerere.enabled = true;
      safe.directory = "/etc/docker/compose";
    };
    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      ".direnv/"
      "**/result"
    ];
  };

  # identity
  programs.git = {
    userEmail = "leana.jiang+git@icloud.com";
    userName = "Léana 江";
    signing = {
      key = "3659D5C87A4BC5D7699B37D84E887A4CA9714ADA";
      signByDefault = config.git.signCommits;
    };
  };

  programs.git.includes = [
    # university identity
    {
      condition = "gitdir:~/univ-repos/";
      contents = {
        init.defaultBranch = "main";
        user = {
          name = "Léana CHIANG";
          email = "leana.chiang@etudiant.univ-rennes1.fr";
          signingKey = "EB544A6442B3B6CE88CD859732035DB97E777EEB";
        };
      };
    }
  ];
}
