local set = vim.opt

set.listchars = {
	space = ".",
	tab = ">-",
	eol = "↴",
}
set.mouse = "c"

set.tabstop = 2 -- size of a hard tabstop
set.shiftwidth = 2 -- size of an indentation
set.expandtab = false -- always uses tab instead of space characters
set.softtabstop = 2 -- number of spaces a <Tab> counts for.

set.number = true
set.relativenumber = true
set.colorcolumn = "80"

set.splitbelow = true
set.splitright = true

set.hlsearch = true
set.wildmenu = true
set.wildignorecase = true

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
