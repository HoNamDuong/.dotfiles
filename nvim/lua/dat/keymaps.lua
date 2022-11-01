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
-- Motion cursor
keymap.set("n", "<S-h>", "^", { desc = "Start of line (no-blank)" })
keymap.set("n", "<S-l>", "g_", { desc = "End of line (no-blank)" })
-- Previous/Next diagnostic
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", { desc = "Previous diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", { desc = "Next diagnostic" })
-- Previous/Next quickfix
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
-- Previous/Next git change
-- keymap.set("n", "[c", "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", { desc = "Prev Hunk" })
-- keymap.set("n", "]c", "<cmd>lua require 'gitsigns'.next_hunk()<CR>", { desc = "Next Hunk" })

-- Insert --
-- Delete previous word
keymap.set("i", "<C-H>", "<C-W>", { desc = "Backward kill word" })

-- Visual --
keymap.set("v", "<S-h>", "^", { desc = "Start of line (no-blank)" })
keymap.set("v", "<S-l>", "g_", { desc = "End of line (no-blank)" })
-- Search for visually selected text
keymap.set("v", "/", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>N", { desc = "Search for visually selected text" })
-- Paste over currently selected text without yanking it
keymap.set("v", "p", '"_dP', { desc = "Paste over currently selected text" })
-- Better indent
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Plugins --
-- Comment
keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {
    desc = "Toggle comment",
})
keymap.set("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {
    desc = "Toggle comment",
})
-- LSP
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Jumps to the declaration" })
keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Lists all the implementations" })
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Jumps to the definition" })
keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Displays hover information" })
keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics" })
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Lists all the references" })
keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })

-- keymap.set("n", "K", function()
--     local filetype = vim.bo.filetype
--     if vim.tbl_contains({ "vim", "help" }, filetype) then
--         vim.cmd("h " .. vim.fn.expand("<cword>"))
--     elseif vim.tbl_contains({ "man" }, filetype) then
--         vim.cmd("Man " .. vim.fn.expand("<cword>"))
--     else
--         vim.lsp.buf.hover()
--     end
-- end, { noremap = true, silent = true })
