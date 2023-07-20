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

require("null_ls").setup({
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

require("mason_null_ls").setup({
	ensure_installed = {
		"markdownlint",
		"shellcheck",
		"yamllint",
		"dockerlint",
		"jsonlint",
		"clang-format",
		"stylua",
		"cpplint",
		"flake8",
	},
	automatic_installation = true,
	handlers = {},
})
