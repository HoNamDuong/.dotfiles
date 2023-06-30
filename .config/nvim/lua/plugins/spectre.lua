require("spectre").setup()

vim.keymap.set("n", "<leader>f", '<cmd>lua require("spectre").open()<CR>', { desc = "Open Spectre" })
