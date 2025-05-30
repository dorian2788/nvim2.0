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
            get_formatter,
            icon = "🖼️",
            color = { fg = "#98bb6c" },
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
