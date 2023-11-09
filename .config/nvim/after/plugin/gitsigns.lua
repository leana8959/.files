require "gitsigns".setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "hj", function()
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
        end, { expr = true })

        map("n", "hk", function()
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "hs",
            function()
                vim.cmd.normal "mZ"
                gs.stage_hunk()
                gs.next_hunk()
            end
        )
        map("n", "hu",
            function()
                vim.cmd.normal "`Z"
                gs.undo_stage_hunk()
            end
        )
        map("n", "hr", gs.reset_hunk)

        map("v", "hs", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end)
        map("v", "hr", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end)

        map("n", "hS", gs.stage_buffer)
        map("n", "hR", gs.reset_buffer)

        map("n", "hp", gs.preview_hunk)
        map("n", "hb", function() gs.blame_line { full = true } end)
        map("n", "tb", gs.toggle_current_line_blame)

        map("n", "hd", gs.diffthis)
        map("n", "hD", function() gs.diffthis "~" end)

        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end
}
