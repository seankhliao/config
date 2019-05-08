scriptencoding utf-8

let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗✗'
let g:ale_sign_warning = '⚠⚠'
let g:ale_set_signs = 1

let g:ale_linters = {
\ 'bash': ['bash-language-server'],
\ 'go': ['gopls'],
\ 'python':['pyls'],
\}

let g:ale_fixers = {
\ '*'              :['remove_trailing_lines', 'trim_whitespace'],
\ 'bash'           :['shfmt'],
\ 'c'              :['clang-format'],
\ 'cpp'            :['clang-format'],
\ 'css'            :['prettier'],
\ 'go'             :['goimports'],
\ 'html'           :['prettier'],
\ 'javascript'     :['prettier'],
\ 'javascript.jsx' :['prettier'],
\ 'json'           :['prettier'],
\ 'less'           :['prettier'],
\ 'markdown'       :['prettier'],
\ 'python'         :['yapf'],
\ 'scss'           :['prettier'],
\ 'sql'            :['sqlint'],
\ 'typescript'     :['prettier'],
\ 'xml'            :['xmllint'],
\ 'yaml'           :['prettier'],
\}

" let g:nord_comment_brightness = 14
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_status_lines = 1
let g:nord_cursor_line_number_background = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.ejs,*.js'

let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_smart_quotes = 1
let g:delimitMate_matchpairs = '(:),[:],{:}'

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1

let g:lightline = {'colorscheme': 'nord'}

syntax enable

set autoindent
set autoread
set background=dark
set breakindent
set clipboard=unnamedplus
set completeopt=menu,menuone,preview,noselect,noinsert
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
set tabstop=4
set termguicolors
set undofile
set undodir=$XDG_DATA_HOME/nvim/undo

nmap <silent> <S-Tab> <Plug>(ale_previous_wrap)
nmap <silent> <A-Tab> <Plug>(ale_next_wrap)

cnoreabbrev cr !google-chrome-unstable % 2>/dev/null
cnoreabbrev WQ wq
cnoreabbrev W w suda://%
cnoreabbrev def ALEGoToDefinition
cnoreabbrev ref ALEFindReferences
cnoreabbrev sym ALESymbolSearch
cnoreabbrev tdef ALEGoToTypeDefinition
nnoremap ; :

call plug#begin('$XDG_DATA_HOME/nvim/plugged')
    " Visual
	Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
    Plug 'ap/vim-css-color'
    Plug 'airblade/vim-gitgutter' " git gutter
    Plug 'itchyny/lightline.vim' " status line
    Plug 'nathanaelkane/vim-indent-guides'

    " Interactive
    Plug 'lambdalisue/suda.vim' " sudo write
    Plug 'tyru/caw.vim'         " comments

    " completion
    Plug 'sheerun/vim-polyglot'
    Plug 'alvan/vim-closetag' " xml tags
    Plug 'raimondi/delimitmate' " parens
    Plug 'w0rp/ale'
call plug#end()
colorscheme nord

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2E3440   ctermbg=2
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3B4252   ctermbg=0

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

fun RepoName()
    let l = 1
    for line in getline(1,"$")
        call setline(l, substitute(line, 'REPONAME', substitute(getcwd(), '^.*/', '', ''), "g"))
        let l = l + 1
    endfor
    call cursor(5, 1)
endfun

augroup md
    au!
    au BufNewFile README.md 0r $XDG_CONFIG_HOME/nvim/skeleton/README.md
    au BufNewFile README.md call RepoName()
augroup END

augroup license
    au!
    au BufNewFile LICENSE 0r $XDG_CONFIG_HOME/nvim/skeleton/LICENSE-MIT
    au BufNewFile LICENSE call setline(3, substitute(getline(3), "INSERT_YEAR", strftime("%Y"), ""))
augroup END
