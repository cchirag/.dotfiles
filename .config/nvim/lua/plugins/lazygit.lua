return {
	'kdheepak/lazygit.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	cmd = { 'LazyGit' },
	keys = {
		{ '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open LazyGit' },
	},
	init = function()
		vim.g.lazygit_floating_window_winblend = 10
		vim.g.lazygit_floating_window_scaling_factor = 0.9
		vim.g.lazygit_use_neovim_remote = true
	end,
}
