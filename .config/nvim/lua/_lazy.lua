local plugins = {
    ----------------------
    -- Misc / utilities --
    ----------------------
    "nvim-tree/nvim-web-devicons", -- Icons
    "tpope/vim-sleuth", -- Tab / Space detection
    "tpope/vim-surround", -- Surround motions
    "tpope/vim-fugitive", -- Git util
    { "windwp/nvim-autopairs", event = "InsertEnter" }, -- Pair symbols
    "mbbill/undotree", -- Treeview of history
    "godlygeek/tabular", -- Vertical alignment
    { "stevearc/oil.nvim", dependencies = "nvim-tree/nvim-web-devicons" }, -- File manager
    { "uga-rosa/ccc.nvim", opts = {} },
    -- `gc` to comment
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
    },
    -- Jump anywhere
    {
        "ggandor/leap.nvim",
        dependencies = "tpope/vim-repeat",
        config = function() require("leap").add_default_mappings() end,
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
    { "shortcuts/no-neck-pain.nvim", version = "*" }, -- Align buffer
    "lewis6991/gitsigns.nvim", -- Gitsigns in gutter
    "NvChad/nvim-colorizer.lua", -- Show color
    -- Jump like a ninja
    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        branch = "harpoon2",
    },
    -- Highlight comments
    { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
    -- Status line
    { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
    -- Breadcrumbs
    { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" },

    ---------------
    -- LSP / DAP --
    ---------------
    {
        "neovim/nvim-lspconfig", -- (official) basic LSP Configuration & Plugins
        dependencies = {
            "j-hui/fidget.nvim", -- LSP Spinner
        },
    },
    "mfussenegger/nvim-dap", -- DAP

    -----------------------
    -- Language specific --
    -----------------------
    "mfussenegger/nvim-jdtls",
    "isobit/vim-caddyfile",
    {
        "scalameta/nvim-metals",
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = "rust",
    },
    { "andy-morris/happy.vim", ft = "happy" },
    { "vim-scripts/alex.vim", ft = "alex" },
    {
        "mrcjkb/haskell-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        version = "^3",
        lazy = false,
    },
    {
        "turbio/bracey.vim",
        build = "npm install --prefix server",
        cond = vim.fn.executable("npm") == 1,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = vim.fn.executable("make") == 1,
            },
        },
    },

    ---------------
    -- TreeSitter --
    ----------------
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
        build = ":TSUpdate",
    },
    "nvim-treesitter/nvim-treesitter-context",

    -----------
    -- Games --
    -----------
    "wakatime/vim-wakatime",

    ------------------
    -- Colorschemes --
    ------------------
    {
        "leana8959/curry.nvim",
        dev = false,
    },

    ----------------
    -- Completion --
    ----------------
    {
        "hrsh7th/nvim-cmp", -- Autocompletion
        dependencies = {
            "L3MON4D3/LuaSnip", -- Snippet Engine
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp", -- LSP completion
            "rafamadriz/friendly-snippets", -- Adds a number of user-friendly snippets
            "hrsh7th/cmp-buffer", -- Buffer cmp source
            "f3fora/cmp-spell", -- Spell cmp source
            "mrcjkb/haskell-snippets.nvim", -- Haskell snippets
        },
    },
}

local opts = {
    dev = {
        path = "~/repos/leana/",
    },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

require("lazy").setup(plugins, opts)
