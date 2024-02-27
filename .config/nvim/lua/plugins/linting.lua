return {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<leader>ll",
            function()
                require("lint").try_lint()
            end,
            desc = "Trigger linting",
        },
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            markdown = { "cspell" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            cpp = { "cpplint" },
            c = { "cpplint" },
        }
    end,
}
