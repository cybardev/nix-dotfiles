-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.relativenumber = true

lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "olimorris/onedarkpro.nvim" },
}

lvim.colorscheme = "onedark_dark"
lvim.format_on_save.enabled = true
lvim.builtin.terminal.open_mapping = "<C-`>"

-- swap ; and : in normal mode
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("n", ":", ";", { noremap = true })
