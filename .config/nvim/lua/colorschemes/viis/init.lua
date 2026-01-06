-- Custom colorscheme for Neovim
local M = {}

-- Color palette
local colors = {
  bg = "#1a191c",
  fg = "#e2e2e3",

  selection_bg = "#2d2b30",
  selection_fg = "#e2e2e3",

  cursor = "#e2e2e3",

  black = "#1a191c",
  red = "#fc808f",
  green = "#bcf092",
  yellow = "#f3e48c",
  blue = "#9be3ed",
  purple = "#b4befe",
  orange = "#ffac72",
  white = "#e2e2e3",

  bright_black = "#2d2b30",
  bright_red = "#ff9db1",
  bright_green = "#cfeec2",
  bright_yellow = "#f5e8af",
  bright_blue = "#bbe8ee",
  bright_purple = "#d6d9fc",
  bright_orange = "#ffc79e",
  bright_white = "#eeeeef",

  --grey_1 = "#353339",
  --grey_2 = "#504d56",
  --grey_3 = "#6b6773",
  --grey_4 = "#868191",
  --grey_5 = "#847f8f",
  --grey_6 = "#a19bae",
  --grey_7 = "#bcb5cb",

  -- Refined these a bit
  grey_1 = "#222125",
  grey_2 = "#27262a",
  grey_3 = "#2d2b30",
  grey_4 = "#333137",
  grey_5 = "#3d3a41",
  grey_6 = "#45434a",
  grey_7 = "#4d4a52",
  grey_8 = "#54515a",
  grey_9 = "#5f5c66",
  grey_10 = "#68656f",
  grey_11 = "#74707b",
  grey_12 = "#8b8792",

  visual = "#2d2b30",
  match = "#bcf092",

  error = "#ff9db1",
  warning = "#ffc79e",
  info = "#9be3ed",
  hint = "#9be3ed",
  success = "#bcf092",
}

-- Apply the colorscheme
function M.setup()
  -- Reset highlighting
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "viis"

  local highlights = {
    -- Editor highlights
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg },
    FloatBorder = { fg = colors.grey_7, bg = colors.bg },
    FloatTitle = { fg = colors.blue, bg = colors.bg, bold = true },

    -- Cursor and lines
    Cursor = { fg = colors.bg, bg = colors.cursor },
    CursorLine = { bg = colors.grey_1 },
    CursorLineNr = { fg = colors.fg, bold = true },
    LineNr = { fg = colors.fg, bold = true },
    LineNrAbove = { fg = colors.grey_5 },
    LineNrBelow = { fg = colors.grey_5 },

    -- Visual selection
    Visual = { bg = colors.visual, fg = colors.fg },
    VisualNOS = { bg = colors.visual, fg = colors.bg },

    -- Search
    Search = { bg = colors.match, fg = colors.bg },
    IncSearch = { bg = colors.bright_blue, fg = colors.bg },
    CurSearch = { bg = colors.bright_blue, fg = colors.bg },

    -- Columns and guides
    ColorColumn = { bg = colors.grey_1 },
    SignColumn = { bg = colors.bg },
    FoldColumn = { fg = colors.grey_2, bg = colors.bg },

    -- Status line
    StatusLine = { fg = colors.fg, bg = colors.bg },
    StatusLineNC = { fg = colors.grey_2, bg = colors.bg },

    -- Tab line
    TabLine = { fg = colors.grey_2, bg = colors.bg },
    TabLineFill = { bg = colors.bg },
    TabLineSel = { fg = colors.fg, bg = colors.bg },

    -- Popup menu
    Pmenu = { fg = colors.fg, bg = colors.bg },
    PmenuSel = { fg = colors.bg, bg = colors.blue },
    PmenuSbar = { bg = colors.bg },
    PmenuThumb = { bg = colors.grey_2 },

    -- Messages
    ErrorMsg = { fg = colors.error },
    WarningMsg = { fg = colors.warning },
    MoreMsg = { fg = colors.green },
    ModeMsg = { fg = colors.blue },

    -- Diff
    DiffAdd = { fg = colors.green, bg = colors.bg },
    DiffChange = { fg = colors.yellow, bg = colors.bg },
    DiffDelete = { fg = colors.red, bg = colors.bg },
    DiffText = { fg = colors.bright_yellow, bg = colors.bg },

    -- Folding
    Folded = { fg = colors.grey_2, bg = colors.bg },

    -- Spelling
    SpellBad = { sp = colors.error, underline = false },
    SpellCap = { sp = colors.warning, underline = false },
    SpellLocal = { sp = colors.hint, underline = false },
    SpellRare = { sp = colors.info, underline = false },

    -- Syntax highlighting
    Comment = { fg = colors.grey_7, italic = false },
    Constant = { fg = colors.purple },
    String = { fg = colors.green },
    Character = { fg = colors.green },
    Number = { fg = colors.purple },
    Boolean = { fg = colors.purple },
    Float = { fg = colors.bright_purple },

    Identifier = { fg = colors.orange },
    Function = { fg = colors.blue },

    Statement = { fg = colors.red },
    Conditional = { fg = colors.red },
    Repeat = { fg = colors.red },
    Label = { fg = colors.red },
    Operator = { fg = colors.fg },
    Keyword = { fg = colors.red },
    Exception = { fg = colors.red },

    PreProc = { fg = colors.yellow },
    Include = { fg = colors.red },
    Define = { fg = colors.red },
    Macro = { fg = colors.yellow },
    PreCondit = { fg = colors.white },

    Type = { fg = colors.yellow },
    StorageClass = { fg = colors.red },
    Structure = { fg = colors.yellow },
    Typedef = { fg = colors.yellow },

    Special = { fg = colors.orange },
    SpecialChar = { fg = colors.orange },
    Tag = { fg = colors.blue },
    Delimiter = { fg = colors.fg },
    SpecialComment = { fg = colors.orange },
    Debug = { fg = colors.orange },

    Underlined = { underline = true },
    Error = { fg = colors.error },
    Todo = { fg = colors.warning, bg = colors.bg, bold = true },

    -- LSP highlights
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warning },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },

    DiagnosticUnderlineError = { sp = colors.error, underline = false },
    DiagnosticUnderlineWarn = { sp = colors.warning, underline = false },
    DiagnosticUnderlineInfo = { sp = colors.info, underline = false },
    DiagnosticUnderlineHint = { sp = colors.hint, underline = false },

    -- Tree-sitter highlights
    ["@variable"] = { fg = colors.fg },
    ["@variable.builtin"] = { fg = colors.purple },
    ["@variable.parameter"] = { fg = colors.orange },
    ["@variable.member"] = { fg = colors.orange },

    ["@constant"] = { fg = colors.purple },
    ["@constant.builtin"] = { fg = colors.purple },
    ["@constant.macro"] = { fg = colors.yellow },

    ["@string"] = { fg = colors.green },
    ["@string.escape"] = { fg = colors.orange },
    ["@string.special"] = { fg = colors.orange },

    ["@character"] = { fg = colors.green },
    ["@character.special"] = { fg = colors.orange },

    ["@number"] = { fg = colors.purple },
    ["@boolean"] = { fg = colors.purple },
    ["@float"] = { fg = colors.bright_purple },

    ["@function"] = { fg = colors.blue },
    ["@function.builtin"] = { fg = colors.blue },
    ["@function.macro"] = { fg = colors.purple },
    ["@function.method"] = { fg = colors.blue },

    ["@constructor"] = { fg = colors.fg },
    ["@operator"] = { fg = colors.fg },

    ["@keyword"] = { fg = colors.red },
    ["@keyword.function"] = { fg = colors.red },
    ["@keyword.operator"] = { fg = colors.fg },
    ["@keyword.return"] = { fg = colors.red },
    ["@keyword.conditional"] = { fg = colors.red },
    ["@keyword.repeat"] = { fg = colors.red },
    ["@keyword.exception"] = { fg = colors.red },
    ["@keyword.import"] = { fg = colors.fg },

    ["@type"] = { fg = colors.bright_blue },
    ["@type.builtin"] = { fg = colors.bright_orange },
    ["@type.definition"] = { fg = colors.bright_orange },

    ["@attribute"] = { fg = colors.orange },
    ["@property"] = { fg = colors.orange },

    ["@comment"] = { fg = colors.grey_6, italic = false },
    ["@comment.todo"] = { fg = colors.warning, bg = colors.grey_3, bold = true },
    ["@comment.note"] = { fg = colors.info, bg = colors.grey_3, bold = true },
    ["@comment.warning"] = { fg = colors.warning, bg = colors.grey_3, bold = true },
    ["@comment.error"] = { fg = colors.error, bg = colors.grey_3, bold = true },

    ["@punctuation.delimiter"] = { fg = colors.fg },
    ["@punctuation.bracket"] = { fg = colors.fg },
    ["@punctuation.special"] = { fg = colors.orange },

    ["@tag"] = { fg = colors.red },
    ["@tag.attribute"] = { fg = colors.yellow },
    ["@tag.delimiter"] = { fg = colors.fg },

    -- Git highlights (for gitsigns, etc.)
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.yellow },
    GitSignsDelete = { fg = colors.red },

    -- Telescope highlights
    TelescopeNormal = { fg = colors.fg, bg = colors.bg },
    TelescopeBorder = { fg = colors.grey_7, bg = colors.bg },
    TelescopePromptNormal = { fg = colors.fg, bg = colors.bg },
    TelescopePromptBorder = { fg = colors.grey_7, bg = colors.bg },
    TelescopePromptTitle = { fg = colors.orange, bg = colors.bg, bold = true },
    TelescopePreviewTitle = { fg = colors.green, bg = colors.bg, bold = true },
    TelescopeResultsTitle = { fg = colors.blue, bg = colors.bg, bold = true },
    TelescopeSelection = { fg = colors.fg, bg = colors.grey_2 },
    TelescopeSelectionCaret = { fg = colors.blue },
    TelescopeMatching = { fg = colors.blue, bold = true },

    -- Oil highlights
    OilNormal = { fg = colors.fg, bg = colors.bg },
    OilBorder = { fg = colors.grey_7, bg = colors.bg },
    OilTitle = { fg = colors.blue, bg = colors.bg, bold = true },
    OilDir = { fg = colors.blue },
    OilDirIcon = { fg = colors.blue },
    OilFile = { fg = colors.fg },
    OilFileIcon = { fg = colors.orange },

    -- Harpoon highlights
    HarpoonNormal = { fg = colors.fg, bg = colors.bg },
    HarpoonBorder = { fg = colors.grey_7, bg = colors.bg },
    HarpoonTitle = { fg = colors.blue, bg = colors.bg, bold = true },
    HarpoonWindow = { fg = colors.fg, bg = colors.bg },

    -- Mini indent scope
    MiniIndentscopeSymbol = { fg = colors.grey_4 },

    -- Which-key
    WhichKey = { fg = colors.blue },
    WhichKeyGroup = { fg = colors.orange },
    WhichKeyDesc = { fg = colors.fg },
    WhichKeySeperator = { fg = colors.grey_3 },
    WhichKeyFloat = { bg = colors.grey_2 },
    WhichKeyBorder = { fg = colors.grey_7, bg = colors.grey_1 },
  }

  -- Apply all highlights
  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Set terminal colors
  vim.g.terminal_color_0 = colors.black
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_5 = colors.purple
  vim.g.terminal_color_6 = colors.orange
  vim.g.terminal_color_7 = colors.white
  vim.g.terminal_color_8 = colors.bright_black
  vim.g.terminal_color_9 = colors.bright_red
  vim.g.terminal_color_10 = colors.bright_green
  vim.g.terminal_color_11 = colors.bright_yellow
  vim.g.terminal_color_12 = colors.bright_blue
  vim.g.terminal_color_13 = colors.bright_purple
  vim.g.terminal_color_14 = colors.bright_orange
  vim.g.terminal_color_15 = colors.bright_white
end

-- Export colors for other plugins (like heirline config)
M.colors = colors

return M
