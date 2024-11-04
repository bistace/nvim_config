return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                },
            })
        end,
    },

    -- Ada
    "TamaMcGlinn/nvim-lsp-gpr-selector",
    "TamaMcGlinn/nvim-lspconfig-ada",

    -- D
    -- {
    --     "Pure-D/serve-d",
    --     lazy = false,
    -- },

    -- Rust
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
    },

    -- Global LSP config
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")

            lspconfig.als.setup({
                capabilities = capabilities,
                on_init = require("gpr_selector").als_on_init,
            })

            lspconfig.lua_ls.setup({})

            lspconfig.pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            -- formatter options
                            black = { enabled = true },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },
                            -- linter options
                            pylint = { enabled = true, executable = "pylint" },
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            -- type checker
                            pylsp_mypy = { enabled = true },
                            -- auto-completion options
                            jedi_completion = { fuzzy = true },
                            -- import sorting
                            pyls_isort = { enabled = true },
                        },
                    },
                },
                flags = {
                    debounce_text_changes = 200,
                },
                capabilities = capabilities,
            })

            -- lspconfig.serve_d.setup({
            --     dfmt = {
            --         braceStyle = "stroustrup",
            --     },
            -- })
        end,
    },
}
