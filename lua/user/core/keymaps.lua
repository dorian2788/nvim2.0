vim.g.mapleader = " "
local keymap = vim.keymap.set

-- Normal --
--
-- Y behave like captial letters
keymap("n", "Y", "y$", {desc = ""})

-- Centered
keymap("n", "n", "nzzzv", {desc = "Brings search results to midscreen"})
keymap("n", "N", "Nzzzv", {desc = "Brings search results to midscreen"})
keymap("n", "J", "mxJ`z", {desc = "Brings you to the thing you marked with z"})

-- keymap("n", "<leader>e", ":Explore<CR>", {desc = ""})

-- Better window navigation
keymap("n", "<leader>v", ":vsplit<CR>", {desc = "Vertical split"})
keymap("n", "<leader>h", ":wincmd h<CR>", {desc = "Horizontal split"})
keymap("n", "<leader>j", ":wincmd j<CR>", {desc = "Move down"})
keymap("n", "<leader>k", ":wincmd k<CR>", {desc = "Move up"})
keymap("n", "<leader>l", ":wincmd l<CR>", {desc = "Move right"})
keymap("n", "<leader>se", "<C-w>=", {desc = "Move left"})

keymap("n", "<leader>+", ":vertical resize +5<CR>", {desc = "make window bigger"})
keymap("n", "<leader>-", ":vertical resize -5<CR>", {desc = "make window smaller"})

-- Clear highlights
keymap("n", "<leader>nh", ":nohlsearch<CR>", {desc = "remove the search highlights"})

--Close buffers
keymap("n", "<leader>b", ":w<bar>%bd<bar>e#<CR>", {desc = "close buffers"})

-- cpy clipboard
keymap("n", "<leader>y", '"+y', {desc = "copy to clipboard"})

-- cpy all
keymap("n", "<leader>Y", 'gg"+yG', {desc = "copy all to clipboard"})

-- Insert --

-- undo break points
keymap("i", ",", ",<C-g>u", {desc = "add breakpoint for ,"})
keymap("i", ".", ".<C-g>u", {desc = "add breakpoint for ."})
keymap("i", "!", "!<C-g>u", {desc = "add breakpoint for !"})
keymap("i", "?", "?<C-g>u", {desc = "add breakpoint for ?"})

-- window management
keymap("n", "<leader>to", "<cmd>tabnew<CR>", {desc = "Open new tab"})
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", {desc = "Close current tab"})
keymap("n", "<leader>tn", "<cmd>tabn<CR>", {desc = "Go to next tab"})
keymap("n", "<leader>tp", "<cmd>tabp<CR>", {desc = "Go to previous tab"})
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", {desc = "Open current buffer in new tab"})

-- {
-- }
-- keymap("i", "{<CR>", "{}<esc>i<CR><esc>O", {desc = ""})

-- /**
-- keymap("i", "/**<CR>", "/**<CR><CR><BS>/<esc>i*<esc>ko", {desc = ""})

-- Visual --

-- Move blocks of text
keymap("v", "K", ":m '<-2<CR>gv=gv", {desc = "move blocks of text 2 places up"})
keymap("v", "j", ":m '>+1<cr>gv=gv", {desc = "move blocks of text 1 places down"})

-- go down one line
keymap("v", "<leader>p", "_dP", {desc = "Delete text into a blackhole register and then paste"})


-- -- Telescope --
-- keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", {desc = ""})
-- keymap("n", "<leader>ft", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {desc = ""})
-- keymap("n", "<leader>fp", "<cmd>lua require('telescope.builtin').buffers()<cr>", {desc = ""})
-- keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {desc = ""})
--
-- -- TreeSitter --
-- keymap("n", "<F7>", "<cmd>TSHighlightCapturesUnderCursor<cr>", {desc = ""})
-- keymap("n", "<F8>", "<cmd>TSPlaygroundToggle<cr>", {desc = ""})
--
-- -- Nvim-Tree --
-- keymap("n", "<leader>e", ":NvimTreeToggle<cr>", {desc = ""})
--
-- -- Git --
-- keymap("n", "<leader>ga", ":Git fetch --all<CR>")
-- keymap("n", "<leader>grum", ":Git rebase upstream/master<CR>")
-- keymap("n", "<leader>grom", ":Git rebase origin/master<CR>")
--
-- keymap("n", "<leader>gh", ":diffget //3<CR>")
-- keymap("n", "<leader>gf", ":diffget //2<CR>")
-- keymap("n", "<leader>gs", ":G<CR>")
-- keymap("n", "<leader>gd", ":Git difftool<CR>")
--
-- keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')
