-- Telescope Setup
local builtin = require('telescope.builtin')
-- Replace your current mapping with this:
vim.keymap.set('n', '<leader>ff', function()
	builtin.find_files({
		hidden = true,
		no_ignore = true,
		file_ignore_patterns = { "%.git/", "node_modules/" }
	})
end, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Terminal Configurations
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})

-- Undo Tree
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)

-- Oil
vim.keymap.set('n', '_', '<CMD>Oil<CR>')

-- Marks
vim.keymap.set('n', '<leader>mm', ':marks<CR>')

-- Hard Mode
local hardmode = true
if hardmode then
	-- Show an error message if a disabled key is pressed
	local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

	-- Disable arrow keys in insert mode with a styled message
	vim.api.nvim_set_keymap('i', '<Up>', '<C-o>' .. msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('i', '<Down>', '<C-o>' .. msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('i', '<Left>', '<C-o>' .. msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('i', '<Right>', '<C-o>' .. msg, { noremap = true, silent = false })

	-- Disable arrow keys in normal mode with a styled message
	vim.api.nvim_set_keymap('n', '<Up>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<Down>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<Left>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<Right>', msg, { noremap = true, silent = false })
	vim.api.nvim_set_keymap('n', '<BS>', msg, { noremap = true, silent = false })
end


local Hydra = require('hydra')

-- Window Management Hydra
Hydra({
	name = 'Window Management',
	mode = 'n',
	body = '<leader>w', -- prefix key for window management
	heads = {
		{ 'h',     '<C-w>h', { desc = 'Move left' } },
		{ 'j',     '<C-w>j', { desc = 'Move down', } },
		{ 'k',     '<C-w>k', { desc = 'Move up', } },
		{ 'l',     '<C-w>l', { desc = 'Move right', } },
		{ 's',     '<C-w>s', { desc = 'Split horizontally', } },
		{ 'v',     '<C-w>v', { desc = 'Split vertically', } },
		{ 'q',     '<C-w>q', { desc = 'Close window', } },
		{ 'x',     '<C-w>x', { desc = 'Swap windows', } },
		{ '<Esc>', nil,      { exit = true, desc = 'Quit Hydra' } },
	},
})
