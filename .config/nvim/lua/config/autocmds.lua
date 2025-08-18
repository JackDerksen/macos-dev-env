-- Create autocommand groups based on the passed name
local function augroup(name)
  return vim.api.nvim_create_augroup("nvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Auto-open Oil when Neovim starts with no arguments or with a directory
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = augroup("oil_startup"),
  callback = function()
    -- Only when no arguments (empty buffer) or with a directory
    if vim.fn.argc() == 0 or vim.fn.isdirectory(vim.fn.argv(0)) > 0 then
      -- Close any empty buffers created on startup
      vim.schedule(function()
        -- For each buffer
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          -- If empty and loaded
          if vim.api.nvim_buf_get_name(bufnr) == "" and vim.api.nvim_buf_is_loaded(bufnr) then
            -- Delete it
            vim.api.nvim_buf_delete(bufnr, { force = true })
          end
        end
        -- Open oil
        require("oil").open()
      end)
    end
  end,
  nested = true,
})
