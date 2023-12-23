vim.opt.breakindent = true -- Maintain indent when wrapping indented lines
vim.opt.linebreak = true -- Wrap at word boundaries
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Mostly just for cmp
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.fileencoding = "utf-8" -- The encoding written to a file
vim.opt.ignorecase = true -- Ignore case
vim.opt.laststatus = 3 -- Global statusline
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.updatetime = 300 -- Faster completion (4000ms default)
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.showmode = false -- Don't show mode since we have a statusline
vim.opt.showtabline = 0 -- Never show tabs
vim.opt.scrolloff = 4 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns to keep to the left and right of the cursor
vim.opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.termguicolors = true -- True color support
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.whichwrap:append("<,>,[,],h,l") -- Keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.wrap = false -- Disable line wrap
vim.opt.ruler = false -- Hide the line and column number of the cursor position
vim.opt.undofile = true -- Automatically saves undo history to an undo file
-- Session options
vim.opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "terminal", "winsize" }
-- Fold option
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- Spell check
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.spelloptions = "camel"

-- vim.opt.textwidth = 80 -- Maximum width of text that is being inserted
-- vim.opt.colorcolumn = "+1" -- Set the colour column to highlight one column after the 'textwidth'
-- vim.opt.iskeyword:append("-") -- Treats words with `-` as single words
