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
      init = {defaultBranch = "mistress";}; # haha gay haha
      push = {autoSetupRemote = true;};
      pull = {ff = "only";};
      safe = {directory = "/etc/docker/compose";};
    };
    ignores = [
      "*~"
      "*.swp"
      ".direnv/"
      ".DS_Store"
    ];
  };

  # identity
  programs.git = {
    userEmail = "leana.jiang@icloud.com";
    userName = "Léana 江";
    signing = {
      key = "3659D5C87A4BC5D7699B37D84E887A4CA9714ADA";
      signByDefault = true;
    };
    includes = [
      {
        condition = "gitdir:~/univ-repos/";
        contents = {
          user = {
            name = "Léana CHIANG";
            email = "leana.chiang@etudiant.univ-rennes.fr";
            signingKey = "EB544A6442B3B6CE88CD859732035DB97E777EEB";
          };
          commit = {
            gpgSign = true;
          };
        };
      }
    ];
  };
}
