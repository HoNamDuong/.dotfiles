-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local map = vim.keymap.set

-- Move to window
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { silent = true, desc = "Go to right window" })
-- Resize window
map("n", "<C-Up>", ":resize +5<CR>", { silent = true, desc = "Increase window height" })
map("n", "<C-Down>", ":resize -5<CR>", { silent = true, desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -5<CR>", { silent = true, desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +5<CR>", { silent = true, desc = "Increase window width" })
-- Buffer
map("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Switch to other buffer" })
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>%bd<CR>", { desc = "Delete all buffers" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- Tab
map("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader><tab>c", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Only tab" })
map("n", "[<tab>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "]<tab>", "<cmd>tabnext<CR>", { desc = "Next tab" })
-- Quickfix
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
-- Move lines
map("n", "<A-j>", ":move .+1<CR>==", { desc = "Moving lines down" })
map("n", "<A-k>", ":move .-2<CR>==", { desc = "Moving lines up" })
map("i", "<A-j>", "<Esc>:move .+1<CR>==gi", { desc = "Moving lines down" })
map("i", "<A-k>", "<Esc>:move .-2<CR>==gi", { desc = "Moving lines up" })
map("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Moving lines down" })
map("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Moving lines up" })
-- Motion cursor
map({ "n", "v" }, "<S-h>", "_", { desc = "Start of line (no-blank)" })
map({ "n", "v" }, "<S-l>", "g_", { desc = "End of line (no-blank)" })
-- Better indent
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
-- Toggle
map("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "Toggle spell" })
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
map("n", "<leader>tn", "<cmd>set number!<CR>", { desc = "Toggle number column" })
map("n", "<leader>tr", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative column" })
-- Commands
map("n", "<leader>;c", "<cmd>checkhealth<CR>", { desc = "Check health" })
map("n", "<leader>;C", "<cmd>e $MYVIMRC<CR>", { desc = "Open config neovim" })
map("n", "<leader>;r", "<cmd>source %<CR>", { desc = "Refresh config" })
map("n", "<leader>;t", "<cmd>bo 10new term://$SHELL<CR>i", { desc = "Open terminal" })
map("n", "<leader>;n", "<cmd>enew<cr>", { desc = "New file" })
map("n", "<leader>;i", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
-- Other
map("n", "<leader>a", "ggVG", { desc = "Visual all" })
map("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "x", '"_x', { desc = "Delete single character without copying into register" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear hlsearch" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("x", "/", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>N", { desc = "Search for visually selected text" })
map("x", "p", "P", { desc = "Put without overwriting registers" })
