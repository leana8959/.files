(import-macros {: require-then!} :macros)

(let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system [:git
                    :clone
                    "--filter=blob:none"
                    "https://github.com/folke/lazy.nvim.git"
                    :--branch=stable
                    lazypath]))
  (vim.opt.runtimepath:prepend lazypath))

(let [plugins [;;;;;;;;;;;;;;;;;;;;
               ; Misc / utilities ;
               ;;;;;;;;;;;;;;;;;;;;
               :nvim-tree/nvim-web-devicons
               :tpope/vim-sleuth
               :tpope/vim-surround
               :tpope/vim-fugitive
               :windwp/nvim-autopairs
               :mbbill/undotree
               :godlygeek/tabular
               :uga-rosa/ccc.nvim
               :stevearc/oil.nvim
               {1 :numToStr/Comment.nvim :opts {}}
               {1 :ggandor/leap.nvim
                :dependencies :tpope/vim-repeat
                :config #(require-then! :leap #($.add_default_mappings))}
               {1 :kevinhwang91/nvim-ufo
                :dependencies :kevinhwang91/promise-async}
               {1 :wintermute-cell/gitignore.nvim
                :dependencies :nvim-telescope/telescope.nvim}
               ;;;;;;;;;;;;;;
               ; Style / UI ;
               ;;;;;;;;;;;;;;
               :folke/twilight.nvim
               {1 :shortcuts/no-neck-pain.nvim :version "*"}
               :lewis6991/gitsigns.nvim
               :NvChad/nvim-colorizer.lua
               {1 :ThePrimeagen/harpoon :dependencies :nvim-lua/plenary.nvim}
               {1 :folke/todo-comments.nvim
                :dependencies :nvim-lua/plenary.nvim}
               :nvim-lualine/lualine.nvim
               {1 :SmiteshP/nvim-navic :dependencies :neovim/nvim-lspconfig}
               ;;;;;;;;;;;;;
               ; LSP / DAP ;
               ;;;;;;;;;;;;;
               {1 :neovim/nvim-lspconfig
                :dependencies [{1 :j-hui/fidget.nvim :tag :legacy}
                               :folke/neodev.nvim]}
               :mfussenegger/nvim-dap
               {1 :ray-x/lsp_signature.nvim :event :VeryLazy}
               ;;;;;;;;;;;;;;;;;;;;;
               ; Language specific ;
               ;;;;;;;;;;;;;;;;;;;;;
               ; Java
               :mfussenegger/nvim-jdtls
               ; Scala
               {1 :scalameta/nvim-metals :dependencies :nvim-lua/plenary.nvim}
               ; Rust
               {1 :simrat39/rust-tools.nvim
                :dependencies :neovim/nvim-lspconfig}
               ; Haskell
               {1 :mrcjkb/haskell-tools.nvim
                :dependencies [:nvim-lua/plenary.nvim
                               :nvim-telescope/telescope.nvim]
                :ft [:haskell :lhaskell :cabal :cabalproject]
                :branch :2.x.x}
               ; Typst
               {1 :kaarmu/typst.vim :ft :typst :lazy false}
               ; HTML / JavaScript (live preview)
               {1 :turbio/bracey.vim :build "npm install --prefix server"}
               ;;;;;;;;;;;;;
               ; Telescope ;
               ;;;;;;;;;;;;;
               {1 :nvim-telescope/telescope.nvim
                :branch :0.1.x
                :dependencies [:nvim-lua/plenary.nvim
                               {1 :nvim-telescope/telescope-fzf-native.nvim
                                :build :make
                                :cond (= (vim.fn.executable :make) 1)}]}
               ;;;;;;;;;;;;;;
               ; Treesitter ;
               ;;;;;;;;;;;;;;
               {1 :nvim-treesitter/nvim-treesitter
                :dependencies [:nvim-treesitter/nvim-treesitter-textobjects]
                :build ":TSUpdate"}
               :nvim-treesitter/nvim-treesitter-context
               {1 :nvim-treesitter/playground :enabled false}
               ;;;;;;;;;
               ; Games ;
               ;;;;;;;;;
               :ThePrimeagen/vim-be-good
               :Eandrju/cellular-automaton.nvim
               :wakatime/vim-wakatime
               ;;;;;;;;;;;;;;;;
               ; Colorschemes ;
               ;;;;;;;;;;;;;;;;
               :owickstrom/vim-colors-paramount
               {1 "https://git.earth2077.fr/leana/curry.nvim" :branch :lua}
               ;;;;;;;;;;;;;;
               ; Completion ;
               ;;;;;;;;;;;;;;
               {1 :hrsh7th/nvim-cmp
                :dependencies [:L3MON4D3/LuaSnip
                               :saadparwaiz1/cmp_luasnip
                               :hrsh7th/cmp-nvim-lsp
                               :rafamadriz/friendly-snippets
                               :hrsh7th/cmp-buffer
                               :f3fora/cmp-spell
                               :mrcjkb/haskell-snippets.nvim]}]
      opts {:performance {:rtp {:reset false}}}]
  (require-then! :lazy #($.setup plugins opts)))
