{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.userConfig) homeDir;
in
{
  programs = {
    firefox = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = {
          "sidebar.verticalTabs" = true;
          "sidebar.visibility" = "expand-on-hover";
          "sidebar.main.tools" = "history,bookmarks";
        };
        search = {
          force = true;
          default = "startpage";
          privateDefault = "startpage";
          engines = {
            # Disable "search with" icons
            ddg.metaData.hidden = true;
            bing.metaData.hidden = true;
            ebay.metaData.hidden = true;
            google.metaData.hidden = true;
            amazondotcom.metaData.hidden = true;
            wikipedia.metaData.hidden = true;

            startpage = {
              name = "Startpage";
              urls = [
                {
                  template = "https://www.startpage.com/sp/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
                {
                  template = "https://www.startpage.com/osuggestions";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                  type = "application/x-suggestions+json";
                }
              ];
              definedAliases = [ "sp" ];
            };

            nixpkgs-pr = {
              name = "Nixpkgs PR";
              urls = [
                {
                  template = "https://nixpk.gs/pr-tracker.html";
                  params = [
                    {
                      name = "pr";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "npr" ];
            };

            nix-pkgs = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "npk" ];
            };

            nix-opts = {
              name = "Nix Options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "nop" ];
            };

            nix-wiki = {
              name = "Nix Wiki";
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "nwk" ];
            };

            noogle = {
              name = "Noogle";
              urls = [
                {
                  template = "https://noogle.dev/q";
                  params = [
                    {
                      name = "term";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "ngl" ];
            };

            hm-opts = {
              name = "HM Opts";
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "hop" ];
            };

            wikipedia = {
              name = "Wikipedia";
              urls = [
                {
                  template = "https://en.wikipedia.org/wiki/Special:Search";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "wiki" ];
            };

            youtube = {
              name = "YouTube";
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "yt" ];
            };

            youtube-thumbnail = {
              name = "YouTube Thumbnail";
              urls = [
                {
                  template = "https://img.youtube.com/vi/{searchTerms}/maxresdefault.jpg";
                }
              ];
              definedAliases = [ "yti" ];
            };

            mdn = {
              name = "MDN";
              urls = [
                {
                  template = "https://developer.mozilla.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "mdn" ];
            };

            amazon = {
              name = "Amazon";
              urls = [
                {
                  template = "https://www.amazon.ca/s/ref=nb_sb_noss";
                  params = [
                    {
                      name = "url";
                      value = "search-alias%3Daps";
                    }
                    {
                      name = "field-keywords";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "az" ];
            };

            github = {
              name = "GitHub";
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "gh" ];
            };

            cybargit = {
              name = "Cy | Git";
              urls = [
                {
                  template = "https://github.com/cybardev/{searchTerms}";
                }
              ];
              definedAliases = [ "ghc" ];
            };
          };
        };
        bookmarks = {
          force = true;
          settings = [
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
        };
      };
      policies = {
        # Updates & Background Services
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;

        # Access Restrictions
        BlockAboutConfig = false;
        BlockAboutProfiles = true;
        BlockAboutSupport = true;

        # UI and Behavior
        DisplayMenuBar = "never";
        DisplayBookmarksToolbar = "newtab";
        DontCheckDefaultBrowser = true;
        HardwareAcceleration = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        DefaultDownloadDirectory = "${homeDir}/Downloads";
        PromptForDownloadLocation = true;
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        PostQuantumKeyAgreementEnabled = true;
        TranslateEnabled = true;
        SkipTermsOfUse = true;
        HttpsOnlyMode = "enabled";
        Homepage.StartPage = "previous-session";
        FirefoxHome = {
          # Make new tab only show search
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          Stories = false;
          SponsoredPocket = false;
          SponsoredStories = false;
          Snippets = false;
        };

        # Feature Disabling
        DisableAppUpdate = true;
        DisableBuiltinPDFViewer = false;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = false;
        DisableForgetButton = true;
        DisableFormHistory = false;
        DisableMasterPasswordCreation = true;
        DisablePasswordReveal = false;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        NoDefaultBookmarks = true;
        PictureInPicture.Enabled = false;
        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
        };

        # Settings
        DNSOverHTTPS = {
          Enabled = true;
          Fallback = false;
          # ProviderURL = "https://dns.nextdns.io/2853cb"; # NextDNS
          ProviderURL = "https://family.dns.mullvad.net/dns-query"; # Mullvad
          # ProviderURL = "https://family.cloudflare-dns.com/dns-query"; # Cloudflare
          ExcludedDomains = [
            "0.0.0.0"
            "localhost"
          ];
        };
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          EmailTracking = true;
          Fingerprinting = true;
        };
        SanitizeOnShutdown = {
          Cache = true;
          Cookies = false;
          Downloads = true;
          FormData = true;
          History = true;
          Sessions = false;
          SiteSettings = false;
          OfflineApps = false;
        };
        Preferences = {
          "gfx.webrender.all" = true;
          "layers.acceleration.force-enabled" = true;

          "privacy.globalprivacycontrol.enabled" = true;

          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.warnOnQuitShortcut" = true;
          "browser.aboutConfig.showWarning" = false; # No warning when going to config
          "ui.systemUsesDarkTheme" = true;

          "extensions.autoDisableScopes" = 0; # Automatically enable extensions
          "extensions.update.enabled" = false;

          "browser.urlbar.suggest.searches" = true; # Need this for basic search suggestions
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.shortcuts.tabs" = false;

          # top bar
          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              widget-overflow-fixed-list = [ "sidebar-button" ];
              unified-extensions-area = [
                "sponsorblocker_ajay_app-browser-action"
                "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
                "enhancerforyoutube_maximerf_addons_mozilla_org-browser-action"
              ];
              nav-bar = [
                "alltabs-button"
                "vertical-spacer"
                "back-button"
                "forward-button"
                "stop-reload-button"
                "urlbar-container"
                "_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action"
                "ublock0_raymondhill_net-browser-action"
                "unified-extensions-button"
              ];
              TabsToolbar = [ ];
              vertical-tabs = [ "tabbrowser-tabs" ];
              PersonalToolbar = [ "personal-bookmarks" ];
            };
            seen = [
              "developer-button"
              "screenshot-button"
              "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action"
              "enhancerforyoutube_maximerf_addons_mozilla_org-browser-action"
              "sponsorblocker_ajay_app-browser-action"
            ];
            dirtyAreaCache = [
              "nav-bar"
              "TabsToolbar"
              "vertical-tabs"
              "unified-extensions-area"
              "PersonalToolbar"
              "widget-overflow-fixed-list"
            ];
            currentVersion = 23;
            newElementCount = 6;
          };
        };

        # Extensions
        ExtensionSettings =
          let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
          in
          {
            "*".installation_mode = "blocked";

            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = moz "bitwarden-password-manager";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "uBlock0@raymondhill.net" = {
              install_url = moz "ublock-origin";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
              install_url = moz "noscript";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "sponsorBlocker@ajay.app" = {
              install_url = moz "sponsorblock";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "enhancerforyoutube@maximerf.addons.mozilla.org" = {
              install_url = moz "enhancer-for-youtube";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
              install_url = moz "return-youtube-dislikes";
              installation_mode = "force_installed";
              updates_disabled = true;
            };

            "3rdparty".Extensions = {
              "uBlock0@raymondhill.net".adminSettings = {
                userSettings = rec {
                  uiTheme = "dark";
                  uiAccentCustom = true;
                  uiAccentCustom0 = "#8300ff";
                  cloudStorageEnabled = lib.mkForce false;

                  importedLists = [
                    "https:#filters.adtidy.org/extension/ublock/filters/3.txt"
                    "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                  ];

                  externalLists = lib.concatStringsSep "\n" importedLists;
                };

                selectedFilterLists = [
                  "CZE-0"
                  "adguard-generic"
                  "adguard-annoyance"
                  "adguard-social"
                  "adguard-spyware-url"
                  "easylist"
                  "easyprivacy"
                  "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                  "plowe-0"
                  "ublock-abuse"
                  "ublock-badware"
                  "ublock-filters"
                  "ublock-privacy"
                  "ublock-quick-fixes"
                  "ublock-unbreak"
                  "urlhaus-1"
                ];
              };
            };
          };
      };
    };

    chromium = {
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
