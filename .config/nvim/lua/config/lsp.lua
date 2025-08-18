-- LSP configuration module
local M = {}

-- Setup LSP keymaps for a buffer
function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
  end

  -- Keymaps
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
  map("n", "gr", vim.lsp.buf.references, "Goto References")
  map("n", "gt", vim.lsp.buf.type_definition, "Type Definition")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")
  map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List Workspace Folders")
  map("n", "<leader>f", function()
    -- Try to use conform.nvim for formatting if available
    local has_conform, conform = pcall(require, "conform")
    if has_conform then
      conform.format({ async = true, lsp_fallback = true })
    else
      vim.lsp.buf.format({ async = true })
    end
  end, "Format")

  -- Set autocommands conditional on server capabilities
  if client.server_capabilities.documentHighlightProvider then
    local highlight_group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = highlight_group,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = highlight_group,
    })
  end

  -- Disable formatting for ts_ls if we're using Prettier with conform.nvim
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

-- Setup LSP servers
function M.setup()
  -- Configure diagnostics
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    severity_sort = true,
  })

  -- Set diagnostic signs
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = "󰍉 ",
    Info = " ",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
  end

  -- Setup LSP handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  -- Get cmp capabilities if available
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if has_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  -- Enable HTML tag auto-completion
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Create a special capabilities object for clangd
  local clangd_capabilities = vim.deepcopy(capabilities)
  clangd_capabilities.offsetEncoding = { "utf-16" }

  -- LSP server configurations
  local lspconfig = require("lspconfig")

  -- Lua LSP
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })

  -- C/C++ LSP
  lspconfig.clangd.setup({
    capabilities = clangd_capabilities,
    on_attach = M.on_attach,
    cmd = {
      "clangd",
      "--header-insertion=never",
      "--clang-tidy",
    },
  })

  -- Rust LSP
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  })

  -- Python LSP
  lspconfig.pylsp.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            maxLineLength = 100,
          },
        },
      },
    },
  })

  -- TypeScript/JavaScript LSP (ts_ls)
  lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
    root_dir = require("lspconfig.util").root_pattern(
      "tsconfig.json",
      "jsconfig.json",
      "package.json"
    ),
  })

  -- HTML LSP
  lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    filetypes = { "html", "javascriptreact", "typescriptreact" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      },
      provideFormatter = true,
    },
  })

  -- CSS LSP
  lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
  })

  -- JSON LSP
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      json = {
        -- Try to use schemastore if available, otherwise use defaults
        schemas = function()
          local has_schemastore, schemastore = pcall(require, 'schemastore')
          if has_schemastore then
            return schemastore.json.schemas()
          else
            -- Fallback to basic schemas
            return {
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json"
              },
              {
                fileMatch = { "tsconfig.json", "tsconfig.*.json" },
                url = "https://json.schemastore.org/tsconfig.json"
              },
              {
                fileMatch = { ".eslintrc.json", ".eslintrc" },
                url = "https://json.schemastore.org/eslintrc.json"
              }
            }
          end
        end,
        validate = { enable = true }
      }
    }
  })

  -- TailwindCSS LSP
  pcall(function()
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      on_attach = M.on_attach,
      filetypes = {
        "html", "css", "scss", "javascript", "javascriptreact",
        "typescript", "typescriptreact"
      },
    })
  end)

  -- ESLint LSP
  lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- Call the common on_attach function
      M.on_attach(client, bufnr)

      -- Create an autocommand to run ESLint on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          -- Try to fix ESLint issues on save
          vim.cmd("EslintFixAll")
        end,
      })
    end,
    settings = {
      packageManager = "npm",
      workingDirectories = { { mode = "auto" } },
    },
    root_dir = require("lspconfig.util").root_pattern(
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
      "package.json"
    ),
  })
end

return M
