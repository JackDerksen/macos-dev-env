return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "clangd",
          "pylsp",
          "ts_ls",
          "eslint",
          "html",
          "cssls",
          "jsonls",
          "tailwindcss",
        },
        automatic_installation = true,
      })

      -- Initialize the LSP configuration
      require("config.lsp").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },
}
