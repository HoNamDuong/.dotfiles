local status, gitsigns = pcall(require, "gitsigns")
if not status then
    return
end

gitsigns.setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Prev hunk" })

        -- -- Actions
        map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
        map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
        map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Open diffview with revision" })
        map("n", "<leader>gD", function()
            gs.diffthis("~")
        end, { desc = "Open diffview with commit" })
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted [Git]" })
        map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle current line blame [Git]" })
        map("n", "<leader>gth", gs.toggle_linehl, { desc = "Toggle line highlighting [Git]" })
        map("n", "<leader>gtn", gs.toggle_numhl, { desc = "Toggle number highlighting [Git]" })
        map("n", "<leader>gts", gs.toggle_signs, { desc = "Toggle sign column [Git]" })
        map("n", "<leader>gtw", gs.toggle_word_diff, { desc = "Toggle word diff [Git]" })

        -- -- Text object
        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
})
