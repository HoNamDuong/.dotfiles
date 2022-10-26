-- Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

local keymap = vim.keymap

-- Remap space as leader key
keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- Normal --
-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize -2<CR>", { silent = true })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })
-- Clear highlights
keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true })
-- Toggle wrap
keymap.set("n", "<leader>z", ":set wrap!<CR>", { silent = true })
-- Close buffer
keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })
keymap.set("n", "<leader>bq", ":bd!<CR>", { silent = true })
-- Navigate buffers
keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { silent = true })
-- Terminal
keymap.set("n", "<leader>t", ":bo 10new term://$SHELL<CR>i", { silent = true })
-- Save file
keymap.set("n", "<leader>w", ":w<CR>", { silent = true })
-- Quit
keymap.set("n", "<leader>q", ":q!<CR>")
-- Visual all
keymap.set("n", "<leader>a", "ggVG<CR>")
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

-- Plugins --
-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
-- Telescope
keymap.set("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { silent = true })
keymap.set("n", "<leader>fp", ":Telescope project display_type=full<CR>", { silent = true })
keymap.set("n", "<leader>ft", ":Telescope filetypes<CR>", { silent = true })
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { silent = true })
keymap.set("n", "<leader>fl", ":Telescope live_grep<CR>", { silent = true })
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })
keymap.set("n", "<leader>fo", ":Telescope oldfiles<CR>", { silent = true })
-- Comment
keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { silent = true })
keymap.set("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
