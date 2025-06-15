{ config, pkgs, ... }:
let
  inherit (config.userConfig) homeDir;
in
{
  programs = {
    zen-browser = {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
          search = {
            force = true;
            default = "ecosia";
            privateDefault = "ddg";
            engines = {
              ecosia = {
                name = "Ecosia";
                url = "https://www.ecosia.org/search?q={searchTerms}";
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/ecosia.svg";
                definedAliases = [
                  "ecosia"
                  "eco"
                ];
              };

              duckduckgo = {
                name = "DuckDuckGo";
                url = "https://duckduckgo.com/?q={searchTerms}";
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/duckduckgo.svg";
                definedAliases = [ "ddg" ];
              };

              youtube = {
                name = "YouTube";
                url = "https://www.youtube.com/results?search_query={searchTerms}";
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/youtube.svg";
                definedAliases = [ "yt" ];
              };

              wikipedia = {
                name = "Wikipedia";
                url = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}";
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/wikipedia.svg";
                definedAliases = [ "wiki" ];
              };

              nix-packages = {
                name = "Nix Packages";
                urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "npkg" ];
              };

              nix-options = {
                name = "Nix Options";
                urls = [ { template = "https://search.nixos.org/options?query={searchTerms}"; } ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "nopt" ];
              };

              nixos-wiki = {
                name = "NixOS Wiki";
                urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                definedAliases = [ "nwiki" ];
              };
            };
            order = [ "ecosia" ];
          };
          bookmarks.settings = [
            {
              name = "GitHub";
              url = "https://github.com/cybardev";
            }
            {
              name = "LinkedIn";
              url = "https://www.linkedin.com/in/cybardev/";
            }
            {
              name = "Discord";
              url = "https://www.discord.com/app";
            }
            {
              name = "Slack";
              url = "https://app.slack.com/client/";
            }
            {
              name = "Telegram";
              url = "https://web.telegram.org/a/";
            }
            {
              name = "Messenger";
              url = "https://m.me/";
            }
          ];
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            return-youtube-dislikes
            enhancer-for-youtube
            sponsorblock
            ublock-origin
          ];
        };
      };
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = true;
        PromptForDownloadLocation = true;
        DefaultDownloadDirectory = "${homeDir}/Downloads";
      };
    };

    chromium = {
      enable = false;
      package = pkgs.ungoogled-chromium;
      dictionaries = with pkgs.hunspellDictsChromium; [
        en_US
        en_GB
      ];
      extensions = [
        "dmghijelimhndkbmpgbldicpogfkceaj" # dark mode
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock origin lite
        "ponfpcnoihfmfllpaingbgckeeldkhle" # enhancer for youtube
        "gebbhagfogifgggkldgodflihgfeippi" # return youtube dislike
        "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock for youtube
      ];
      commandLineArgs = [
        # chromium
        "--site-per-process"
        # ungoogled-chromium
        "--enable-features=ReducedSystemInfo,RemoveClientHints,SpoofWebGLInfo,DisableLinkDrag,MinimalReferrers"
        "--omnibox-autocomplete-filtering=search-bookmarks"
        "--fingerprinting-canvas-measuretext-noise"
        "--fingerprinting-canvas-image-data-noise"
        "--fingerprinting-client-rects-noise"
        "--close-window-with-last-tab=never"
        "--no-default-browser-check"
        "--show-avatar-button=never"
        "--disable-beforeunload"
        "--scroll-tabs=always"
        "--start-maximized"
        "--force-dark-mode"
        "--popups-to-tabs"
        "--no-pings"
      ];
    };
  };
}
