local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
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
        clone_timeout = 300, -- Timeout, in seconds, for git clones
    },
})

-- vim.cmd([[packadd packer.nvim]])

return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")

    use("folke/tokyonight.nvim")
    use("rebelot/kanagawa.nvim")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-signature-help")

    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("onsails/lspkind.nvim")
    use("jose-elias-alvarez/null-ls.nvim")

    use("nvim-tree/nvim-web-devicons")
    use("nvim-treesitter/nvim-treesitter")
    use("nvim-lualine/lualine.nvim")
    use("akinsho/nvim-bufferline.lua")
    use("lukas-reineke/indent-blankline.nvim")
    use("norcalli/nvim-colorizer.lua")
    use("RRethy/vim-illuminate")

    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")
    use("tpope/vim-surround")
    use("bkad/CamelCaseMotion")

    use("nvim-tree/nvim-tree.lua")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-project.nvim")

    use("lewis6991/gitsigns.nvim")

    if packer_bootstrap then
        packer.sync()
    end
end)
