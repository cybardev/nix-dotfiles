local wezterm = require 'wezterm'
local act = wezterm.action

local config = {
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,

  window_background_opacity = 0.86,
  color_scheme = 'Kanagawa Dragon (Gogh)',

  font = wezterm.font 'CaskaydiaCove Nerd Font Mono',
  font_size = 14,

  keys = {
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
  },
}

return config
