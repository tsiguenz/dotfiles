source ~/.vimrc

call plug#begin('~/.config/nvim/plugged')
" linter and parser
Plug 'dense-analysis/ale'
" color scheme
Plug 'morhetz/gruvbox'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
" highlight colors
Plug 'gko/vim-coloresque'
Plug 'github/copilot.vim'
call plug#end()

" ======= override .vimrc for web development
set tabstop=2
set shiftwidth=2
set expandtab

syntax enable
colors gruvbox

let g:ale_fix_on_save = 1

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'tsx': ['prettier'],
\   'json': ['prettier'],
\   'yaml': ['prettier'],
\   'bash': ['shfmt'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format']
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'tsx': ['eslint'],
\   'json': ['jsonlint'],
\   'yaml': ['yamllint'],
\   'bash': ['shellcheck'],
\   'c': ['clang'],
\   'cpp': ['clang']
\}

let g:ale_lint_delay = 0

let g:ale_completion_enabled = 1

lua << EOF
require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

require('nvim-treesitter.configs').setup {
  ensure_installed =  { "javascript", "typescript", "tsx", "html", "css", "json", "yaml", "graphql", "python", "bash", "lua", "c", "cpp", "go", "java", "php", "ruby", "swift", "toml", "vim", "vue", "yaml" }
}
EOF
