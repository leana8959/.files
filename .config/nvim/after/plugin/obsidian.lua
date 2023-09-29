require "obsidian".setup {
    disable_frontmatter = true,
    dir = "~/repos/leana/diary/",
    daily_notes = {
        date_format = "%s",
    },
    completion = {
        nvim_cmp = true,
    },
}
