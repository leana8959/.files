require("fidget").setup({
    text = {
        spinner = "dots",
        -- done = "[Ok]",
    },
})

require "mason".setup()
require "mason-lspconfig".setup {
    ensure_installed = {},
    automatic_installation = false
}
require "neodev".setup()

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "open diagnostic in a float window" })
vim.keymap.set('n', '<leader>pe', vim.diagnostic.goto_prev, { desc = "goto [P]revious [E]rror" })
vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next, { desc = "goto [N]ext [E]rror" })

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*`
    local ts = require "telescope.builtin"

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover", buffer = bufnr })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP Signature help", buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufnr })
    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, { desc = "LSP Type definitions", buffer = bufnr })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
    vim.keymap.set('n', 'gu', ts.lsp_references, { desc = "LSP Usages (Telescope)", buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { desc = "Code lens", buffer = bufnr })
    vim.keymap.set('n', '<leader>f',
        function() vim.lsp.buf.format { async = true } end,
        { desc = "LSP format", buffer = bufnr }
    )
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = "LSP Rename symbol", buffer = bufnr })
end

-- Gutter symbols setup
vim.fn.sign_define("DiagnosticSignError", { text = 'E', texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = 'W', texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = 'H', texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = '·', texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })


-- Border setup
local border = {
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require "cmp_nvim_lsp".default_capabilities(capabilities)
-- Spell check
local common_dictionary = {
    -- Me stuff
    "Yu", "Hui", "Léana", "Chiang", "CHIANG",
    "ISTIC",
    -- LaTeX
    "compat",
    -- Tech terms
    "Vec", "VecDeque", "array", "stack", "queue", "deque", "string", "cursor", "matched",
    "HashMap", "HashSet", "dédupliquer",
    -- Rapport BIO
    "dédupliquer", "read", "reads", "contig", "Debruijn", "mer",
}
-- FIXME: this thing fails to run in French when babel latex english is present
require "lspconfig".ltex.setup {
    on_attach = on_attach,
    settings = {
        ltex = {
            language = "auto",
            additionalRules = {
                motherTongue = "en-US"
            },
            trace = { server = "verbose" },
            dictionary = {
                ["en-US"] = common_dictionary,
                ["fr"] = common_dictionary
            },
        },
    },
    flags = { debounce_text_changes = 10000 },
    capabilities = capabilities,
}
-- JSON
require "lspconfig".jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- XML
require "lspconfig".lemminx.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- CSS
require "lspconfig".cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Lua
require "lspconfig".lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        lua = {
            format = {
                enable = true,
                defaultConfig = {
                    -- tab
                    indent_style                       = "tab",
                    tab_width                          = "2",
                    -- alignment
                    align_call_args                    = "true",
                    align_function_params              = "true",
                    align_continuous_assign_statement  = "true",
                    align_continuous_rect_table_field  = "true",
                    align_continuous_line_space        = "2",
                    align_if_branch                    = "true",
                    align_array_table                  = "true",
                    align_continuous_similar_call_args = "true",
                    align_continuous_inline_comment    = "true",
                    align_chain_expr                   = "only_call_stmt",
                }
            }
        }
    },
}
-- Go
require "lspconfig".gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Rust
require "rust-tools".setup {
    server = {
        on_attach = on_attach,
        cmd = { "rustup", "run", "stable", "rust-analyzer" }
    }
}
-- tex
require "lspconfig".texlab.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Markdown
require "lspconfig".marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- TOML
require "lspconfig".taplo.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Java
require "lspconfig".jdtls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Scala
require "lspconfig".metals.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Haskell
vim.g.haskell_tools = {
    tools = {
        hover = {
            border = border,
            stylize_markdown = true,
        }
    },
    hls = {
        on_attach = function(client, bufnr)
            local ht = require("haskell-tools")

            vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature,
                { desc = "Hoogle signature", buffer = bufnr })
            vim.keymap.set('n', '<space>he', ht.lsp.buf_eval_all, { desc = "Evaluate all", buffer = bufnr })
            vim.keymap.set('n', '<space>hr', ht.repl.toggle, { desc = "Toggle repl" })

            vim.cmd("setlocal shiftwidth=2")
            on_attach(client, bufnr)
        end,
        default_settings = {
            haskell = {
                formattingProvider = "fourmolu"
            }
        }
    }
}

-- Python
require "lspconfig".pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- C
require "lspconfig".clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- HTML
require "lspconfig".html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "xhtml" },
}
-- Bash
require "lspconfig".bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "sh" },
}
