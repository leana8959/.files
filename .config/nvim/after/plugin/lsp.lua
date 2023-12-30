local map                             = vim.keymap.set
local usercmd                         = vim.api.nvim_create_user_command

local Map                             = require "utils".Map
local Foreach                         = require "utils".Foreach
local Filter                          = require "utils".Filter
local Concat                          = require "utils".Concat

----------------------
-- Language servers --
----------------------
local servers                         = {
    bashls    = {}, -- bash
    clangd    = {}, -- C/CPP
    cssls     = {}, -- CSS
    html      = {}, -- HTML
    jsonls    = {}, -- JSON
    lemminx   = {}, -- XML
    marksman  = {}, -- Markdown
    pyright   = {}, -- Python
    pylsp     = {},
    taplo     = {}, -- toml
    texlab    = {}, -- texlab
    tsserver  = {}, -- TypeScript
    vimls     = {}, -- vim

    typst_lsp = {   -- Typst
        settings = {
            exportPdf = "never",
        },
    },

    lua_ls    = { -- Lua
        settings = {
            Lua = {
                format = {
                    defaultConfig = {
                        -- Learn more:
                        -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config.md
                        indent_style             = "space",
                        quote_style              = "double",
                        call_arg_parentheses     = "remove",
                        trailing_table_separator = "smart",
                    },
                },
            },
        },
    },

    nil_ls    = { -- Nix
        masonExclude = true,
        on_attach    = function(_, bufno)
            vim.api.nvim_buf_set_option(bufno, "omnifunc", "v:lua.vim.lsp.omnifunc")
            map("n", "<leader>f",
                function()
                    vim.cmd ":w"
                    vim.cmd [[silent exec "!nixfmt %"]]
                    vim.cmd ":e"
                end,
                { buffer = bufno })
        end,
    },

    ocamllsp  = { -- OCaml
        masonExclude = true,
    },
}
------------------
-- Linters, etc --
------------------
-- NOTE: uses mason's package names
local tools                           = {
    "shellcheck", -- bash
}

-------------
-- Helpers --
-------------
local on_attach                       = function(client, bufno)
    vim.api.nvim_buf_set_option(bufno, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local ts = require "telescope.builtin"
    local opts = { buffer = bufno }

    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gtd", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gu", ts.lsp_references, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>cl", vim.lsp.codelens.run, opts)
    map("n", "<leader>r", vim.lsp.buf.rename, opts)
    map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)

    if client.server_capabilities.documentSymbolProvider then
        require "nvim-navic".attach(client, bufno)
    end
end

-- Helix style border
local border                          = {
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
    { " ", "FloatBorder" }, { " ", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Type signature
require "lsp_signature".setup {
    doc_lines   = 7,
    bind        = true,
    border      = border,
    hint_enable = false,
}

-- Diagnostic display configuration
vim.diagnostic.config { virtual_text = false, severity_sort = true }

-- Set log level
vim.lsp.set_log_level "off"

-- Gutter symbols setup
vim.fn.sign_define("DiagnosticSignError",
    { text = "E", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "·", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require "cmp_nvim_lsp".default_capabilities(capabilities)

----------
-- Init --
----------
require "fidget".setup { text = { spinner = "dots" } }
require "neodev".setup()

-- Folding
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly     = true,
}
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end
require "ufo".setup { fold_virt_text_handler = handler }

Foreach(servers,
    function(k, v)
        require "lspconfig"[k].setup {
            capabilities = capabilities,
            settings     = v.settings,
            on_attach    = function(client, bufno)
                on_attach(client, bufno)
                v.on_attach(client, bufno)
            end,
        }
    end)

------------------------
-- Standalone plugins --
------------------------
-- Java
local config = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        -- https://github.com/NixOS/nixpkgs/issues/232822#issuecomment-1564243667
        -- `-data` argument is necessary
        "jdt-language-server",
        "-data", vim.fn.expand "~/.cache/jdtls" .. vim.fn.expand "%:p:h",
    },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
local jdtls_group = vim.api.nvim_create_augroup("jdtls", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java" },
    callback = function()
        require "jdtls".start_or_attach(config)
    end,
    group = jdtls_group,
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
        metals = { runType = "runOrTestFile" },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = { runType = "testTarget" },
    },
}

metals_config.on_attach = function(client, bufnr)
    metals.setup_dap()

    map("n", "<leader>ws", metals.hover_worksheet)

    map("n", "<leader>dc", require "dap".continue)
    map("n", "<leader>dr", require "dap".repl.toggle)
    map("n", "<leader>dK", require "dap.ui.widgets".hover)
    map("n", "<leader>dt", require "dap".toggle_breakpoint)
    map("n", "<leader>dso", require "dap".step_over)
    map("n", "<leader>dsi", require "dap".step_into)
    map("n", "<leader>dl", require "dap".run_last)

    on_attach(client, bufnr)
end
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
        require "metals".initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

-- Haskell
vim.g.haskell_tools = {
    tools = {
        log = { level = vim.log.levels.OFF },
        hover = {
            border = border,
            stylize_markdown = true,
        },
    },
    hls = {
        on_attach = function(client, bufnr)
            local ht = require "haskell-tools"
            local opts = { buffer = bufnr }

            map("n", "<leader>hhe", ht.lsp.buf_eval_all, opts)
            map("n", "<leader>hhs", ht.hoogle.hoogle_signature, opts)
            map("n", "<leader>hhr", ht.repl.toggle, opts)

            vim.opt_local.shiftwidth = 2
            on_attach(client, bufnr)
        end,
        default_settings = {
            haskell = {
                -- formattingProvider      = "fourmolu",
                formattingProvider      = "stylish-haskell",
                cabalFormattingProvider = "cabal-fmt",
            },
        },
    },
}

-- Rust
require "rust-tools".setup {
    server = {
        on_attach = on_attach,
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
    },
}
