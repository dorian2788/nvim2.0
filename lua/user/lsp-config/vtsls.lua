local M = {}

-- VTSLS server configuration
M.server_config = {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        importModuleSpecifier = "non-relative",
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}

-- Custom on_attach function for vtsls - only TypeScript-specific keymaps
M.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- TypeScript specific actions (these are unique to vtsls)
  opts.desc = "Organize Imports"
  vim.keymap.set("n", "<leader>co", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports" },
      },
    })
  end, opts)

  opts.desc = "Add missing imports"
  vim.keymap.set("n", "<leader>cM", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.addMissingImports.ts" },
      },
    })
  end, opts)

  opts.desc = "Remove unused imports"
  vim.keymap.set("n", "<leader>cu", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.removeUnused.ts" },
      },
    })
  end, opts)

  opts.desc = "Fix all diagnostics"
  vim.keymap.set("n", "<leader>cD", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.fixAll.ts" },
      },
    })
  end, opts)

  opts.desc = "Select TypeScript workspace version"
  vim.keymap.set("n", "<leader>cV", function()
    vim.lsp.buf.execute_command({ command = "typescript.selectTypeScriptVersion" })
  end, opts)

  -- Note: All other LSP keymaps (gd, gR, K, <leader>ca, etc.)
  -- are handled by the main LspAttach autocmd in lspconfig.lua
end

-- Get configuration that can be used with vim.lsp.config
M.get_config = function(capabilities)
  return vim.tbl_deep_extend("force", M.server_config, {
    capabilities = capabilities,
    on_attach = M.on_attach,
  })
end

return M
