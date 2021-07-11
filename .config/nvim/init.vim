" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath

" colorscheme
colorscheme gruvbox
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight MatchParen cterm=bold ctermbg=none ctermfg=magenta
" set termguicolors " caused gruvbox bg become solid

" Essentials
set smartindent
set relativenumber number
set ruler
syntax on
filetype plugin indent on
set tabstop=4       " The width of a TAB /t is set to 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set smartindent
set nohlsearch
set nocompatible
set hidden
set scrolloff=7

" Status line
set statusline=
set statusline +=\ %n\            "buffer number
set statusline +=%{&ff}            "file format
set statusline +=%y                "file type
set statusline +=\ %<%F            "full path
set statusline +=%m                "modified flag
set statusline +=%=%5l             "current line
set statusline +=/%L               "total lines
set statusline +=%4v\             "virtual column number
set statusline +=0x%04B\          "character under cursor
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Vim cursor configurations
let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode

" Vimwiki specific conf
let g:vimwiki_list = [{'path': '~/MEGAsync/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
set conceallevel=2

" Vim hardtime
let g:hardtime_default_on = 1

" Launching nvim directly from command line window size fix
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

" Tree-sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
--	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	-- ignore_install = { "javascript" }, -- List of parsers to ignore installing
	highlight = { enable = true,              -- false will disable the whole extension
				 -- disable = { "c", "rust" },  -- list of language that will be disabled
				},
	indent = { enable = true }	
}
EOF
