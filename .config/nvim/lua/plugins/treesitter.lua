return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"html", "css", "javascript", "typescript",
				"tsx", "go", "rust", "markdown",
				"yaml", "python", "graphql"
			},
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true }, -- Enable auto-closing tags (requires 'windwp/nvim-ts-autotag')
		})
	end,
}
