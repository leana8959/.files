vim.g.bufferline = {
	animation = true,
	tabpages = true,
	clickable = true,
	icon_pinned = '',
}

-- Move to previous/next
vim.keymap.set('n', 'gT', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "Last tab" })
vim.keymap.set('n', 'gt', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "Next tab" })
vim.keymap.set('n', '<A-{>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "Last tab" })
vim.keymap.set('n', '<A-}>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "Last tab" })

-- Re-order to previous/next
vim.keymap.set('n', '<C-{>', '<Cmd>BufferMovePrevious<CR>',
	{ noremap = true, silent = true, desc = "Move tab to the left" })
vim.keymap.set('n', '<C-}>', '<Cmd>BufferMoveNext<CR>',
	{ noremap = true, silent = true, desc = "Move tab to the right" })

-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = "Goto tab 1" })
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = "Goto tab 2" })
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = "Goto tab 3" })
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = "Goto tab 4" })
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = "Goto tab 5" })
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = "Goto tab 6" })
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = "Goto tab 7" })
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = "Goto tab 8" })
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = "Goto tab 9" })
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true, desc = "Goto last tab" })

-- Pin/unpin buffer
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true, desc = "Pin tab" })

-- Close buffer
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = "Close tab" })
