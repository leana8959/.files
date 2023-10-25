local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require "keymap"
require "options"
require "autocmds"

require "lazy".setup {

    ----------------------
    -- Misc / utilities --
    ----------------------
    "nvim-tree/nvim-web-devicons", -- Icons
    "tpope/vim-sleuth",            -- tab / space detection
    "tpope/vim-surround",          -- Surround motions
    "tpope/vim-fugitive",          -- Git util
    "windwp/nvim-autopairs",       -- Pair symbols
    "mbbill/undotree",             -- Treeview of history
    "godlygeek/tabular",           -- Vertical alignment
    -- `gc` to comment
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function() require "Comment".setup() end,
    },
    -- Jump anywhere
    {
        "ggandor/leap.nvim",
        dependencies = "tpope/vim-repeat",
        config = function() require "leap".add_default_mappings() end,
    },
    -- Folding
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
    },
    -- Generate `.gitignore`
    {
        "wintermute-cell/gitignore.nvim",
        dependencies = "nvim-telescope/telescope.nvim",
    },

    ----------------
    -- Style / UI --
    ----------------
    "folke/twilight.nvim",                            -- Zen mode
    { "shortcuts/no-neck-pain.nvim", version = "*" }, -- Align buffer
    "lewis6991/gitsigns.nvim",                        -- Gitsigns in gutter
    "NvChad/nvim-colorizer.lua",                      -- Show color
    -- Indent char style with scoping
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    -- Jump like a ninja
    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
    },
    -- Highlight comments
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    -- Status line
    "nvim-lualine/lualine.nvim",
    { "SmiteshP/nvim-navic",         dependencies = "neovim/nvim-lspconfig" },

    ---------------
    -- LSP / DAP --
    ---------------
    "neovim/nvim-lspconfig",                        -- Collection of preconfigured LSP clients
    "folke/neodev.nvim",                            -- neovim lua helper
    "williamboman/mason.nvim",                      -- portable package manager
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim",        tag = "legacy" }, -- Show fancy LSP messages
    "mfussenegger/nvim-dap",                        -- DAP

    -----------------------
    -- Language specific --
    -----------------------
    -- Java
    "mfussenegger/nvim-jdtls",
    -- Scala
    { "scalameta/nvim-metals",    dependencies = "nvim-lua/plenary.nvim" },
    -- Rust
    { "simrat39/rust-tools.nvim", dependencies = "neovim/nvim-lspconfig" },
    -- Haskell
    {
        "mrcjkb/haskell-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        branch = "2.x.x",
    },
    -- Typst
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
    -- HTML / JavaScript (live preview)
    { "turbio/bracey.vim",               build = "npm install --prefix server" },

    ---------------
    -- Telescope --
    ---------------
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable "make" == 1,
    },

    ----------------
    -- TreeSitter --
    ----------------
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-context",

    -----------
    -- Games --
    -----------
    "ThePrimeagen/vim-be-good",
    "Eandrju/cellular-automaton.nvim",

    ------------------
    -- Colorschemes --
    ------------------
    {
        "https://git.earth2077.fr/leana/curry.nvim",
        config = function()
            vim.opt.background = "light"
            vim.cmd.colorscheme "curry"
        end,
        enabled = true,
    },

    ----------------
    -- Completion --
    ----------------
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
}
