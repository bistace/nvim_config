return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({})
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {})

        local Terminal      = require('toggleterm.terminal').Terminal
        local floating_term = Terminal:new({
            direction = "float",
            float_opts = {
                border = "double",
            },
        })

        function _floating_term_toggle()
            floating_term:toggle()
        end

        function _floating_term_exit()
            floating_term:toggle()
            floating_term:shutdown()
        end

        vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>lua _floating_term_toggle()<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua _floating_term_exit()<CR>",
            { noremap = true, silent = true })
    end
}
