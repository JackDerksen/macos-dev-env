return {
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "InsertEnter",
        config = function()
            local pairs = require("mini.pairs")

            pairs.setup({
                -- Define which pairs to auto-close
                modes = { insert = true, command = false, terminal = false },

                -- Custom mapping function to prevent pairing next to word characters
                mappings = {
                    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%w]', register = { cr = true } },
                    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%w]', register = { cr = true } },
                    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%w]', register = { cr = true } },

                    [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].', register = { cr = true } },
                    [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].', register = { cr = true } },
                    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].', register = { cr = true } },

                    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\][^%w]', register = { cr = true } },
                    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\][^%w]', register = { cr = true } },
                    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\][^%w]', register = { cr = true } },
                },
            })

            -- Enhanced <CR> mapping for auto-indenting between pairs
            local function cr_action()
                -- Check if we're between a pair
                local line = vim.api.nvim_get_current_line()
                local col = vim.api.nvim_win_get_cursor(0)[2]

                -- Get characters before and after cursor
                local char_before = col > 0 and line:sub(col, col) or ''
                local char_after = line:sub(col + 1, col + 1)

                -- Define matching pairs
                local pair_map = {
                    ['('] = ')',
                    ['['] = ']',
                    ['{'] = '}',
                    ['<'] = '>',
                    ['"'] = '"',
                    ["'"] = "'",
                    ['`'] = '`'
                }

                -- Check if cursor is between a matching pair
                if pair_map[char_before] == char_after then
                    -- Get current indentation
                    local indent = line:match('^%s*')
                    local use_tabs = vim.bo.expandtab == false
                    local indent_char = use_tabs and '\t' or (' '):rep(vim.bo.shiftwidth)

                    -- Split the line at the cursor position
                    local before = line:sub(1, col)
                    local after = line:sub(col + 1)

                    -- Create new lines with proper indentation
                    local new_line = indent .. indent_char
                    local closing_line = indent .. after

                    -- Replace current line and insert new lines
                    vim.api.nvim_set_current_line(before)
                    vim.api.nvim_buf_set_lines(0, vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1],
                        false, { new_line, closing_line })

                    -- Position cursor at end of the new indented line
                    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1] + 1, #new_line })

                    return
                end

                -- Default behavior - insert a newline with auto-indentation
                local bufnr = vim.api.nvim_get_current_buf()
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                row = row - 1 -- Convert to 0-indexed

                -- Split the current line at cursor
                local current_line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
                local before = current_line:sub(1, col)
                local after = current_line:sub(col + 1)

                -- Get indentation from current line
                local indent = current_line:match('^%s*')

                -- Replace current line and insert new line with indentation
                vim.api.nvim_buf_set_lines(bufnr, row, row + 1, false, { before, indent .. after })

                -- Move cursor to the beginning of the new line after indentation
                vim.api.nvim_win_set_cursor(0, { row + 2, #indent })
            end

            -- Map <CR> in insert mode
            vim.keymap.set('i', '<CR>', cr_action, {
                noremap = true,
                silent = true,
                desc = 'Smart CR with auto-indent between pairs'
            })
        end,
    },
    {
        "nvim-mini/mini.indentscope",
        version = "*",
        config = function()
            require("mini.indentscope").setup({
                symbol = '│',
            })
        end,
    }
}
