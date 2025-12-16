{ inputs, ... }:
let
  active_engines = [
    # web
    "startpage"
    "duckduckgo"
    "wikipedia"
    # image
    "startpage images"
    # video
    "odysee"
    "youtube"
  ];
  passive_engines = [
    "nixos wiki"
  ];
  enable-engine = engine: {
    name = engine;
    disabled = false;
  };
in
{
  imports = [ inputs.cypkgs.modules.searxng ];
  services.searxng = {
    enable = true;
    settings = {
      use_default_settings = {
        engines = {
          keep_only = active_engines ++ passive_engines;
        };
      };
      categories_as_tabs = {
        general = { };
        images = { };
        videos = { };
      };
      engines = map enable-engine active_engines;
      general = {
        debug = false;
        enable_metrics = false;
      };
      ui = {
        theme_args.simple_style = "auto";
        url_formatting = "full";
        infinite_scroll = true;
        default_locale = "en";
        hotkeys = "vim";
      };
      search = {
        safe_search = 0;
        default_lang = "en-CA";
        autocomplete = "startpage";
      };
      server = {
        port = 8080;
        bind_address = "0.0.0.0";
        image_proxy = true;
        method = "GET";
      };
      hostnames = {
        replace = {
          "(.*\.)?nixos.wiki$" = "wiki.nixos.org";
        };
      };
    };
  };
}
