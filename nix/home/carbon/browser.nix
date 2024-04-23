{ pkgs, nur, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    policies = {
      # https://mozilla.github.io/policy-templates/#hardwareacceleration
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
      DNSOverHTTPS = {
        Enabled = true;
      };
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
            URLTemplate = "https://searxng.earth2077.fr/search?q={searchTerms}";
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
          "Nix Packages" = {
            urls = [
              {
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
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          Searxng = {
            urls = [ { template = "https://searxng.earth2077.fr/search?query={searchTerms}"; } ];
            iconUpdateURL = "https://searxng.earth2077.fr/favicon.png";
          };
          Invidious = {
            urls = [ { template = "https://invidious.earth2077.fr/search?q={searchTerms}"; } ];
            definedAliases = [ "@yt" ];
            iconUpdateURL = "https://invidious.earth2077.fr/favicon-32x32.png";
          };
          "Hoogle" = {
            urls = [ { template = "https://hoogle.haskell.org/?hoogle={searchTerms}"; } ];
            iconUpdateURL = "https://hoogle.haskell.org/favicon.png";
            definedAliases = [ "@hg" ];
          };
          "Genius" = {
            urls = [ { template = "https://genius.com/search?q={searchTerms}"; } ];
            iconUpdateURL = "https://genius.com/favicon.ico";
            definedAliases = [ "@ge" ];
          };
          "NixOS Wiki" = {
            urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            definedAliases = [ "@nw" ];
          };
          "Wikipedia (en)".metaData.alias = "@wk";
        };
      };
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.devPixelsPerPx" = 1.2;
        "browser.tabs.loadInBackground" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = false;
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
      extensions =
        let
          addons = nur.repos.rycee.firefox-addons;
        in
        [
          addons.ublock-origin
          addons.privacy-badger
          addons.sponsorblock
          addons.bitwarden
          addons.tridactyl
          addons.languagetool
          addons.bypass-paywalls-clean
          addons.news-feed-eradicator
        ];
    };
  };
}
