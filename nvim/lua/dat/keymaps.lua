-- Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

local keymap = vim.keymap

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize -2<cr>", { silent = true })
keymap.set("n", "<C-Down>", ":resize +2<cr>", { silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", { silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", { silent = true })
-- Delete single character without copying into register
keymap.set("n", "x", '"_x')
-- Motion cursor
keymap.set("n", "<S-h>", "^")
keymap.set("n", "<S-l>", "g_")
-- Focus Visual Block Mode
keymap.set("n", "<A-v>", "<C-v>")

-- Insert --
-- Delete previous word
keymap.set("i", "<C-H>", "<C-W>", { silent = true })

-- Visual --
keymap.set("v", "<S-h>", "^")
keymap.set("v", "<S-l>", "g_")
-- Search text
keymap.set("v", "*", "y/\\V<C-R>=escape(@\",'/\\')<cr><cr>N")

-- Plugins --
-- camelCase Motion
keymap.set("", "w", "<Plug>CamelCaseMotion_w")
keymap.set("", "b", "<Plug>CamelCaseMotion_b")
keymap.set("", "e", "<Plug>CamelCaseMotion_e")
keymap.set("x", "iw", "<Plug>CamelCaseMotion_iw")
keymap.set("x", "ib", "<Plug>CamelCaseMotion_ib")
keymap.set("x", "ie", "<Plug>CamelCaseMotion_ie")
