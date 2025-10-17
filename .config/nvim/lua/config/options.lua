-- Caching options for better performance
vim.opt.shadafile = vim.fn.stdpath("state") .. "/shada/main.shada"
vim.opt.updatetime = 250 -- Faster CursorHold events
vim.opt.timeout = true
vim.opt.timeoutlen = 300

vim.opt.guicursor = ""
vim.opt.cursorline = false

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "81"
vim.opt.pumblend = 0

vim.o.termguicolors = true

vim.opt.fillchars = { eob = " " }
