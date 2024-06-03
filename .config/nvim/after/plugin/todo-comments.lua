require("todo-comments").setup {
    keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = "!", color = "warning", alt = { "DEBUG" } },
        WARN = { icon = "!", color = "warning", alt = { "WARNING", "XXX" } },
        NOTE = { icon = "·", color = "hint", alt = { "INFO" } },
        TEST = { icon = "T", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        UNIMPLEMENTED = { icon = "@", color = "hint" },
        Q = { icon = "?", color = "warning" },
        R = { icon = "=", color = "hint" },
    },
}
