return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/colorschemes/0x96f",
    name = "0x96f",
    lazy = false,
    priority = 1000,
    config = function()
      -- Load the colorscheme
      require("colorschemes.0x96f").setup()
    end,
  }
}
