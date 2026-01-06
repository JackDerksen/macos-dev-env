return {
  "nvim-lualine/lualine.nvim",
  event = "BufEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local viis = require("colorschemes.viis")

    local colors = {
      bg        = viis.colors.grey_1,
      fg        = viis.colors.fg,
      fg_alt    = viis.colors.grey_12,

      normal    = viis.colors.purple,
      insert    = viis.colors.blue,
      visual    = viis.colors.orange,
      replace   = viis.colors.red,
      command   = viis.colors.green,
      inactive  = viis.colors.grey_1,

      branch_bg = viis.colors.grey_5,
      diff_bg   = viis.colors.grey_3,
      diag_bg   = viis.colors.grey_2,
      right_bg  = viis.colors.grey_5,
    }

    -- Mode colors
    local mode_color = {
      n = colors.normal,
      i = colors.insert,
      v = colors.visual,
      V = colors.visual,
      [""] = colors.visual,
      R = colors.replace,
      c = colors.command,
    }

    local function mode_hl()
      return { fg = colors.bg, bg = mode_color[vim.fn.mode()] or colors.normal }
    end

    require("lualine").setup({
      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },

      sections = {
        -- LEFT
        lualine_a = {
          {
            "mode",
            -- icon = "▽",
            icon = "",
            fmt = function(str) return "" .. str .. "" end,
            color = mode_hl,
          },
        },

        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = colors.fg_alt, bg = colors.branch_bg },
          },
          {
            "diff",
            symbols = { added = "+", modified = "~", removed = "-" },
            diff_color = {
              added    = { fg = colors.fg_alt },
              modified = { fg = colors.fg_alt },
              removed  = { fg = colors.fg_alt },
            },
            color = { fg = colors.fg_alt, bg = colors.diff_bg },
          },
        },

        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn  = " ",
              info  = " ",
              hint  = "󰍉 ",
            },
            diagnostics_color = {
              error = { fg = colors.fg_alt },
              warn  = { fg = colors.fg_alt },
              info  = { fg = colors.fg_alt },
              hint  = { fg = colors.fg_alt },
            },
            color = { fg = colors.fg_alt, bg = colors.diag_bg },
          },
          {
            "filename",
            path = 0,
            color = { fg = colors.fg_alt, bg = colors.bg },
          },
        },

        -- RIGHT
        lualine_x = {
          {
            function()
              local size = vim.fn.getfsize(vim.fn.expand("%:p"))
              if size <= 0 then return "" end
              local suffix = { "b", "k", "M", "G", "T" }
              local i = 1
              while size > 1024 do
                size = size / 1024
                i = i + 1
              end
              return string.format("%.2f%s", size, suffix[i])
            end,
            color = { fg = colors.fg_alt, bg = colors.bg },
          },
          {
            "filetype",
            icon_only = false,
            colored = false,
            color = { fg = colors.fg_alt, bg = colors.right_bg },
          },
        },

        lualine_y = {},

        lualine_z = {
          {
            "location",
            icon = "",
            color = mode_hl,
          },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            color = { fg = colors.fg, bg = colors.inactive },
          },
        },
        lualine_x = {
          {
            "location",
            color = { fg = colors.fg, bg = colors.inactive },
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
