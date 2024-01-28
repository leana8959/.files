(import-macros {: exec! : map! : setlocal!} :hibiscus.vim)
(import-macros {: fst! : req-do! : for!} :macros)
(local map vim.keymap.set)

(local servers
       {:bashls {}
        :clangd {}
        :cssls {}
        :html {}
        :jsonls {}
        :lemminx {}
        :marksman {}
        :ocamllsp {}
        :phpactor {}
        :pylsp {}
        :pyright {}
        :taplo {}
        :texlab {}
        :tsserver {}
        :vimls {}
        :lua_ls {:settings {:Lua {:format {:defaultConfig {:call_arg_parentheses :remove
                                                           :indent_style :space
                                                           :quote_style :double
                                                           :trailing_table_separator :smart}}}}}
        :nil_ls {:on_attach #(map! [n :buffer] :<leader>f
                                   #(exec! [w] [silent exec "!alejandra %"] [e]))}
        :typst_lsp {:settings {:exportPdf :never
                               :root_dir (or (vim.fs.dirname (fst! (vim.fs.find [:.git]
                                                                                {:upward true})))
                                             (vim.loop.cwd))}}})

(fn on_attach [client bufno]
  (vim.api.nvim_buf_set_option bufno :omnifunc "v:lua.vim.lsp.omnifunc")
  (local ts (require :telescope.builtin))
  (map! [n :buffer] :K vim.lsp.buf.hover)
  (map! [n :buffer] :<C-k> vim.lsp.buf.signature_help)
  (map! [n :buffer] :gD vim.lsp.buf.declaration)
  (map! [n :buffer] :gd vim.lsp.buf.definition)
  (map! [n :buffer] :gtd vim.lsp.buf.type_definition)
  (map! [n :buffer] :gi vim.lsp.buf.implementation)
  (map! [n :buffer] :gu ts.lsp_references)
  (map! [n :buffer] :<leader>ca vim.lsp.buf.code_action)
  (map! [n :buffer] :<leader>cl vim.lsp.codelens.run)
  (map! [n :buffer] :<leader>r vim.lsp.buf.rename)
  (map! [n :buffer] :<leader>f #(vim.lsp.buf.format {:async true}))
  (when client.server_capabilities.documentSymbolProvider
    (req-do! :nvim-navic #($.attach client bufno))))

(local border [[" " :FloatBorder]
               [" " :FloatBorder]
               [" " :FloatBorder]
               [" " :FloatBorder]
               [" " :FloatBorder]
               [" " :FloatBorder]
               [" " :FloatBorder]
               [" " :FloatBorder]])

(let [orig vim.lsp.util.open_floating_preview]
  (fn vim.lsp.util.open_floating_preview [contents syntax opts ...]
    (set-forcibly! opts (or opts {}))
    (set opts.border border)
    (orig contents syntax opts ...)))

(let [config {:bind true : border :doc_lines 7 :hint_enable false}]
  (req-do! :lsp_signature #($.setup config)))

(vim.diagnostic.config {:severity_sort true :virtual_text false})
(vim.lsp.set_log_level :off)
(vim.fn.sign_define :DiagnosticSignError
                    {:numhl :DiagnosticSignError
                     :text :E
                     :texthl :DiagnosticSignError})

(vim.fn.sign_define :DiagnosticSignWarn
                    {:numhl :DiagnosticSignWarn
                     :text :W
                     :texthl :DiagnosticSignWarn})

(vim.fn.sign_define :DiagnosticSignHint
                    {:numhl :DiagnosticSignHint
                     :text :H
                     :texthl :DiagnosticSignHint})

(vim.fn.sign_define :DiagnosticSignInfo
                    {:numhl :DiagnosticSignInfo
                     :text "·"
                     :texthl :DiagnosticSignInfo})

(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities
     (req-do! :cmp_nvim_lsp #($.default_capabilities capabilities)))

(req-do! :fidget #($.setup {:text {:spinner :dots}}))
(req-do! :neodev #($.setup))

;;;;;;;;;;;
; Folding ;
;;;;;;;;;;;
(set capabilities.textDocument.foldingRange
     {:dynamicRegistration false :lineFoldingOnly true})

(let [handler (fn [virt-text lnum end-lnum width truncate]
                (let [new-virt-text {}]
                  (var suffix (: " 󰁂 %d " :format (- end-lnum lnum)))
                  (local suf-width (vim.fn.strdisplaywidth suffix))
                  (local target-width (- width suf-width))
                  (var cur-width 0)
                  (each [_ chunk (ipairs virt-text)]
                    (var chunk-text (fst! chunk))
                    (var chunk-width (vim.fn.strdisplaywidth chunk-text))
                    (if (> target-width (+ cur-width chunk-width))
                        (table.insert new-virt-text chunk)
                        (do
                          (set chunk-text
                               (truncate chunk-text (- target-width cur-width)))
                          (local hl-group (. chunk 2))
                          (table.insert new-virt-text [chunk-text hl-group])
                          (set chunk-width (vim.fn.strdisplaywidth chunk-text))
                          (when (< (+ cur-width chunk-width) target-width)
                            (set suffix
                                 (.. suffix
                                     (: " " :rep
                                        (- (- target-width cur-width)
                                           chunk-width)))))
                          (lua :break)))
                    (set cur-width (+ cur-width chunk-width)))
                  (table.insert new-virt-text [suffix :MoreMsg])
                  new-virt-text))]
  (req-do! :ufo #($.setup {:fold_virt_text_handler handler})))

(for! (fn [k v]
        (let [config {: capabilities
                      :on_attach (fn [client bufno]
                                   (on_attach client bufno)
                                   (v.on_attach client bufno))
                      :settings v.settings}]
          ((-> (require :lspconfig)
               (. k)
               (. :setup)) config))) servers)

(let [config {: capabilities
              :cmd [:jdt-language-server
                    :-data
                    (.. (vim.fn.expand "~/.cache/jdtls")
                        (vim.fn.expand "%:p:h"))]
              : on_attach
              :root_dir (vim.fs.dirname (fst! (vim.fs.find [:gradlew
                                                            :.git
                                                            :mvnw]
                                                           {:upward true})))}]
  (local jdtls-group (vim.api.nvim_create_augroup :jdtls {:clear true}))
  (vim.api.nvim_create_autocmd :FileType
                               {:callback #(req-do! :jdtls
                                                    #($.start_or_attach config))
                                :group jdtls-group
                                :pattern [:java]}))

(let [metals (require :metals)
      metals-config (metals.bare_config)
      dap (require :dap)
      widgets (require :dap.ui.widgets)]
  (set metals-config.capabilities capabilities)
  (set metals-config.settings.useGlobalExecutable true)
  (tset dap.configurations :scala
        [{:metals {:runType :runOrTestFile}
          :name :RunOrTest
          :request :launch
          :type :scala}
         {:metals {:runType :testTarget}
          :name "Test Target"
          :request :launch
          :type :scala}])
  (set metals-config.on_attach
       (fn [client bufnr]
         (metals.setup_dap)
         (map :n :<leader>ws metals.hover_worksheet)
         (map :n :<leader>dc dap.continue)
         (map :n :<leader>dr dap.repl.toggle)
         (map :n :<leader>dK widgets.hover)
         (map :n :<leader>dt dap.toggle_breakpoint)
         (map :n :<leader>dso dap.step_over)
         (map :n :<leader>dsi dap.step_into)
         (map :n :<leader>dl dap.run_last)
         (on_attach client bufnr)))
  (local nvim-metals-group
         (vim.api.nvim_create_augroup :nvim-metals {:clear true}))
  (vim.api.nvim_create_autocmd :FileType
                               {:callback #(req-do! :metals
                                                    #($.initialize_or_attach metals-config))
                                :group nvim-metals-group
                                :pattern [:scala :sbt]}))

(set vim.g.haskell_tools
     {:hls {:default_settings {:haskell {:cabalFormattingProvider :cabal-fmt
                                         :formattingProvider :stylish-haskell}}
            :on_attach (fn [client bufnr]
                         (local ht (require :haskell-tools))
                         (local opts {:buffer bufnr})
                         (map :n :<leader>hhe ht.lsp.buf_eval_all opts)
                         (map :n :<leader>hhs ht.hoogle.hoogle_signature opts)
                         (map :n :<leader>hhr ht.repl.toggle opts)
                         (set vim.opt_local.shiftwidth 2)
                         (on_attach client bufnr))}
      :tools {:hover {: border :stylize_markdown true}
              :log {:level vim.log.levels.OFF}}})

(let [config {:server {: on_attach}}]
  (req-do! :rust-tools #($.setup config)))
