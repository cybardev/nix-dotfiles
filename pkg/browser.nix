{ pkgs, ... }: {
  programs = {
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      dictionaries = with pkgs.hunspellDictsChromium; [
        en_US
        en_GB
      ];
      extensions = [
        "dmghijelimhndkbmpgbldicpogfkceaj" # dark mode
        "pejdijmoenmkgeppbflobdenhhabjlaj" # iCloud passwords
        "ponfpcnoihfmfllpaingbgckeeldkhle" # enhancer for youtube
        "gebbhagfogifgggkldgodflihgfeippi" # return youtube dislike
        "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock for youtube
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock origin lite
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
