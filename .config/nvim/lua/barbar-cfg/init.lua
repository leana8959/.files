vim.g.bufferline = {
	animation = true,
	tabpages = true,
	clickable = true,
	icon_pinned = '',
}

-- Move to previous/next
vim.keymap.set('n', 'gT', vim.cmd.BufferPrevious, { noremap = true, silent = true, desc = "Last tab" })
vim.keymap.set('n', 'gt', vim.cmd.BufferNext, { noremap = true, silent = true, desc = "Next tab" })
vim.keymap.set('n', '<A-{>', vim.cmd.BufferPrevious, { noremap = true, silent = true, desc = "Last tab" })
vim.keymap.set('n', '<A-}>', vim.cmd.BufferNext, { noremap = true, silent = true, desc = "Last tab" })

-- Re-order to previous/next
vim.keymap.set('n', '<C-{>', vim.cmd.BufferMovePrevious,
	{ noremap = true, silent = true, desc = "Move tab to the left" })
vim.keymap.set('n', '<C-}>', vim.cmd.BufferMoveNext,
	{ noremap = true, silent = true, desc = "Move tab to the right" })

-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', function() vim.cmd.BufferGoto(1) end, { noremap = true, silent = true, desc = "Goto tab 1" })
vim.keymap.set('n', '<A-2>', function() vim.cmd.BufferGoto(2) end, { noremap = true, silent = true, desc = "Goto tab 2" })
vim.keymap.set('n', '<A-3>', function() vim.cmd.BufferGoto(3) end, { noremap = true, silent = true, desc = "Goto tab 3" })
vim.keymap.set('n', '<A-4>', function() vim.cmd.BufferGoto(4) end, { noremap = true, silent = true, desc = "Goto tab 4" })
vim.keymap.set('n', '<A-5>', function() vim.cmd.BufferGoto(5) end, { noremap = true, silent = true, desc = "Goto tab 5" })
vim.keymap.set('n', '<A-6>', function() vim.cmd.BufferGoto(6) end, { noremap = true, silent = true, desc = "Goto tab 6" })
vim.keymap.set('n', '<A-7>', function() vim.cmd.BufferGoto(7) end, { noremap = true, silent = true, desc = "Goto tab 7" })
vim.keymap.set('n', '<A-8>', function() vim.cmd.BufferGoto(8) end, { noremap = true, silent = true, desc = "Goto tab 8" })
vim.keymap.set('n', '<A-9>', function() vim.cmd.BufferGoto(9) end, { noremap = true, silent = true, desc = "Goto tab 9" })
vim.keymap.set('n', '<A-0>', vim.cmd.BufferLast, { noremap = true, silent = true, desc = "Goto last tab" })

-- Pin/unpin buffer
vim.keymap.set('n', '<A-p>', vim.cmd.BufferPin, { noremap = true, silent = true, desc = "Pin tab" })

-- Close buffer
vim.keymap.set('n', '<A-c>', vim.cmd.BufferClose, { noremap = true, silent = true, desc = "Close tab" })
