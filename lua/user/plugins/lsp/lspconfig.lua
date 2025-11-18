return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim", -- Ensure mason loads first
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local keymap = vim.keymap
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    --Import TypeScript configuration
    local vtsls_config = require("user.lsp-config.vtsls")

    -- Import JSON LSP configuration
    local jsonls_config = require("user.lsp-config.jsonls")

    -- LSP keymaps (attach when LSP server starts)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Navigation
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration in split"
        keymap.set("n", "gD", function()
          vim.lsp.buf.definition()
          vim.cmd("split")
        end, { buffer = 0, desc = "Go to definition in a new split" })

        -- Fixed: Added .set to keymap call and uncommented
        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", function()
          -- Set mark before going to declaration in split
          vim.cmd("normal! mM")
          vim.lsp.buf.definition()
          vim.cmd("split")
        end, { buffer = ev.buf, desc = "Go to definition in split (with auto-mark)" })

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- Actions
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Diagnostics
        opts.desc = "Show project diagnostics"
        keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts)

        -- Fixed: Removed stray 's' character
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        -- Documentation
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- Management
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Diagnostic symbols in the sign column
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✘",
          [vim.diagnostic.severity.WARN] = "▲",
          [vim.diagnostic.severity.HINT] = "⚑",
          [vim.diagnostic.severity.INFO] = "●",
        },
      },
    })

    -- Configure LSP servers using new vim.lsp.config API
    -- Basic servers with default settings
    vim.lsp.config("html", { capabilities = capabilities })
    vim.lsp.config("cssls", { capabilities = capabilities })
    vim.lsp.config("tailwindcss", { capabilities = capabilities })
    vim.lsp.config("prismals", { capabilities = capabilities })
    vim.lsp.config("pyright", { capabilities = capabilities })

    -- TypeScript server with custom settings
    local vtsls_opts = vtsls_config.get_config and vtsls_config.get_config(capabilities)
      or { capabilities = capabilities }
    vim.lsp.config("vtsls", vtsls_opts)

    -- JSON LSP with schema support
    vim.lsp.config("jsonls", jsonls_config.get_config(capabilities))

    -- Lua server with custom settings
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    -- Go server with custom settings
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })

    -- Enable LSP servers
    vim.lsp.enable({ "html", "cssls", "tailwindcss", "prismals", "pyright", "vtsls", "jsonls", "lua_ls", "gopls" })
  end,
}
