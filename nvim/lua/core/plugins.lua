-- Automatically install and set up packer.nvim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
    return
end

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    git = {
        clone_timeout = 500, -- Timeout, in seconds, for git clones
    },
})

vim.keymap.set("n", "<leader>pC", "<cmd>PackerCompile<CR>", { desc = "Compile" })
vim.keymap.set("n", "<leader>pS", "<cmd>PackerStatus<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>pc", "<cmd>PackerClean<CR>", { desc = "Clean" })
vim.keymap.set("n", "<leader>pi", "<cmd>PackerInstall<CR>", { desc = "Install" })
vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<CR>", { desc = "Sync" })
vim.keymap.set("n", "<leader>pu", "<cmd>PackerUpdate<CR>", { desc = "Update" })

return packer.startup(function(use)
    -- Manage package
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    -- Theme
    use("folke/tokyonight.nvim")
    use("rebelot/kanagawa.nvim")
    -- Completion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- LSP
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")
    use("SmiteshP/nvim-navic")
    use("b0o/schemastore.nvim")
    -- Support views
    use("nvim-tree/nvim-web-devicons")
    use("nvim-lualine/lualine.nvim")
    use("akinsho/nvim-bufferline.lua")
    use("nvim-treesitter/nvim-treesitter")
    use("lukas-reineke/indent-blankline.nvim")
    use("norcalli/nvim-colorizer.lua")
    use("RRethy/vim-illuminate")
    use("stevearc/dressing.nvim")
    use("petertriho/nvim-scrollbar")
    -- use("lewis6991/satellite.nvim")
    -- Support coding
    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")
    use("chaoren/vim-wordmotion")
    use("tpope/vim-surround")
    use("wellle/targets.vim")
    -- Explorer and find files
    use("folke/which-key.nvim")
    use("nvim-tree/nvim-tree.lua")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-project.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    -- Git
    use("lewis6991/gitsigns.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        packer.sync()
    end
end)
