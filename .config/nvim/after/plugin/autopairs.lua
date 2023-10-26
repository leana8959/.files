local Rule = require "nvim-autopairs.rule"
local cond = require "nvim-autopairs.conds"
local npairs = require "nvim-autopairs"

npairs.setup()

-- Intergration with `cmp`
local cmp = require "cmp"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-------------------
-- Tex and Typst --
-------------------
npairs.add_rules {
    Rule("$", "$", { "tex", "typst" })
        :with_move(cond.done()),

    Rule("_", "_", { "typst" })
        :with_move(cond.done()),
    Rule("*", "*", { "typst" })
        :with_move(cond.done()),

    Rule("```", "```", { "typst" })
        :with_pair(cond.not_before_text "```")
        :with_cr(cond.done),
}
