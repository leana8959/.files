local map = vim.keymap.set

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

map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>pe', vim.diagnostic.goto_prev)
map('n', '<leader>ne', vim.diagnostic.goto_next)

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*`
    local ts = require "telescope.builtin"
    local opts = { buffer = bufnr }

    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gtd', vim.lsp.buf.type_definition, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'gu', ts.lsp_references, opts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    map('n', '<leader>cl', vim.lsp.codelens.run, opts)
    map('n', '<leader>r', vim.lsp.buf.rename, opts)
    map('n', '<leader>f',
        function() vim.lsp.buf.format { async = true } end,
        opts
    )
end

-- Gutter symbols setup
vim.fn.sign_define("DiagnosticSignError", { text = 'E', texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = 'W', texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = 'H', texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = '·', texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })


-- Border setup
local border = {
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSPs / DAPs
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
    "Vec", "VecDeque", "array", "stack", "queue", "deque", "string", "cursor",
    "matched", "HashMap", "HashSet", "dédupliquer",
    -- Rapport BIO
    "dédupliquer", "read", "reads", "contig", "Debruijn", "mer",
}
-- FIXME: this thing fails to run in French when babel latex english is present
require "lspconfig".ltex.setup {
    on_attach = on_attach,
    settings = {
        ltex = {
            language = "auto",
            additionalRules = { motherTongue = "en-US" },
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
local config = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "/opt/homebrew/bin/jdtls" },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
local jdtls_group = vim.api.nvim_create_augroup("jdtls", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java" },
    callback = function()
        require('jdtls').start_or_attach(config)
    end,
    group = jdtls_group
})

-- Scala
local metals = require "metals"
local metals_config = metals.bare_config()
metals_config.capabilities = capabilities

require "dap".configurations.scala = {
    {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = { runType = "runOrTestFile", },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = { runType = "testTarget", },
    },
}

metals_config.on_attach = function(client, bufnr)
    metals.setup_dap()

    map("n", "<leader>ws", metals.hover_worksheet)

    map("n", "<leader>dc", require "dap".continue)
    map("n", "<leader>dr", require("dap").repl.toggle)
    map("n", "<leader>dK", require("dap.ui.widgets").hover)
    map("n", "<leader>dt", require("dap").toggle_breakpoint)
    map("n", "<leader>dso", require("dap").step_over)
    map("n", "<leader>dsi", require("dap").step_into)
    map("n", "<leader>dl", require("dap").run_last)

    on_attach(client, bufnr)
end
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
        require "metals".initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group
})

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
            local opts = { buffer = bufnr }

            map('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
            map('n', '<leader>he', ht.lsp.buf_eval_all, opts)
            map('n', '<leader>hr', ht.repl.toggle, opts)

            vim.cmd("setlocal shiftwidth=2")
            on_attach(client, bufnr)
        end,
        default_settings = {
            haskell = {
                formattingProvider = "fourmolu",
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

-- TypeScript
require "lspconfig".tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- -- Typst
-- require "lspconfig".typst_lsp.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--         exportPdf = "onType"
--     }
-- }

vim.filetype.add({ extension = { typ = "typst" } })
