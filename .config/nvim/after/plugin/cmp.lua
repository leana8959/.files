local cmp = require "cmp"
local ls = require "luasnip"

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require "luasnip.extras".lambda
local rep = require "luasnip.extras".rep
local p = require "luasnip.extras".partial
local m = require "luasnip.extras".match
local n = require "luasnip.extras".nonempty
local dl = require "luasnip.extras".dynamic_lambda
local fmt = require "luasnip.extras.fmt".fmt
local fmta = require "luasnip.extras.fmt".fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.conditions"
local conds_expand = require "luasnip.extras.conditions.expand"

require "luasnip.loaders.from_vscode".lazy_load { paths = { "./snippets" } }

ls.setup {
    update_events = { "TextChanged", "TextChangedI" },
    -- region_check_events = "InsertEnter",
    -- delete_check_events = "InsertLeave",
}
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

--------------
-- Snippets --
--------------
local function show_date()
    return os.date "(year: %Y, month: %m, day: %d, hour: %H, minute: %M, second: %S)"
end
ls.add_snippets("typst", {
    s("entry", {
        t "#entry(",
        f(show_date),
        t { ")[", "" },
        i(0),
        t { "", "]" },
    }),
})

local function get_cms()
    assert(vim.bo.commentstring ~= "", "comment string is not set")
    local left  = vim.bo.commentstring:gsub("%s*%%s.*", "")
    local right = vim.bo.commentstring:gsub(".*%%s%s*", "")
    if right == "" then right = left end
    return {
        left  = left,
        right = right,
    }
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
ls.add_snippets("all", {
    s("banner", {
        f(horizon, { 1 }),
        t { "", "" },
        f(left), i(1), f(right),
        t { "", "" },
        f(horizon, { 1 }),
    }),
})

local function fold_start()
    local cms = get_cms()
    return cms.left .. " {{{" .. cms.right
end
local function fold_end()
    local cms = get_cms()
    return cms.left .. " }}}" .. cms.right
end
ls.add_snippets("all", {
    s("fold", {
        f(fold_start),
        t { "", "" },
        i(1),
        t { "", "" },
        f(fold_end),
    }),
})

---------------
-- Setup CMP --
---------------
cmp.setup {
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif ls.expand_or_locally_jumpable() then
                ls.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ls.jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback)
            if ls.choice_active() then
                ls.change_choice(1)
            elseif cmp.visible() then
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                } ()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-CR>"] = cmp.mapping(function(fallback)
            if ls.choice_active() then
                ls.change_choice(-1)
            elseif cmp.visible() then
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                } ()
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer",  keyword_length = 4 },
    },
}
