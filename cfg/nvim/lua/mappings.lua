require "nvchad.mappings"

local map = vim.keymap.set

-- add yours here

map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "t" }, "<leader>`", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

