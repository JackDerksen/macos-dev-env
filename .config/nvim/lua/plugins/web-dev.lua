return {
  {
    -- HTML/CSS/JSON language servers
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  -- Emmet support for faster HTML/CSS authoring
  {
    "mattn/emmet-vim",
    event = "InsertEnter",
    ft = {
      "html", "css", "scss", "javascript", "javascriptreact",
      "typescript", "typescriptreact", "markdown"
    },
  },
  -- Auto tag closing for JSX/HTML
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = {
      "html", "xml", "javascript", "javascriptreact",
      "typescript", "typescriptreact", "markdown"
    },
    config = function()
      require("nvim-ts-autotag").setup({
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      })
    end,
  },
}
