vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "checkhealth" },
    callback = function()
        vim.cmd([[
            nnoremap <silent> <buffer> q :close<CR> 
            set nobuflisted 
        ]])
    end,
    desc = "Windows to close with 'q'",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
    desc = "Auto adjust resize",
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
    desc = "Disable automatic comment in newline",
})

vim.api.nvim_create_augroup("CursorInsertMode", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    callback = function()
        vim.opt.cursorline = true
    end,
    group = "CursorInsertMode",
    desc = "Enable cursorline in normal mode",
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    callback = function()
        vim.opt.cursorline = false
    end,
    group = "CursorInsertMode",
    desc = "Disable cursorline on insert",
})

vim.api.nvim_create_autocmd("BufRead", {
    callback = function()
        vim.api.nvim_create_autocmd("BufWinEnter", {
            once = true,
            callback = function()
                vim.defer_fn(function()
                    vim.cmd([[:silent! loadview]])
                end, 60)
            end,
            desc = "Load the view for the current file",
        })
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        vim.cmd([[:mkview]])
    end,
    desc = "Store the view for the current window",
})

-- if vim.fn.has("wsl") == 1 then
--     vim.api.nvim_create_autocmd("TextYankPost", {
--         group = vim.api.nvim_create_augroup("Yank", { clear = true }),
--         callback = function()
--             vim.fn.system("clip.exe", vim.fn.getreg('"'))
--         end,
--         desc = "Yanking to windows clipboard from nvim (WSL)",
--     })
-- end
