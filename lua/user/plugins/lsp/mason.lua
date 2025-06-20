return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Setup Mason UI
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Setup mason-lspconfig to install LSP servers
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "gopls",
        "prismals",
        "pyright",
        "jsonls",
        "vtsls",
        "terraformls",
      },
      automatic_installation = true,
      automatic_enable = {
        "html",
        "cssls",
        "tailwindcss",
        "pyright",
        "terraformls",
      },
    })

    -- Setup mason-tool-installer for formatters and linters
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d",
        "tflint", -- terraform lint
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}
