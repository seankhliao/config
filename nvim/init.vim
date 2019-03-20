scriptencoding utf-8

let g:nord_comment_brightness = 14
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_status_lines = 1
let g:nord_cursor_line_number_background = 1

call plug#begin('$XDG_DATA_HOME/nvim/plugged')
    Plug 'alvan/vim-closetag' " xml tags
    Plug 'airblade/vim-gitgutter' " git gutter
    Plug 'ap/vim-css-color'
    Plug 'itchyny/lightline.vim' " status line
    Plug 'lambdalisue/suda.vim' " sudo write
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'raimondi/delimitmate' " parens
    Plug 'tyru/caw.vim'         " comments

	Plug 'arcticicestudio/nord-vim'

    Plug 'sheerun/vim-polyglot'
    Plug 'Shougo/context_filetype.vim'
    Plug 'cdata/vim-tagged-template'

    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'

    Plug 'ncm2/ncm2-bufword' " words in buffer
    Plug 'fgrsnau/ncm-otherbuf' " other buffers
    Plug 'ncm2/ncm2-path'   " path completion
    Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax' " syntax completion

    Plug 'ncm2/ncm2-markdown-subscope'
    Plug 'ncm2/ncm2-html-subscope'

    " Plug 'ncm2/ncm2-cssomni'
    " Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'ncm2/ncm2-go'

    Plug 'autozimu/LanguageClient-neovim', {
       \ 'branch': 'next',
       \ 'do': 'bash install.sh',
       \ }
    
    Plug 'w0rp/ale'

call plug#end()

let g:ale_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗✗'
let g:ale_sign_warning = '⚠⚠'
let g:ale_lint_on_insert_leave = 1
let g:ale_set_signs = 1

let g:ale_fixers = {
\ 'bash'    : ['shfmt'],
\ 'c'       : ['clang-format'],
\ 'cpp'     : ['clang-format'],
\ 'css'     : ['prettier'],
\ 'go'      : ['goimports'],
\ 'html'    : ['prettier'],
\ 'javascript': ['prettier'],
\ 'javascript.jsx': ['prettier'],
\ 'json'    : ['prettier'],
\ 'less'    : ['prettier'],
\ 'markdown': ['prettier'],
\ 'python'  : ['yapf'],
\ 'scss'    : ['prettier'],
\ 'sql'     : ['sqlint'],
\ 'typescript': ['prettier'],
\ 'xml'     : ['xmllint'],
\ 'yaml'    : ['prettier'],
\}
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.ejs,*.js'
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_smart_quotes = 1
let g:delimitMate_matchpairs = '(:),[:],{:}'
" let g:html_indent_style1 = "inc"
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:jedi#auto_initialization = 0
let g:lightline = {'colorscheme': 'nord'}
let g:LanguageClient_rootMarkers = {
        \ 'go': ['.git', 'go.mod'],
        \ }

let g:LanguageClient_serverCommands = {
    \ 'bash': ['bash-language-server', 'start'],
    \ }
     " 'go': ['bingo', '--mode', 'stdio', '--logfile', '/tmp/lspserver.log','--trace', '--pprof', ':6060'],


let g:taggedtemplate#tagSyntaxMap = {
  \ "html": "html",
  \ "md":   "markdown",
  \ "css":  "css" }

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2E3440   ctermbg=2
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3B4252   ctermbg=0

autocmd BufEnter * call ncm2#enable_for_buffer()

syntax enable
colorscheme nord

set autoindent
set autoread
set background=dark
set breakindent
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set confirm
set copyindent
set expandtab
set foldlevelstart=10           
set foldmethod=syntax
set fsync
set grepprg=rg
set ignorecase
set inccommand=split
set incsearch
set mouse=a
set mousefocus
set noswapfile
set number
set scrolloff=4
set shiftwidth=4
set shortmess=aoOtTIc
set sidescrolloff=4
set smartcase
set smartindent
set smarttab
set softtabstop=4
" set spell
set tabstop=4
set termguicolors
set undofile
set undodir=$XDG_DATA_HOME/nvim/undo

cnoreabbrev cr !google-chrome-unstable % 2>/dev/null
cnoreabbrev gi GoImport
cnoreabbrev gd GoDoc
cnoreabbrev WQ wq
cnoreabbrev W w suda://%
inoremap <c-c> <ESC>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap ; :

autocmd BufNewFile,BufRead *.py.schema setfiletype yaml
autocmd FileType javascript,typescript call taggedtemplate#applySyntaxMap()

augroup sh
    au!
    au BufNewFile *.sh 0r $XDG_CONFIG_HOME/nvim/skeleton/skeleton.sh
    au BufNewFile *.sh call cursor(2, 1)
augroup END
augroup html
    au!
    au BufNewFile *.html 0r $XDG_CONFIG_HOME/nvim/skeleton/skeleton.html
    au BufNewFile *.html call cursor(5, 6)
augroup END

augroup go
    au!
    au BufNewFile main.go 0r $XDG_CONFIG_HOME/nvim/skeleton/skeleton.go
    au BufNewFile main.go call cursor(4, 4)
augroup END

augroup md
    au!
    au BufNewFile README.md 0r $XDG_CONFIG_HOME/nvim/skeleton/README.md
    au BufNewFile README.md call RepoName()
augroup END
fun RepoName()
    let l = 1
    for line in getline(1,"$")
        call setline(l, substitute(line, 'REPONAME', substitute(getcwd(), '^.*/', '', ''), "g"))
        let l = l + 1
    endfor
    call cursor(5, 1)
endfun

augroup license
    au!
    au BufNewFile LICENSE 0r $XDG_CONFIG_HOME/nvim/skeleton/LICENSE-MIT
    au BufNewFile LICENSE call setline(3, substitute(getline(3), "INSERT_YEAR", strftime("%Y"), ""))
augroup END
