(import-macros {: set!} :hibiscus.vim)

(let [opts {;; search
            :hlsearch false
            :incsearch true
            :ignorecase true
            :smartcase true
            ;; line number
            :number true
            :relativenumber true
            :signcolumn :yes
            :cursorline true
            ;; spacing
            :tabstop 4
            :expandtab true
            :shiftwidth 4
            :autoindent true
            :smartindent true
            ;; line breaking
            :wrap false
            :linebreak true
            :breakindent true
            ;; no ~swp nonsense
            :filetype :on
            :swapfile false
            :backup false
            :undofile true
            ;; terminal
            :termguicolors true
            :mouse :a
            :scrolloff 3
            :colorcolumn :80
            ;; folding
            :foldlevel 99
            :foldlevelstart 99
            :foldenable true
            ;; winbar
            :winbar "%{%v:lua.require'opts.winbar'.eval()%}"
            :showmode false
            ;; listing
            :listchars {:tab "│ " :trail "␣"}
            :list true}]
  (each [k v (pairs opts)]
    (set! k v)))
