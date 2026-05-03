return {
    -- Fast and feature-rich surround actions
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
    -- Comments
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
    -- Auto pairs
    {
        "nvim-mini/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
        },
    },
    -- Better text-objects
    {
        "nvim-mini/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                mappings = {
                    -- Disable next/last variants
                    around_next = "",
                    inside_next = "",
                    around_last = "",
                    inside_last = "",
                },
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }, {}),
                    c = ai.gen_spec.treesitter({
                        a = "@class.outer",
                        i = "@class.inner",
                    }, {}),
                    d = { "%f[%d]%d+" }, -- digits
                    e = { { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" }, "^().*()$" }, -- Word with case
                },
            }
        end,
    },
}
