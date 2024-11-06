vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.backup = false -- set backup false
-- opt.setswapfile = false --creates a swapfile
opt.hidden = true
opt.errorbells = false
opt.syntax = "on"
opt.mouse = "a" -- allow mouse to be used in nvim

-- numbering
opt.relativenumber = true
opt.number = true
opt.ruler = false
opt.scrolloff = 8
opt.colorcolumn = "80"

-- tab & indentation
opt.tabstop = 2 -- 2 spaces for tab
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.showtabline = 0 --always show tabs

opt.wrap = false 

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in search assume you want case-sensitive
opt.hlsearch = true --highlights all the previous search patterns
opt.incsearch = true

opt.cursorline = true -- highlight the cursor line

opt.termguicolors = true -- true terminal colours
opt.background = "dark" -- darkmode
opt.signcolumn = "yes" -- show sign colum so text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, EOL or insert mode start

--clipboard 
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split
opt.splitright = true
opt.splitbelow = true

-- undo
opt.undofile = true
opt.undodir = os.getenv("HOME").."/.nvim/undodir"
opt.updatetime = 200
opt.writebackup = false

-- status
opt.cmdheight = 2
opt.laststatus = 3
opt.showcmd = false
