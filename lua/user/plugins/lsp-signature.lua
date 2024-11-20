return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  },
  config = function()
    local keymap = vim.keymap
    keymap.set({ "n" }, "<Leader>fs", function()
      require("lsp_signature").toggle_float_win()
    end, { silent = true, noremap = true, desc = "toggle signature" })
  end,
}
