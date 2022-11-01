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
    icons = {
        group = "+ ", -- symbol prepended to a group
    },
    window = {
        -- border = "rounded",
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
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No highlight" },
    ["q"] = { "<cmd>qa!<CR>", "Quit!" },
    ["w"] = { "<cmd>w<CR>", "Save" },

    m = {
        name = "Menu",
        C = { "<cmd>CmpStatus<CR>", "Check cmp status" },
        T = { "<cmd>TSModuleInfo<CR>", "TreeSitter module info" },
        c = { "<cmd>checkhealth<CR>", "Check health" },
        i = { "<cmd>e $MYVIMRC<CR>", "Open config init" },
        m = { "<cmd>Mason<CR>", "Manager server lsp [Mason]" },
        n = { "<cmd>NullLsInfo<CR>", "NullLsInfo" },
        r = { "<cmd>source %<CR>", "Refresh config" },
        t = { "<cmd>bo 10new term://$SHELL<CR>i", "Open terminal" },
        z = { "<cmd>ColorizerReloadAllBuffers<CR>", "Colorizer reload" },
        q = {
            name = "QuickFix",
            o = { "<cmd>copen<CR>", "Open quickfix" },
            c = { "<cmd>cclose<CR>", "Close quickfix" },
        },
    },
    t = {
        name = "Toggle...",
        s = { "<cmd>syntax on<CR><cmd>syntax spell toplevel<CR><cmd>set spell!<CR>", "Toggle spell" },
        z = { "<cmd>set wrap!<CR>", "Toggle wrap" },
        n = { "<cmd>set number!<CR>", "Toggle number column" },
    },
    s = {
        name = "Search",
        C = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
        H = { "<cmd>Telescope highlights<CR>", "Highlight" },
        b = { "<cmd>Telescope builtin theme=dropdown previewer=false<CR>", "Builtin" },
        c = { "<cmd>Telescope commands<CR>", "Commands" },
        f = { "<cmd>Telescope find_files hidden=true<CR>", "Find File" },
        h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
        k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
        l = { "<cmd>Telescope live_grep<CR>", "Find Text" },
        m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
        o = { "<cmd>Telescope oldfiles<CR>", "Recent File" },
        p = { "<cmd>Telescope project display_type=full theme=dropdown<CR>", "Projects" },
        r = { "<cmd>Telescope registers<CR>", "Registers" },
        t = { "<cmd>Telescope filetypes<CR>", "Filetype" },
    },
    b = {
        name = "Buffer",
        b = { "<cmd>b#<CR>", "Previous" },
        d = { "<cmd>bdelete<CR>", "Buffer delete" },
        l = { "<cmd>Telescope buffers theme=dropdown previewer=false<CR>", "Buffers" },
        n = { "<cmd>bnext<CR>", "Buffer next" },
        p = { "<cmd>bprevious<CR>", "Buffer previous" },
        q = { "<cmd>bd!<CR>", "Buffer delete !" },
    },
    p = {
        name = "Packer",
        C = { "<cmd>PackerCompile<CR>", "Compile" },
        S = { "<cmd>PackerStatus<CR>", "Status" },
        c = { "<cmd>PackerClean<CR>", "Clean" },
        i = { "<cmd>PackerInstall<CR>", "Install" },
        s = { "<cmd>PackerSync<CR>", "Sync" },
        u = { "<cmd>PackerUpdate<CR>", "Update" },
    },
    g = {
        name = "Git",
        l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },

        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },

        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk" },

        o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
        d = { "<cmd>Gitsigns diffthis HEAD<CR>", "Diff" },

        t = {
            name = "Toggle...",
            d = { "<cmd>Gitsigns toggle_deleted<CR>", "Toggle deleted" },
            c = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
            l = { "<cmd>Gitsigns toggle_linehl<CR>", "Toggle line highlighting" },
            n = { "<cmd>Gitsigns toggle_numhl<CR>", "Toggle number highlighting" },
            s = { "<cmd>Gitsigns toggle_signs<CR>", "Toggle sign column" },
            w = { "<cmd>Gitsigns toggle_word_diff<CR>", "Toggle word diff" },
        },
    },
    l = {
        name = "LSP",
        i = { "<cmd>LspInfo<CR>", "Info" },
        R = { "<cmd>LspRestart<CR>", "Restart" },

        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<CR>", "Format" },

        s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },

        w = { "<cmd>Telescope diagnostics<CR>", "Workspace Diagnostics" },
        d = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
    },
}

whichkey.register(mappings, opts)
