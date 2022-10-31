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
--- LSP
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Jumps to the declaration" })
keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Lists all the implementations" })
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Jumps to the definition" })
keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Displays hover information" })
keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics" })
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Lists all the references" })
-- Previous/Next diagnostic
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { desc = "Previous diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { desc = "Next diagnostic" })
-- Previous/Next quickfix
keymap.set("n", "[f", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
keymap.set("n", "]f", "<cmd>cnext<cr>", { desc = "Next quickfix" })

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

-- Comment
keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", {
    desc = "Toggle comment",
})
keymap.set("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", {
    desc = "Toggle comment",
})
