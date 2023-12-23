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
local keymap = vim.keymap

-- Move to window
keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Go to right window" })
-- Resize window
keymap.set("n", "<C-Up>", ":resize +5<CR>", { silent = true, desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -5<CR>", { silent = true, desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize -5<CR>", { silent = true, desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +5<CR>", { silent = true, desc = "Increase window width" })
-- Buffer
keymap.set("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Switch to other buffer" })
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })
keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- Tab
keymap.set("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader><tab>c", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Only tab" })
keymap.set("n", "[<tab>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
keymap.set("n", "]<tab>", "<cmd>tabnext<CR>", { desc = "Next tab" })
-- Quickfix
keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix" })
keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
keymap.set("n", "[c", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
keymap.set("n", "]c", "<cmd>cnext<CR>", { desc = "Next quickfix" })
-- Move lines
keymap.set("n", "<A-j>", ":move .+1<CR>==", { desc = "Moving lines down" })
keymap.set("n", "<A-k>", ":move .-2<CR>==", { desc = "Moving lines up" })
keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi", { desc = "Moving lines down" })
keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi", { desc = "Moving lines up" })
keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Moving lines down" })
keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Moving lines up" })
-- Motion cursor
keymap.set({ "n", "v" }, "<S-h>", "^", { desc = "Start of line (no-blank)" })
keymap.set({ "n", "v" }, "<S-l>", "g_", { desc = "End of line (no-blank)" })
-- Better indent
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })
-- Toggle
keymap.set("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "Toggle spell" })
keymap.set("n", "<leader>tz", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
keymap.set("n", "<leader>tn", "<cmd>set number!<CR>", { desc = "Toggle number column" })
-- Commands
keymap.set("n", "<leader>;c", "<cmd>checkhealth<CR>", { desc = "Check health" })
keymap.set("n", "<leader>;C", "<cmd>e $MYVIMRC<CR>", { desc = "Open config neovim" })
keymap.set("n", "<leader>;r", "<cmd>source %<CR>", { desc = "Refresh config" })
keymap.set("n", "<leader>;t", "<cmd>bo 10new term://$SHELL<CR>i", { desc = "Open terminal" })
keymap.set("n", "<leader>;n", "<cmd>enew<cr>", { desc = "New file" })
keymap.set("n", "<leader>;i", vim.show_pos, { desc = "Inspect Pos" })
-- Other
keymap.set("n", "<leader>a", "ggVG", { desc = "Visual all" })
keymap.set("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
keymap.set("n", "x", '"_x', { desc = "Delete single character without copying into register" })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><esc>", { desc = "Escape and clear hlsearch" })
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("v", "/", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>N", { desc = "Search for visually selected text" })
keymap.set("v", "p", '"_dP', { desc = "Paste over currently selected text without yanking it" })
