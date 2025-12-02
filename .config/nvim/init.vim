call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "javascript", "cpp", "java", "c", "kotlin", "python" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },
}
EOF
