local status, whichkey = pcall(require, "which-key")
if not status then
    return
end

whichkey.setup({
    plugins = {
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "none",
        margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = { min = 1, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    triggers = "auto", -- automatically setup triggers
})

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
    ["a"] = { "ggVG", "Visual all" },
    ["w"] = { "<cmd>w!<cr>", "Save" },
    ["q"] = { "<cmd>q!<cr>", "Quit!" },
    ["z"] = { "<cmd>set wrap!<cr>", "Toggle Wrap" },
    ["c"] = { "<cmd>set spell!<cr>", "Toggle spell" },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["h"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
    ["t"] = { "<cmd>bo 10new term://$SHELL<cr>i", "Terminal" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "Comment" },

    s = {
        name = "Search",
        b = { "<cmd>Telescope builtin theme=dropdown previewer=false<cr>", "Builtin" },
        p = { "<cmd>Telescope project display_type=full theme=dropdown<cr>", "Projects" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        o = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        r = { "<cmd>Telescope registers<cr>", "Registers" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        l = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        f = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" },
        t = { "<cmd>Telescope filetype<cr>", "Filetype" },
        d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    },
    b = {
        name = "Buffer",
        n = { "<cmd>bnext<cr>", "Buffer next" },
        p = { "<cmd>bprevious<cr>", "Buffer previous" },
        d = { "<cmd>bdelete<cr>", "Buffer delete" },
        q = { "<cmd>bd!<cr>", "Buffer delete !" },
        l = { "<cmd>Telescope buffers theme=dropdown previewer=false<cr>", "Buffers" },
    },
    p = {
        name = "Packer",
        p = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        c = { "<cmd>PackerClean<cr>", "Clean" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },

        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },

        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },

        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },

        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },

        t = {
            name = "Toggle...",
            s = { "<cmd>Gitsigns toggle_signs<cr>", "Toggle sign column" },
            n = { "<cmd>Gitsigns toggle_numhl<cr>", "Toggle number highlighting" },
            d = { "<cmd>Gitsigns toggle_deleted<cr>", "Toggle deleted" },
            l = { "<cmd>Gitsigns toggle_linehl<cr>", "Toggle line highlighting" },
            w = { "<cmd>Gitsigns toggle_word_diff<cr>", "Toggle word diff" },
        },
    },
    l = {
        name = "LSP",
        i = { "<cmd>LspInfo<cr>", "Info" },

        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },

        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },

        w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
    },
    f = {
        name = "QuickFix",
        o = { "<cmd>copen<cr>", "Open quickfix" },
        c = { "<cmd>cclose<cr>", "Close quickfix" },
    },
}

whichkey.register(mappings, opts)
whichkey.register({
    d = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Previous diagnostic." },
    f = { "<cmd>cprev<cr>", "Previous quickfix" },
}, { mode = "n", prefix = "[" })
whichkey.register({
    d = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next diagnostic." },
    f = { "<cmd>cnext<cr>", "Next quickfix" },
}, { mode = "n", prefix = "]" })

whichkey.register({
    ["/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "Comment" },
}, { mode = "x", prefix = "<leader>" })
