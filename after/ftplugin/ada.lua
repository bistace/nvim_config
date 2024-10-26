-- Remove these keybinds as they introduce input lag
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>aj", function() end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>al", function() end, { silent = true, buffer = bufnr })
