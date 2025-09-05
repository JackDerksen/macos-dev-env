-- 0x96f colorscheme for Neovim
local M = {}

-- Color palette
local colors = {
  -- Base colors
  bg = "#262427",
  fg = "#fcfcfa",

  -- Selection
  selection_bg = "#fcfcfa",
  selection_fg = "#262427",

  -- Cursor
  cursor = "#ffca58",

  -- Standard 16-color palette
  black = "#262427",
  red = "#ff7272",
  green = "#bcdf59",
  yellow = "#ffca58",
  blue = "#49cae4",
  magenta = "#a093e2",
  cyan = "#aee8f4",
  white = "#fcfcfa",

  -- Bright variants
  bright_black = "#545452",
  bright_red = "#ff8787",
  bright_green = "#c6e472",
  bright_yellow = "#ffd271",
  bright_blue = "#64d2e8",
  bright_magenta = "#aea3e6",
  bright_cyan = "#baebf6",
  bright_white = "#fcfcfa",

  -- Additional UI colors (derived from palette)
  bg_alt = "#2a2730",  -- Slightly lighter than bg
  bg_dark = "#1e1e21", -- Darker than bg
  fg_alt = "#e8e8e6",  -- Slightly dimmer than fg
  fg_dark = "#a8a8a6", -- Much dimmer than fg

  -- Status and UI
  border = "#545452",
  comment = "#8a8a88",
  visual = "#49cae4",
  match = "#ffca58",
  error = "#ff7272",
  warning = "#ffca58",
  info = "#49cae4",
  hint = "#a093e2",
  success = "#bcdf59",
}

-- Apply the colorscheme
function M.setup()
  -- Reset highlighting
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "0x96f"

  local highlights = {
    -- Editor highlights
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg_alt },
    FloatBorder = { fg = colors.border, bg = colors.bg_alt },
    FloatTitle = { fg = colors.blue, bg = colors.bg_alt, bold = true },

    -- Cursor and lines
    Cursor = { fg = colors.bg, bg = colors.cursor },
    CursorLine = { bg = colors.bg_alt },
    CursorLineNr = { fg = colors.yellow, bold = true },
    LineNr = { fg = colors.comment },
    LineNrAbove = { fg = colors.fg_dark },
    LineNrBelow = { fg = colors.fg_dark },

    -- Visual selection
    Visual = { bg = colors.visual, fg = colors.bg },
    VisualNOS = { bg = colors.visual, fg = colors.bg },

    -- Search
    Search = { bg = colors.match, fg = colors.bg },
    IncSearch = { bg = colors.bright_yellow, fg = colors.bg },
    CurSearch = { bg = colors.bright_yellow, fg = colors.bg },

    -- Columns and guides
    ColorColumn = { bg = colors.bg_alt },
    SignColumn = { bg = colors.bg },
    FoldColumn = { fg = colors.comment, bg = colors.bg },

    -- Status line
    StatusLine = { fg = colors.fg, bg = colors.bg_dark },
    StatusLineNC = { fg = colors.comment, bg = colors.bg_dark },

    -- Tab line
    TabLine = { fg = colors.comment, bg = colors.bg_dark },
    TabLineFill = { bg = colors.bg_dark },
    TabLineSel = { fg = colors.fg, bg = colors.bg },

    -- Popup menu
    Pmenu = { fg = colors.fg, bg = colors.bg_alt },
    PmenuSel = { fg = colors.bg, bg = colors.blue },
    PmenuSbar = { bg = colors.bg_dark },
    PmenuThumb = { bg = colors.comment },

    -- Messages
    ErrorMsg = { fg = colors.error },
    WarningMsg = { fg = colors.warning },
    MoreMsg = { fg = colors.green },
    ModeMsg = { fg = colors.blue },

    -- Diff
    DiffAdd = { fg = colors.green, bg = colors.bg_alt },
    DiffChange = { fg = colors.yellow, bg = colors.bg_alt },
    DiffDelete = { fg = colors.red, bg = colors.bg_alt },
    DiffText = { fg = colors.bright_yellow, bg = colors.bg_alt },

    -- Folding
    Folded = { fg = colors.comment, bg = colors.bg_alt },

    -- Spelling
    SpellBad = { sp = colors.error, undercurl = true },
    SpellCap = { sp = colors.warning, undercurl = true },
    SpellLocal = { sp = colors.hint, undercurl = true },
    SpellRare = { sp = colors.info, undercurl = true },

    -- Syntax highlighting
    Comment = { fg = colors.comment, italic = true },
    Constant = { fg = colors.magenta },
    String = { fg = colors.green },
    Character = { fg = colors.green },
    Number = { fg = colors.magenta },
    Boolean = { fg = colors.magenta },
    Float = { fg = colors.magenta },

    Identifier = { fg = colors.cyan },
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
    PreCondit = { fg = colors.yellow },

    Type = { fg = colors.yellow },
    StorageClass = { fg = colors.red },
    Structure = { fg = colors.yellow },
    Typedef = { fg = colors.yellow },

    Special = { fg = colors.cyan },
    SpecialChar = { fg = colors.cyan },
    Tag = { fg = colors.blue },
    Delimiter = { fg = colors.fg },
    SpecialComment = { fg = colors.cyan },
    Debug = { fg = colors.cyan },

    Underlined = { underline = true },
    Error = { fg = colors.error },
    Todo = { fg = colors.warning, bg = colors.bg_alt, bold = true },

    -- LSP highlights
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warning },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },

    DiagnosticUnderlineError = { sp = colors.error, undercurl = true },
    DiagnosticUnderlineWarn = { sp = colors.warning, undercurl = true },
    DiagnosticUnderlineInfo = { sp = colors.info, undercurl = true },
    DiagnosticUnderlineHint = { sp = colors.hint, undercurl = true },

    -- Tree-sitter highlights
    ["@variable"] = { fg = colors.fg },
    ["@variable.builtin"] = { fg = colors.magenta },
    ["@variable.parameter"] = { fg = colors.cyan },
    ["@variable.member"] = { fg = colors.cyan },

    ["@constant"] = { fg = colors.magenta },
    ["@constant.builtin"] = { fg = colors.magenta },
    ["@constant.macro"] = { fg = colors.yellow },

    ["@string"] = { fg = colors.green },
    ["@string.escape"] = { fg = colors.cyan },
    ["@string.special"] = { fg = colors.cyan },

    ["@character"] = { fg = colors.green },
    ["@character.special"] = { fg = colors.cyan },

    ["@number"] = { fg = colors.magenta },
    ["@boolean"] = { fg = colors.magenta },
    ["@float"] = { fg = colors.magenta },

    ["@function"] = { fg = colors.blue },
    ["@function.builtin"] = { fg = colors.blue },
    ["@function.macro"] = { fg = colors.yellow },
    ["@function.method"] = { fg = colors.blue },

    ["@constructor"] = { fg = colors.yellow },
    ["@operator"] = { fg = colors.fg },

    ["@keyword"] = { fg = colors.red },
    ["@keyword.function"] = { fg = colors.red },
    ["@keyword.operator"] = { fg = colors.red },
    ["@keyword.return"] = { fg = colors.red },
    ["@keyword.conditional"] = { fg = colors.red },
    ["@keyword.repeat"] = { fg = colors.red },
    ["@keyword.exception"] = { fg = colors.red },
    ["@keyword.import"] = { fg = colors.red },

    ["@type"] = { fg = colors.yellow },
    ["@type.builtin"] = { fg = colors.yellow },
    ["@type.definition"] = { fg = colors.yellow },

    ["@attribute"] = { fg = colors.cyan },
    ["@property"] = { fg = colors.cyan },

    ["@comment"] = { fg = colors.comment, italic = true },
    ["@comment.todo"] = { fg = colors.warning, bg = colors.bg_alt, bold = true },
    ["@comment.note"] = { fg = colors.info, bg = colors.bg_alt, bold = true },
    ["@comment.warning"] = { fg = colors.warning, bg = colors.bg_alt, bold = true },
    ["@comment.error"] = { fg = colors.error, bg = colors.bg_alt, bold = true },

    ["@punctuation.delimiter"] = { fg = colors.fg },
    ["@punctuation.bracket"] = { fg = colors.fg },
    ["@punctuation.special"] = { fg = colors.cyan },

    ["@tag"] = { fg = colors.red },
    ["@tag.attribute"] = { fg = colors.yellow },
    ["@tag.delimiter"] = { fg = colors.fg },

    -- Git highlights (for gitsigns, etc.)
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.yellow },
    GitSignsDelete = { fg = colors.red },

    -- Telescope highlights
    TelescopeNormal = { fg = colors.fg, bg = colors.bg_alt },
    TelescopeBorder = { fg = colors.border, bg = colors.bg_alt },
    TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_alt },
    TelescopePromptBorder = { fg = colors.border, bg = colors.bg_alt },
    TelescopePromptTitle = { fg = colors.blue, bg = colors.bg_alt, bold = true },
    TelescopePreviewTitle = { fg = colors.green, bg = colors.bg_alt, bold = true },
    TelescopeResultsTitle = { fg = colors.red, bg = colors.bg_alt, bold = true },
    TelescopeSelection = { fg = colors.fg, bg = colors.visual },
    TelescopeSelectionCaret = { fg = colors.blue },
    TelescopeMatching = { fg = colors.match, bold = true },

    -- Indent guides
    IndentBlanklineChar = { fg = colors.bg_alt },
    IndentBlanklineContextChar = { fg = colors.comment },

    -- Which-key
    WhichKey = { fg = colors.blue },
    WhichKeyGroup = { fg = colors.cyan },
    WhichKeyDesc = { fg = colors.fg },
    WhichKeySeperator = { fg = colors.comment },
    WhichKeyFloat = { bg = colors.bg_alt },
    WhichKeyBorder = { fg = colors.border, bg = colors.bg_alt },
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
  vim.g.terminal_color_5 = colors.magenta
  vim.g.terminal_color_6 = colors.cyan
  vim.g.terminal_color_7 = colors.white
  vim.g.terminal_color_8 = colors.bright_black
  vim.g.terminal_color_9 = colors.bright_red
  vim.g.terminal_color_10 = colors.bright_green
  vim.g.terminal_color_11 = colors.bright_yellow
  vim.g.terminal_color_12 = colors.bright_blue
  vim.g.terminal_color_13 = colors.bright_magenta
  vim.g.terminal_color_14 = colors.bright_cyan
  vim.g.terminal_color_15 = colors.bright_white
end

-- Export colors for other plugins (like your heirline config)
M.colors = colors

return M
