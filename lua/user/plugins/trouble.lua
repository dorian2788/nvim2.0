return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>qq", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "<leader>qf", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
    { "<leader>ql", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>qt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
    { "<leader>qr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP references in trouble" },

    { "]q", "<cmd> Trouble quickfix next<CR>", desc = "Move next in quickfix list" },
    { "[q", "<cmd> Trouble quickfix prev<CR>", desc = "Move prev in quickfix list" },
  },
}
