(macro require-plugins [ns]
  `(each [_# n# (ipairs ,ns)]
     (require (.. :plugins._ n#))))

(require-plugins [:lazy
                  :autopairs
                  :cmp
                  :colorizer
                  :gitsigns
                  :harpoon
                  :lsp
                  :lualine
                  :no-neck-pain
                  :oil
                  :telescope
                  :todo-comments
                  :treesitter])
