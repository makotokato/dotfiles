call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'github/copilot.vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
call plug#end()

let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('~/vim-lsp.log')

if executable(expand('~/.mozbuild/clang-tools/clang-tidy/bin/clangd'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->[
	\     expand('~/.mozbuild/clang-tools/clang-tidy/bin/clangd'),
	\     '--compile-commands-dir=objdir'
	\ ]},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if executable(expand('~/.cargo/bin/rust-analyzer'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'Rust Language Server',
        \ 'cmd': {server_info->[
	\     expand('~/.cargo/bin/rust-analyzer')
	\]},
        \   'whitelist': ['rust'],
        \ })
endif

let g:copilot_filetypes = #{
  \   gitcommit: v:true,
  \   markdown: v:true,
  \   text: v:true,
  \   ddu-ff-filter: v:false,
  \ }

syntax on
set modeline
set spell
set mouse-=a
set ruler
hi clear SpellBad
hi SpellBad cterm=underline

augroup vimrc
  autocmd!
  autocmd BufRead,BufNewFile *.jsm    set filetype=javascript
  autocmd BufRead,BufNewFile *.sjs    set filetype=javascript
  autocmd BufRead,BufNewFile *.webidl set filetype=idl
  autocmd FileType c,cpp,java,kotlin     setl cindent
  autocmd FileType c,cpp,java,javascript setl expandtab tabstop=2 shiftwidth=2
  autocmd FileType xml,html              setl expandtab tabstop=4 shiftwidth=4
  autocmd FileType kotlin                setl expandtab tabstop=4 shiftwidth=4
augroup END

augroup autoformat_settings
  autocmd FileType c,cpp AutoFormatBuffer clang-format
  autocmd FileType java  AutoFormatBuffer google-java-format
  autocmd FileType rust  AutoFormatBuffer rustfmt
augroup END
