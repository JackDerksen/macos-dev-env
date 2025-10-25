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
        handlers = {
          -- Default handler for servers without a custom one
          function(server_name)
            if server_name ~= "lua_ls" then
              require("lspconfig")[server_name].setup({})
            end
          end,
          -- Custom handler for lua_ls (handled in config/lsp.lua)
          ["lua_ls"] = function() end,
        },
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
