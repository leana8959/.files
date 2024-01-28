(macro r [name]
  `(require (.. :plugins._ ,name)))

(r :lazy)

(r :autopairs)
(r :cmp)
(r :colorizer)
(r :gitsigns)
(r :harpoon)
(r :lsp)
(r :lualine)
(r :no-neck-pain)
(r :oil)
(r :telescope)
(r :todo-comments)
(r :treesitter)
