local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("keymap")
require("options")

require("lazy").setup({
    -- Fun stuff
    "ThePrimeagen/vim-be-good",
    "Eandrju/cellular-automaton.nvim",

    -- Colorschemes
    {
        "leana8959/one-nvim",
        config = function()
            vim.opt.background = "light"
            vim.cmd.colorscheme("one-nvim")
        end
    },

    -- Nice to have
    "tpope/vim-sleuth",
    "nvim-treesitter/playground",
    "RaafatTurki/hex.nvim",
    "nvim-lualine/lualine.nvim",
    "norcalli/nvim-colorizer.lua",
    "simrat39/symbols-outline.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "epwalsh/obsidian.nvim",
        lazy = true,
        event = { "BufReadPre " .. vim.fn.expand("~") .. "/repos/leana/diary/**.md" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
    },

    -- Can't live without
    "godlygeek/tabular",
    { "ggandor/leap.nvim",           dependencies = "tpope/vim-repeat" },
    { "shortcuts/no-neck-pain.nvim", version = "*" },
    "numToStr/Comment.nvim",
    "tpope/vim-surround",
    "lewis6991/gitsigns.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "windwp/nvim-autopairs",
    "tpope/vim-fugitive",
    "mbbill/undotree",
    "rafamadriz/friendly-snippets",
    "mizlan/iswap.nvim",
    { "ThePrimeagen/harpoon",           dependencies = "nvim-lua/plenary.nvim" },
    { "folke/todo-comments.nvim",       dependencies = "nvim-lua/plenary.nvim" },
    { "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'hrsh7th/cmp-buffer',
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip"
        }
    },

    -- Power tools
    "git@github.com:mfussenegger/nvim-jdtls.git",
    { "scalameta/nvim-metals",    dependencies = "nvim-lua/plenary.nvim" },
    { "simrat39/rust-tools.nvim", dependencies = "neovim/nvim-lspconfig" },
    {
        'mrcjkb/haskell-tools.nvim',
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
        branch = "2.x.x",
    },
    "kaarmu/typst.vim",
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = "nvim-lua/plenary.nvim"
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", enabled = true, tag = "legacy" },
            "folke/neodev.nvim",
        },
    },
    "mfussenegger/nvim-dap",
})
