local wez = require 'wezterm'
local cfg = wez.config_builder()
local act = wez.action
-- CONFIG START --

cfg.use_fancy_tab_bar = false
cfg.hide_tab_bar_if_only_one_tab = true
cfg.tab_bar_at_bottom = true

cfg.window_background_opacity = 0.86
cfg.color_scheme = 'Kanagawa Dragon (Gogh)'

cfg.font = wez.font 'CaskaydiaCove Nerd Font Mono'
cfg.font_size = 14

cfg.keys = {
  {
    key = 'Enter',
    mods = 'SUPER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '[',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Prev',
  },
  {
    key = ']',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Next',
  },
  {
    key = 'w',
    mods = 'SUPER',
    action = act.CloseCurrentPane { confirm = false },
  },
  {
    key = 'W',
    mods = 'SUPER',
    action = act.CloseCurrentTab { confirm = false },
  },
}

-- CONFIG END --
return cfg
