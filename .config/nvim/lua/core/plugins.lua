local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- Theme
	use("ellisonleao/gruvbox.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	-- Code parser
	use("nvim-treesitter/nvim-treesitter")
	-- Powerline for nvim
	use("nvim-lualine/lualine.nvim")
	-- File explorer and so forth
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- LSP from https://miikanissi.com/blog/how-to-setup-nvim-lsp-for-code-analysis-autocompletion-and-linting/
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	})
	-- lint and format
	use("nvimtools/none-ls.nvim")
	use("jay-babu/mason-null-ls.nvim")
	-- Autocompletion plugin
	-- 	use({
	-- 		"hrsh7th/nvim-cmp",
	-- 		requires = {
	-- 			-- Adds LSP completion capabilities
	-- 			"hrsh7th/cmp-nvim-lsp",
	-- 		},
	-- 	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
