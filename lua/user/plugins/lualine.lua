return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- Define the custom theme FIRST!
    local custom_gruvbox = {
      normal = {
        a = { bg = "#458588", fg = "#ebdbb2", gui = "bold" }, -- Blue accent
        b = { bg = "#504945", fg = "#ebdbb2" }, -- Gray
        c = { bg = "#3c3836", fg = "#a89984" }, -- Dark gray
      },
      insert = {
        a = { bg = "#98971a", fg = "#ebdbb2", gui = "bold" }, -- Green
        b = { bg = "#504945", fg = "#ebdbb2" },
        c = { bg = "#3c3836", fg = "#a89984" },
      },
      visual = {
        a = { bg = "#d79921", fg = "#1d2021", gui = "bold" }, -- Yellow
        b = { bg = "#504945", fg = "#ebdbb2" },
        c = { bg = "#3c3836", fg = "#a89984" },
      },
      command = {
        a = { bg = "#cc241d", fg = "#ebdbb2", gui = "bold" }, -- Red
        b = { bg = "#504945", fg = "#ebdbb2" },
        c = { bg = "#3c3836", fg = "#a89984" },
      },
    }

    -- Function to get active linter
    local function get_linter()
      local lint = require("lint")
      local ft = vim.bo.filetype

      -- Get configured linters for current filetype
      local linters_by_ft = lint.linters_by_ft or {}
      local configured_linters = linters_by_ft[ft]

      if not configured_linters or #configured_linters == 0 then
        return "none"
      end

      -- Check which linters are actually available
      local available = {}
      for _, linter_name in ipairs(configured_linters) do
        -- Simple check - you could make this more sophisticated
        if vim.fn.executable(linter_name) == 1 or linter_name == "eslint_d" then
          table.insert(available, linter_name)
        end
      end

      if #available == 0 then
        return "missing"
      end

      return table.concat(available, ",")
    end

    -- Function to get active formatter
    local function get_formatter()
      local conform = require("conform")
      local formatters = conform.list_formatters()

      if #formatters == 0 then
        return "none"
      end

      local names = {}
      for _, formatter in ipairs(formatters) do
        table.insert(names, formatter.name)
      end

      return table.concat(names, ", ")
    end

    -- Function to get active LSP servers
    local function get_lsp_servers()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return "No LSP"
      end

      local server_names = {}
      for _, client in ipairs(clients) do
        table.insert(server_names, client.name)
      end

      return table.concat(server_names, ", ")
    end

    lualine.setup({
      options = {
        theme = custom_gruvbox,
      },
      -- rest of your config...
    })

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = custom_gruvbox,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            icon = "🌱",
          },
          {
            "diff",
            symbols = {
              added = "✨ ", -- Sparkles for additions!
              modified = "🔧 ", -- Wrench for modifications!
              removed = "🗑️ ", -- Trash for deletions!
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true, -- Shows if file is modified, readonly, etc.
            path = 0, -- Just filename
            shorting_target = 40,
            symbols = {
              modified = "💾", -- Text to show when the file is modified
              readonly = "🔒", -- Text to show when the file is non-modifiable or readonly
              unnamed = " 📄", -- Text to show for unnamed buffers
              newfile = " ✨", -- Text to show for newly created file before first write
            },
          },
        },

        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            get_lsp_servers,
            icon = "💡",
            color = { fg = "#b8bb26" },
          },
          {
            get_linter,
            icon = "🔍",
            color = { fg = "#7aa2f7" },
          },
          {
            get_formatter,
            icon = "🖼️",
            color = { fg = "#b8bb26" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
