local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

opt.ruler = true
opt.smartindent = true

-- search setting
opt.ignorecase = true
opt.smartcase = true

-- cursor line
-- opt.cursorline = true
-- opt.cursorcolumn = true

-- list
opt.list = true
opt.listchars:append("tab:▷ " ,"trail:×","extends:◣","precedes:◢","nbsp:○")


-- file
opt.undofile = true
opt.swapfile = false

-- tab preferences
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.hlsearch = false
opt.incsearch = true
opt.hidden = true
opt.scrolloff = 7
opt.mouse = ""

-- turn on termguicolors for nightfly colorscheme to work
opt.termguicolors = false
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
-- opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- line wrapping
opt.wrap = true

-- file type detection for case comments
vim.filetype.add({
  pattern = {
    ['/private/var/folders/.*'] = 'markdown',
}})
