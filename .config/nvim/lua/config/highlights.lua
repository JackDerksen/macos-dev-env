local M = {}

function M.setup()
  -- Load the custom viis colorscheme
  local viis = require("colorschemes.viis")
  viis.setup()

  -- Get the base background color from viis
  --local bg = viis.colors.bg

  -- Make plugin backgrounds transparent by matching the base background
  --vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = viis.colors.fg, bg = bg })
  --vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = viis.colors.border, bg = bg })
  --vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = viis.colors.fg, bg = bg })
  --vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = viis.colors.fg, bg = bg })
  --vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = viis.colors.blue, bg = bg, bold = true })
  --vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = viis.colors.green, bg = bg, bold = true })
  --vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = viis.colors.red, bg = bg, bold = true })
  --vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = viis.colors.fg, bg = viis.colors.visual })

  -- Oil plugin background
  --vim.api.nvim_set_hl(0, "OilNormal", { fg = viis.colors.fg, bg = bg })
  --vim.api.nvim_set_hl(0, "OilBorder", { fg = viis.colors.fg, bg = bg })

  -- Harpoon menu background
  --vim.api.nvim_create_autocmd("FileType", {
  --  pattern = "harpoon",
  --  callback = function()
  --    vim.cmd("setlocal winhl=Normal:Normal,FloatBorder:FloatBorder,NormalFloat:Normal")
  --    vim.api.nvim_set_hl(0, "HarpoonMenu", { bg = bg })
  --    vim.api.nvim_set_hl(0, "HarpoonTitle", { fg = viis.colors.blue, bg = bg, bold = true })
  --  end,
  --})

  -- Floating window backgrounds (for LSP, completions, etc.)
  --vim.api.nvim_set_hl(0, "NormalFloat", { fg = viis.colors.fg, bg = bg })
  --vim.api.nvim_set_hl(0, "FloatBorder", { fg = viis.colors.fg, bg = bg })
  --vim.api.nvim_set_hl(0, "FloatTitle", { fg = viis.colors.blue, bg = bg, bold = true })
end

return M
