require "obsidian".setup {
	disable_frontmatter = true,
	dir = "~/Documents/Diary/",
	daily_notes = {
		date_format = "%s",
	},
	completion = {
		nvim_cmp = true,
	},
}
