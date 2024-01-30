{...}: {
  programs = {
    git = {
      enable = true;
      userEmail = "leana.jiang@icloud.com";
      userName = "Léana 江";
      signing = {
        key = "3659D5C87A4BC5D7699B37D84E887A4CA9714ADA";
        signByDefault = true;
      };
      lfs.enable = true;
      delta = {
        enable = true;
        options = {
          syntax-theme = "OneHalfLight";
          features = "side-by-side";
        };
      };
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
      ];
    };
  };
}
