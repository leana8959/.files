local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
local npairs = require("nvim-autopairs")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

npairs.setup {
    disable_filetype = { "fennel", "clojure", "lisp", "racket", "scheme" },
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

for _, punct in pairs { ",", ";" } do
    require("nvim-autopairs").add_rules {
        require("nvim-autopairs.rule")("", punct)
            :with_move(function(opts) return opts.char == punct end)
            :with_pair(function() return false end)
            :with_del(function() return false end)
            :with_cr(function() return false end)
            :use_key(punct),
    }
end

local function pair_with_insertion(a1, ins, a2, lang)
    npairs.add_rule(
        Rule(ins, ins, lang)
            :with_pair(function(opts) return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
            :with_move(cond.none())
            :with_cr(cond.none())
            :with_del(function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
            end)
    )
end

pair_with_insertion("(", "*", ")", { "ocaml", "why3", "skel" })
pair_with_insertion("(*", " ", "*)", { "ocaml", "why3", "skel" })
pair_with_insertion("[", " ", "]", { "typst", "python", "haskell" })
pair_with_insertion("{", " ", "}", nil)

for _, symb in ipairs { "$", "```", "_", "*" } do
    npairs.add_rule(
        Rule(symb, symb, "typst")
            :with_pair(cond.not_before_text(symb))
            :with_pair(cond.not_after_regex("%a"))
            :with_pair(cond.not_before_regex("%a"))
            :with_move(cond.done)
    )
end
