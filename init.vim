source ~/.vimrc

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'dense-analysis/ale'
Plug 'github/copilot.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

" ======= override .vimrc for web development
set tabstop=2
set shiftwidth=2
set expandtab

" ======= coc settings
set updatetime=300
set shortmess+=c

" instead of having ~/.vim/coc-settings.json
let s:LSP_CONFIG = {
      \  'flow': {
      \    'command': exepath('flow'),
      \    'args': ['lsp'],
      \    'filetypes': ['javascript', 'javascriptreact'],
      \    'initializationOptions': {},
      \    'requireRootPattern': 1,
      \    'settings': {},
      \    'rootPatterns': ['.flowconfig']
      \  }
      \}

syntax enable
colors gruvbox

lua << EOF
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF

lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed =  { "javascript", "typescript", "tsx", "html", "css", "json", "yaml", "graphql", "python", "bash", "lua", "c", "cpp", "go", "java", "php", "ruby", "swift", "toml", "vim", "vue", "yaml" }
}
EOF
