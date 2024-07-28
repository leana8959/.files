{ lib, ... }:
{
  # git plugins
  programs.git = {
    lfs.enable = true;
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
      # vim
      "*~"
      "*.swp"

      # darwin
      ".DS_Store"

      # nix
      ".direnv/"
      "**/result"

      # pre-commit
      ".pre-commit-config.yaml"

      # dotfiles
      ".config/nvim/spell/"
      ".local/bin/"

      # deploy-rs
      ".deploy-gc/"
    ];
  };

  # identity
  programs.git = {
    userEmail = "leana.jiang+git@icloud.com";
    userName = "Léana 江";
    signing = {
      key = "0x4E887A4CA9714ADA";
      signByDefault = lib.mkDefault false;
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
          signingKey = "0x32035DB97E777EEB";
        };
      };
    }
    # anima
    {
      condition = "gitdir:~/repos/skeletons/";
      contents = {
        init.defaultBranch = "main";
        user = {
          name = "Leana CHIANG";
          email = "yu-hui.chiang+git@inria.fr";
        };
        # don't sign because I don't want to deal with the key hassle
        commit.gpgsign = false;
      };
    }
  ];
}
