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
-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Go to the left window" })
keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Go to the down window" })
keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Go to the up window" })
keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Go to the right window" })
-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize -5<CR>", { silent = true, desc = "Decrease height" })
keymap.set("n", "<C-Down>", ":resize +5<CR>", { silent = true, desc = "Increase height" })
keymap.set("n", "<C-Left>", ":vertical resize -5<CR>", { silent = true, desc = "Decrease width" })
keymap.set("n", "<C-Right>", ":vertical resize +5<CR>", { silent = true, desc = "Increase width" })
-- Delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete single character without copying into register" })
-- No highlight
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "No highlight" })

-- Leader ---
keymap.set("n", "<leader>a", "ggVG", { desc = "Visual all" })
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No highlight" })
keymap.set("n", "<leader>q", "<cmd>qa!<CR>", { desc = "Quit!" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
-- Buffer
keymap.set("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Switch to other buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
keymap.set("n", "<leader>ba", "<cmd>%bdelete<CR>", { desc = "Delete all buffers" })
keymap.set("n", "<leader>bq", "<cmd>bd!<CR>", { desc = "Delete buffer[!]" })
keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- Tab
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader><tab>c", "<cmd>tabclose<CR>", { desc = "Delete tab" })
keymap.set("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Only tab" })
keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
-- Toggle
keymap.set("n", "<leader>ts", "<cmd>syntax on<CR><cmd>syntax spell toplevel<CR><cmd>set spell!<CR>", { desc = "Toggle spell" })
keymap.set("n", "<leader>tz", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
keymap.set("n", "<leader>tn", "<cmd>set number!<CR>", { desc = "Toggle number column" })
-- Commands
keymap.set("n", "<leader>;c", "<cmd>checkhealth<CR>", { desc = "Check health" })
keymap.set("n", "<leader>;i", "<cmd>e $MYVIMRC<CR>", { desc = "Open config init" })
keymap.set("n", "<leader>;r", "<cmd>source %<CR>", { desc = "Refresh config" })
keymap.set("n", "<leader>;t", "<cmd>bo 10new term://$SHELL<CR>i", { desc = "Open terminal" })
keymap.set("n", "<leader>;C", "<cmd>CmpStatus<CR>", { desc = "[CmpStatus]" })
keymap.set("n", "<leader>;T", "<cmd>TSModuleInfo<CR>", { desc = "[TSModuleInfo]" })
keymap.set("n", "<leader>;m", "<cmd>Mason<CR>", { desc = "[Mason]" })
keymap.set("n", "<leader>;C", "<cmd>ColorizerReloadAllBuffers<CR>", { desc = "[ColorizerReloadAllBuffers]" })
keymap.set("n", "<leader>;n", "<cmd>NullLsInfo<CR>", { desc = "[NullLsInfo]" })
-- Quickfix
keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix" })
keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })

-- Insert --
-- Delete previous word
keymap.set("i", "<C-H>", "<C-W>", { desc = "Backward kill word" })

-- Visual --
-- Search for visually selected text
keymap.set("v", "/", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>N", { desc = "Search for visually selected text" })
-- Paste over currently selected text without yanking it
keymap.set("v", "p", '"_dP', { desc = "Paste over currently selected text" })
-- Better indent
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Motion cursor
keymap.set({ "n", "v" }, "<S-h>", "^", { desc = "Start of line (no-blank)" })
keymap.set({ "n", "v" }, "<S-l>", "g_", { desc = "End of line (no-blank)" })
-- Move Lines
keymap.set("n", "<A-j>", ":move .+1<CR>==", { desc = "Moving lines down" })
keymap.set("n", "<A-k>", ":move .-2<CR>==", { desc = "Moving lines up" })
keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi", { desc = "Moving lines down" })
keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi", { desc = "Moving lines up" })
keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Moving lines down" })
keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Moving lines up" })
