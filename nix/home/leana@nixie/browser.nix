{ pkgs, nur, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    policies =
      { # https://mozilla.github.io/policy-templates/#hardwareacceleration
        # some options only works with firefox-esr
        DisableFirefoxScreenshots = true;
        DisablePocket = true;
        DisplayMenuBar = "never";
        DisplayBookmarksToolbar = "never";
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          TopSites = true;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
        DNSOverHTTPS = { Enabled = true; };
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SearchEngines = {
          Default = "searxng";
          Add = [
            {
              Name = "invidious";
              URLTemplate = "https://invidious.earth2077.fr/q={searchTerms}";
              Alias = "@yt";
            }
            {
              Name = "searxng";
              URLTemplate =
                "https://searxng.earth2077.fr/search?q={searchTerms}";
            }
          ];
        };
      };

    profiles.leana = {
      id = 0;
      name = "leana";
      search = {
        force = true;
        default = "searxng";
        engines = {
          Searxng = {
            urls = [{
              template = "https://searxng.earth2077.fr/search";
              params = [{
                name = "query";
                value = "{searchTerms}";
              }];
            }];
          };
          Invidious = {
            urls = [{
              template = "https://invidious.earth2077.fr/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
            definedAliases = [ "@yt" ];
          };
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];
            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Wiki" = {
            urls = [{
              template = "https://nixos.wiki/index.php?search={searchTerms}";
            }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nw" ];
          };
          "Wikipedia (en)".metaData.alias = "@wk";
        };
      };
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.devPixelsPerPx" = 1.2;
      };
      userChrome = ''
        #statuspanel-label {
            font-size: 18px !important;
            font-family: "Cascadia Code" !important;
        }
        .urlbar-input-box {
            font-size: 18px !important;
            font-family: "Cascadia Code" !important;
        }
      '';
      userContent = ''
        # a css
      '';
      extensions = with nur.repos.rycee.firefox-addons; [
        ublock-origin
        privacy-badger
        sponsorblock
        bitwarden
        tridactyl
        languagetool
        bypass-paywalls-clean
        news-feed-eradicator
      ];
    };
  };
}
