call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
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

if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \ })
endif

if executable('java') && filereadable(expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar'),
        \     '-configuration',
        \     expand('~/lsp/eclipse.jdt.ls/config_linux'),
        \     '-data',
        \     '/tmp/java-lsp' . getcwd()
        \ ]},
        \ 'whitelist': ['java'],
        \ })
endif

if executable(expand('~/lsp/kotlin/server/bin/kotlin-language-server2'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': {server_info->[
        \     &shell,
        \     &shellcmdflag,
        \     expand('~/lsp/kotlin/server/bin/kotlin-language-server')
        \ ]},
        \ 'whitelist': ['kotlin']
        \ })
endif

syntax on
set modeline
set spell
set mouse-=a
set ruler
hi clear SpellBad
hi SpellBad cterm=underline
au BufRead,BufNewFile *.kt set filetype=kotlin
au BufRead,BufNewFile *.jsm set filetype=javascript
au BufRead,BufNewFile *.sjs set filetype=javascript
au BufRead,BufNewFile *.webidl set filetype=idl
au BufNewFile,BufRead *.gradle set filetype=groovy

augroup vimrc
  autocmd!
  autocmd FileType c,cpp,java            setl cindent
  autocmd FileType c,cpp,java,javascript setl expandtab tabstop=2 shiftwidth=2
  autocmd FileType xml                   setl expandtab tabstop=4 shiftwidth=4
  autocmd FileType kotlin                setl expandtab tabstop=4 shiftwidth=4
augroup END
