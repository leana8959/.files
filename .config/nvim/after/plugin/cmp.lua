local cmp = require("cmp")
local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local cr = function() return t { "", "" } end -- linebreak
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-----------------
-- Lazy loader --
-----------------
require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } }

----------
-- Init --
----------
ls.setup { update_events = { "TextChanged", "TextChangedI" } }

-----------
-- Typst --
-----------
local function show_date_typst_entry()
    return os.date("(year: %Y, month: %m, day: %d, hour: %H, minute: %M, second: %S)")
end
ls.add_snippets("typst", {
    s("entry", {
        t("#entry("),
        f(show_date_typst_entry),
        t { ")[", "" },
        i(0),
        t { "", "]" },
    }),
})

local function get_cms()
    assert(vim.bo.commentstring ~= "", "comment string is not set")
    local left = vim.bo.commentstring:gsub("%s*%%s.*", "")
    local right = vim.bo.commentstring:gsub(".*%%s%s*", "")
    if right == "" then right = left end
    return { left = left, right = right }
end
local function horizon(args)
    local cms = get_cms()
    local chr = cms.left:sub(-1)
    local len = vim.fn.strdisplaywidth(args[1][1])

    local acc = cms.left
    for _ = cms.left:len(), len + cms.right:len() + 1, 1 do
        acc = acc .. chr
    end
    acc = acc .. cms.right

    return acc
end
local function left()
    local cms = get_cms()
    return cms.left .. " "
end
local function right()
    local cms = get_cms()
    return " " .. cms.right
end

-- stylua: ignore start
ls.add_snippets("all", {
    s("banner", {
        f(horizon, { 1 }), cr(),
        f(left), i(1), f(right), cr(),
        f(horizon, { 1 }),
    }),
})
-- stylua: ignore end

------------
-- Ledger --
------------
local function show_date_ledger_entry() return os.date("%Y-%m-%d") end
-- shortcuts

-- stylua: ignore start
ls.add_snippets("ledger", {
    s("lessive", {
        f(show_date_ledger_entry), t(" "), t("Lave linge (CROUS)"), cr(),
        t("\texpenses                         3,00 EUR"), cr(),
        t("\tassets:compte_courant           -3,00 EUR"),
    }),
    s("sechoir", {
        f(show_date_ledger_entry), t(" "), t("Sèche linge (CROUS)"), cr(),
        t("\texpenses                         1,50 EUR"), cr(),
        t("\tassets:compte_courant           -1,50 EUR"),
    }),
    s("izly", {
        f(show_date_ledger_entry), t(" "), t("IZLY"), cr(),
        t("\texpenses                         3,30 EUR"), cr(),
        t("\tassets:izly                     -3,30 EUR"),
    }),
})
-- stylua: ignore end

-- generalized entry
-- stylua: ignore start
local id = function(args) return args[1][1] end
ls.add_snippets("ledger", {
    s("entry", {
        f(show_date_ledger_entry), t(" "), i(1), cr(),
        t("\texpenses:"), i(2), t("            "), i(3), t(" EUR"), cr(),
        t("\tassets:compte_courant           -"), f(id, { 3 }), t(" EUR"), cr(),
    }),
    s("date-entry", {
        i(1), t(" "), i(2), cr(),
        t("\texpenses:"), i(3), t("            "), i(4), t(" EUR"), cr(),
        t("\tassets:compte_courant           -"), f(id, { 4 }), t(" EUR"), cr(),
    }),
})
-- stylua: ignore end

-------------
-- Haskell --
-------------
local haskell_snippets = require("haskell-snippets").all
ls.add_snippets("haskell", haskell_snippets, { key = "haskell" })

---------------
-- Setup CMP --
---------------
local of_filetype = function(fts)
    local ft = vim.bo.filetype
    for _, v in ipairs(fts) do
        if v == ft then return true end
    end
    return false
end

cmp.setup {
    snippet = {
        expand = function(args) ls.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<Tab>"] = cmp.mapping(function(fallback) -- Next or jump
            if cmp.visible() then
                cmp.select_next_item()
            elseif ls.expand_or_locally_jumpable() then
                ls.expand_or_jump()
            elseif has_words_before() and (not of_filetype { "ledger" }) then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback) -- Previous
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ls.jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<A-Tab>"] = cmp.mapping(function(fallback) -- Force jump
            if ls.expand_or_locally_jumpable() then
                ls.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback) -- Confirm
            if cmp.visible() then
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-CR>"] = cmp.mapping(function(fallback) -- Confirm and replace
            if cmp.visible() then
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }()
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        {
            name = "buffer",
            keyword_length = 10,
            option = {
                enable_in_context = function() return of_filetype { "tex", "markdown", "typst" } end,
            },
        },
        {
            name = "spell",
            keyword_length = 10,
            option = {
                keep_all_entries = true,
                enable_in_context = function() return of_filetype { "tex", "markdown", "typst" } end,
            },
        },
    },
}
