require('nvim-treesitter.configs').setup {
	indent = { enable = true },
	ensure_installed = {
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"json",
		"yaml",
		"python",
		"bash",
		"lua",
		"c",
		"cpp",
		"php",
		"vim",
		"vue",
	},
	highlight = {
		enable = true,
	},

}
