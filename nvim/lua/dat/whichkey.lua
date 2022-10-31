local status, whichkey = pcall(require, "which-key")
if not status then
    return
end

whichkey.setup({
    -- plugins = {
    --     marks = true, -- shows a list of your marks on ' and `
    --     registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    --     spelling = {
    --         enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    --         suggestions = 20, -- how many suggestions should be shown in the list?
    --     },
    --     -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    --     -- No actual key bindings are created
    --     presets = {
    --         operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
    --         motions = true, -- adds help for motions
    --         text_objects = true, -- help for text objects triggered after entering an operator
    --         windows = true, -- default bindings on <c-w>
    --         nav = true, -- misc bindings to work with windows
    --         z = true, -- bindings for folds, spelling and others prefixed with z
    --         g = true, -- bindings for prefixed with g
    --     },
    -- },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = { min = 1, max = 25 }, -- min and max height of the columns
        width = { min = 15, max = 100 }, -- min and max width of the columns
        spacing = 2, -- spacing between columns
        align = "center", -- align columns left, center or right
    },
    -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    triggers = "auto", -- automatically setup triggers
    -- disable the WhichKey popup for certain buf types and file types.
    disable = {
        buftypes = {},
        filetypes = {
            "NvimTree",
            "TelescopePrompt",
            "packer",
            "lspinfo",
            "null-ls-info",
            "mason",
        },
    },
})

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = false,
    noremap = true,
    nowait = true,
}

local mappings = {
    ["a"] = { "ggVG", "Visual all" },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["h"] = { "<cmd>nohlsearch<cr>", "No highlight" },
    ["q"] = { "<cmd>qa!<cr>", "Quit!" },
    ["w"] = { "<cmd>w!<cr>", "Save" },

    m = {
        name = "Menu",
        C = { "<cmd>CmpStatus<cr>", "Check cmp status" },
        T = { "<cmd>TSModuleInfo<cr>", "TreeSitter module info" },
        c = { "<cmd>checkhealth<cr>", "Check health" },
        i = { "<cmd>e $MYVIMRC<cr>", "Open config init" },
        m = { "<cmd>Mason<cr>", "Manager server lsp [Mason]" },
        n = { "<cmd>NullLsInfo<cr>", "NullLsInfo" },
        r = { "<cmd>source %<cr>", "Refresh config" },
        t = { "<cmd>bo 10new term://$SHELL<cr>i", "Open terminal" },
        z = { "<cmd>ColorizerReloadAllBuffers<cr>", "Colorizer reload" },
    },
    t = {
        name = "Toggle...",
        s = { "<cmd>syntax on<cr><<cmd>syntax spell toplevel<cr><cmd>set spell!<cr>", "Toggle spell" },
        z = { "<cmd>set wrap!<cr>", "Toggle wrap" },
        n = { "<cmd>set number!<cr>", "Toggle number column" },
    },
    s = {
        name = "Search",
        C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        H = { "<cmd>Telescope highlights<cr>", "Highlight" },
        b = { "<cmd>Telescope builtin theme=dropdown previewer=false<cr>", "Builtin" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        f = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        l = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        o = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        p = { "<cmd>Telescope project display_type=full theme=dropdown<cr>", "Projects" },
        r = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope filetypes<cr>", "Filetype" },
    },
    b = {
        name = "Buffer",
        b = { "<cmd>b#<cr>", "Previous" },
        d = { "<cmd>bdelete<cr>", "Buffer delete" },
        l = { "<cmd>Telescope buffers theme=dropdown previewer=false<cr>", "Buffers" },
        n = { "<cmd>bnext<cr>", "Buffer next" },
        p = { "<cmd>bprevious<cr>", "Buffer previous" },
        q = { "<cmd>bd!<cr>", "Buffer delete !" },
    },
    p = {
        name = "Packer",
        S = { "<cmd>PackerStatus<cr>", "Status" },
        c = { "<cmd>PackerClean<cr>", "Clean" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        p = { "<cmd>PackerCompile<cr>", "Compile" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
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
            d = { "<cmd>Gitsigns toggle_deleted<cr>", "Toggle deleted" },
            l = { "<cmd>Gitsigns toggle_linehl<cr>", "Toggle line highlighting" },
            n = { "<cmd>Gitsigns toggle_numhl<cr>", "Toggle number highlighting" },
            s = { "<cmd>Gitsigns toggle_signs<cr>", "Toggle sign column" },
            w = { "<cmd>Gitsigns toggle_word_diff<cr>", "Toggle word diff" },
        },
    },
    l = {
        name = "LSP",
        i = { "<cmd>LspInfo<cr>", "Info" },
        R = { "<cmd>LspRestart<cr>", "Restart" },

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
