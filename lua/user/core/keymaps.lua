vim.g.mapleader = " "
local keymap = vim.keymap.set

-- Normal --
vim.api.nvim_create_user_command("W", "wa", {})
vim.api.nvim_create_user_command("Q", "qa", {})

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

keymap("n", "<leader>sV", function()
  -- Remember current window info
  local current_buf = vim.api.nvim_get_current_buf()

  -- Close NvimTree temporarily
  vim.cmd("NvimTreeClose")

  -- Convert to vertical splits
  vim.cmd("wincmd H")

  -- Reopen NvimTree
  vim.cmd("NvimTreeOpen")

  -- Jump back to your original buffer/window
  local target_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == current_buf then
      target_win = win
      break
    end
  end

  if target_win then
    vim.api.nvim_set_current_win(target_win)
  end
end, { desc = "Convert to vertical splits and return to original window" })

keymap("n", "<leader>sH", function()
  -- Remember current window info
  local current_buf = vim.api.nvim_get_current_buf()

  -- Close NvimTree temporarily
  vim.cmd("NvimTreeClose")

  -- Convert to horizontal splits
  vim.cmd("wincmd K")

  -- Reopen NvimTree
  vim.cmd("NvimTreeOpen")

  -- Jump back to your original buffer/window
  local target_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == current_buf then
      target_win = win
      break
    end
  end

  if target_win then
    vim.api.nvim_set_current_win(target_win)
  end
end, { desc = "Convert to horizontal splits and return to original window" })

keymap("n", "<leader>se", "<C-w>=", { desc = "Make the split even" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap("n", "+", ":vertical resize +5<CR>", { desc = "make window bigger" })
keymap("n", "-", ":vertical resize -5<CR>", { desc = "make window smaller" })

keymap("n", "<leader>nh", ":nohlsearch<CR>", { desc = "remove the search highlights" })

keymap("n", "<leader>b", ":w<bar>%bd<bar>e#<CR>", { desc = "close buffers" })

-- Clipboard + Copy
keymap("v", "<leader>y", '"+y', { desc = "copy to clipboard" })
keymap("n", "<leader>Y", 'gg"+yG', { desc = "copy all to clipboard" })
keymap("n", "Y", "y$", { desc = "Yanks from cursor to the end of the line" })

-- Quick mark navigation
keymap("n", "<leader>mm", "mM", { desc = "Set quick mark M" })
keymap("n", "<leader>mg", "'M", { desc = "Go to quick mark M" })

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
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "move blocks of text 1 places up" })

keymap("v", "<leader>p", "_dP", { desc = "replace current selected text with default register with yanking it" })
keymap("n", "<leader>d", "_d", { desc = "delete without yanking" })
keymap("v", "<leader>d", "_d", { desc = "delete without yanking" })

-- Toggle inlay hints globally
keymap("n", "<leader>ih", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
  print("Inlay hints " .. (enabled and "disabled" or "enabled"))
end, { desc = "Toggle inlay hints" })

-- TypeScript config switching using the proper vtsls command
keymap("n", "<leader>cV", function()
  -- Use the same approach as LazyVim
  local clients = vim.lsp.get_clients({ name = "vtsls" })
  if #clients == 0 then
    vim.notify("vtsls not active", vim.log.levels.WARN)
    return
  end

  for _, client in ipairs(clients) do
    client.request("workspace/executeCommand", {
      command = "typescript.selectTypeScriptVersion",
      -- No arguments needed - vtsls will show a picker
    }, function(err, result)
      if err then
        vim.notify("Error: " .. vim.inspect(err), vim.log.levels.ERROR)
      else
        vim.notify("TypeScript version/config updated", vim.log.levels.INFO)
      end
    end)
  end
end, { desc = "Select TypeScript workspace version" })

-- Or create specific shortcuts
keymap("n", "<leader>tst", function()
  local clients = vim.lsp.get_clients({ name = "vtsls" })
  for _, client in ipairs(clients) do
    client.request("workspace/executeCommand", {
      command = "typescript.selectTypeScriptVersion",
      arguments = {
        -- Specify the tsconfig directly
        tsconfig = "./tsconfig.test.json",
      },
    })
  end
end, { desc = "Use test TypeScript config" })

keymap("n", "<leader>tsa", function()
  local clients = vim.lsp.get_clients({ name = "vtsls" })
  for _, client in ipairs(clients) do
    client.request("workspace/executeCommand", {
      command = "typescript.selectTypeScriptVersion",
      arguments = {
        tsconfig = "./tsconfig.json",
      },
    })
  end
end, { desc = "Use main TypeScript config" })
