vim.g.mapleader = " "
local keymap = vim.keymap.set

-- Normal --
keymap("n", "<cmd>W<CR>", "<cmd>wa<CR>", { desc = "Save all" })

-- Centered
keymap("n", "n", "nzzzv", { desc = "Brings search results to midscreen" })
keymap("n", "N", "Nzzzv", { desc = "Brings search results to midscreen" })
keymap("n", "J", "mxJ`z", { desc = "Brings you to the thing you marked with z" })

-- Better window navigation
keymap("n", "<leader>h", ":wincmd h<CR>", { desc = "Move left" })
keymap("n", "<leader>j", ":wincmd j<CR>", { desc = "Move down" })
keymap("n", "<leader>k", ":wincmd k<CR>", { desc = "Move up" })
keymap("n", "<leader>l", ":wincmd l<CR>", { desc = "Move right" })

keymap("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make the split even" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap("n", "+", ":vertical resize +5<CR>", { desc = "make window bigger" })
keymap("n", "-", ":vertical resize -5<CR>", { desc = "make window smaller" })

keymap("n", "<leader>nh", ":nohlsearch<CR>", { desc = "remove the search highlights" })

keymap("n", "<leader>b", ":w<bar>%bd<bar>e#<CR>", { desc = "close buffers" })

-- Clipboard + Copy
keymap("n", "<leader>y", '"+y', { desc = "copy to clipboard" })
keymap("n", "<leader>Y", 'gg"+yG', { desc = "copy all to clipboard" })
keymap("n", "Y", "y$", { desc = "Yanks from cursor to the end of the line" })

-- Insert --

-- add undo break points
keymap("i", ",", ",<C-g>u", { desc = "add breakpoint for ," })
keymap("i", ".", ".<C-g>u", { desc = "add breakpoint for ." })
keymap("i", "!", "!<C-g>u", { desc = "add breakpoint for !" })
keymap("i", "?", "?<C-g>u", { desc = "add breakpoint for ?" })

-- window management
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- {
-- }
keymap("i", "{<CR>", "{}<esc>i<CR><esc>O", { desc = "Add cursor inside new line created with braces" })

-- /**
keymap("i", "/**<CR>", "/**<CR><CR><BS>/<esc>i*<esc>ko", { desc = "Adding comment completion" })

-- Visual --

-- Move blocks of text
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "move blocks of text 1 places down" })
keymap("v", "K", ":m '<-1<CR>gv=gv", { desc = "move blocks of text 2 places up" })

keymap("v", "<leader>p", "_dP", { desc = "replace current selected text with default register with yanking it" })
keymap("n", "<leader>d", "_d", { desc = "delete without yanking" })
keymap("v", "<leader>d", "_d", { desc = "delete without yanking" })
