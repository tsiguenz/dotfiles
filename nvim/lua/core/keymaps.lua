vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<C-W>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>j", "<C-W>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>k", "<C-W>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>l", "<C-W>l", { noremap = true })

-- Set tab to accept copilot suggestion
vim.keymap.set("i", "<Tab>", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").accept()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
	end
end, {
	silent = true,
})
