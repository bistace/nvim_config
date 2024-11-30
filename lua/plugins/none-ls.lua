return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
            },
        })

        vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, {})
    end,
}
