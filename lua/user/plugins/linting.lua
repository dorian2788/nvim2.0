return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Function to check if ESLint config exists
    local function eslint_config_exists()
      local config_files = {
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.yml",
        ".eslintrc.yaml",
        ".eslintrc.cjs",
        ".eslintrc.mjs",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
      }

      -- Check for config files
      for _, file in ipairs(config_files) do
        if vim.fn.findfile(file, ".;") ~= "" then
          return true
        end
      end

      -- Check if eslintConfig exists in package.json
      local package_json = vim.fn.findfile("package.json", ".;")
      if package_json ~= "" then
        local ok, package_data = pcall(vim.fn.json_decode, vim.fn.readfile(package_json))
        if ok and package_data.eslintConfig then
          return true
        end
      end

      return false
    end

    -- Conditional linter setup
    local js_ts_linters = eslint_config_exists() and { "eslint_d" } or {}

    lint.linters_by_ft = {
      javascript = js_ts_linters,
      typescript = js_ts_linters,
      javascriptreact = js_ts_linters,
      typescriptreact = js_ts_linters,
      python = { "pylint" },
      terraform = { "tflint" },
    }

    -- Configure eslint_d to avoid deprecated options and handle errors better
    lint.linters.eslint_d.args = {
      "--no-warn-ignored",
      "--format",
      "json",
      "--stdin",
      "--stdin-filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    -- Custom lint function that handles errors gracefully
    local function safe_lint()
      local filetype = vim.bo.filetype
      local linters = lint.linters_by_ft[filetype] or {}

      -- Skip if no linters configured for this filetype
      if #linters == 0 then
        return
      end

      -- For JS/TS files, double-check ESLint config exists
      if vim.tbl_contains({ "javascript", "typescript", "javascriptreact", "typescriptreact" }, filetype) then
        if not eslint_config_exists() then
          return
        end
      end

      lint.try_lint()
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = safe_lint,
    })

    vim.keymap.set("n", "<leader>ll", safe_lint, { desc = "Trigger linting for current file" })
  end,
}
