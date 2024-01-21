local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- LSP formatting filter
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- Ignore formatting from these LSPs
			local lsp_formatting_denylist = {
				--	lua_ls = true,
			}
			if lsp_formatting_denylist[client.name] then
				return false
			end
			return true
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	-- set auto format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

-- list of linters and formaters
mason_null_ls.setup({
	ensure_installed = {
		"markdownlint",
		"shellcheck",
		"shfmt",
		"yamllint",
		"jsonlint",
		"clang-format",
		"stylua",
		"cpplint",
		"flake8",
		"autopep8",
		"hadolint",
		"google-java-format",
		"goimports",
		"gotests",
	},
	automatic_installation = true,
	handlers = {},
})
