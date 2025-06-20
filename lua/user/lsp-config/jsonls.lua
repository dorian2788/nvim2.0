-- lua/user/lsp-config/jsonls.lua
-- JSON LSP configuration with schema support

local M = {}

function M.get_config(capabilities)
  return {
    capabilities = capabilities,
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        -- Enable schema validation and autocomplete
        validate = { enable = true },
        -- Schemas from https://www.schemastore.org
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = { "jsconfig*.json" },
            url = "https://json.schemastore.org/jsconfig.json",
          },
          {
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json",
            },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = { ".eslintrc", ".eslintrc.json" },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            fileMatch = { "eslint.config.json" },
            url = "https://json.schemastore.org/eslint.json",
          },
          {
            fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
            url = "https://json.schemastore.org/babelrc.json",
          },
          {
            fileMatch = { "lerna.json" },
            url = "https://json.schemastore.org/lerna.json",
          },
          {
            fileMatch = { "now.json", "vercel.json" },
            url = "https://json.schemastore.org/now.json",
          },
          {
            fileMatch = {
              ".stylelintrc",
              ".stylelintrc.json",
              "stylelint.config.json",
            },
            url = "https://json.schemastore.org/stylelintrc.json",
          },
          {
            fileMatch = { "nx.json" },
            url = "https://json.schemastore.org/nx.json",
          },
          {
            fileMatch = { "jest.config.json" },
            url = "https://json.schemastore.org/jest.json",
          },
          {
            fileMatch = { "vite.config.json" },
            url = "https://json.schemastore.org/vite.json",
          },
          {
            fileMatch = { "webpack.config.json" },
            url = "https://json.schemastore.org/webpack.json",
          },
          {
            fileMatch = { "rollup.config.json" },
            url = "https://json.schemastore.org/rollup.json",
          },
          {
            fileMatch = { "tailwind.config.json" },
            url = "https://json.schemastore.org/tailwindcss.json",
          },
          {
            fileMatch = { "launch.json" },
            url = "https://json.schemastore.org/launch.json",
          },
          {
            fileMatch = { "settings.json" },
            url = "https://json.schemastore.org/vscode-settings.json",
          },
          {
            fileMatch = { ".nvmrc" },
            url = "https://json.schemastore.org/nvmrc.json",
          },
          {
            fileMatch = { "Dockerfile.json" },
            url = "https://json.schemastore.org/dockerfile.json",
          },
          {
            fileMatch = { "docker-compose*.json" },
            url = "https://json.schemastore.org/docker-compose.json",
          },
          {
            fileMatch = { ".github/workflows/*.json" },
            url = "https://json.schemastore.org/github-workflow.json",
          },
          {
            fileMatch = { ".github/dependabot.json" },
            url = "https://json.schemastore.org/dependabot-2.0.json",
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      -- Optional: Add JSON-specific keymaps here
      local opts = { buffer = bufnr, silent = true }

      -- Format JSON
      vim.keymap.set("n", "<leader>jf", function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend("force", opts, { desc = "Format JSON" }))
    end,
  }
end

return M
