-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>jj", ":call RangeJsonBeautify()<CR>")
