return {
    -- Parser generator tool
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "comment",
                    "css",
                    "diff",
                    "html",
                    "javascript",
                    "json",
                    "jsonc",
                    "lua",
                    "markdown",
                    "python",
                    "query",
                    "regex",
                    "vim",
                    "yaml",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
                -- nvim-treesitter/nvim-treesitter-textobjects
                textobjects = {},
                -- windwp/nvim-ts-autotag
                autotag = { enable = true },
            })
        end,
    },
}
