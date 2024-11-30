return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        init = function()
            -- Reserve a space in the gutter
            vim.opt.signcolumn = "yes"
        end,
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config

            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "jedi_language_server",
                    "lua_ls",
                    "rust_analyzer",
                },
                config = function()
                    require("lsp-config").clangd.setup({
                        cmd = {
                            "clangd",
                            "--fallback-style=webkit"
                        }
                    })
                end,
                handlers = {
                    function(server_name, settings)
                        local M = {}

                        require("lspconfig")[server_name].setup({
                            -- https://neovim.io/doc/user/lsp.html#lsp-api
                            handlers = {
                                -- When the LSP is ready, enable inlay hint for existing bufnr again.
                                -- Learn from rust-tools.nvim
                                ["experimental/serverStatus"] = function(_, result, ctx, _)
                                    if result.quiescent and not M.ran_once then
                                        for _, bufnr in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
                                            -- First, toggle disable because bufstate.applied
                                            -- prevents vim.lsp.inlay_hint(bufnr, true) from refreshing.
                                            -- Therefore, we need to clear bufstate.applied.
                                            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                                            -- toggle enable
                                            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                                        end
                                        M.ran_once = true
                                    end
                                end,
                            },
                            -- If the LSP is not ready, the inlay hint character is empty,
                            -- this usually occurs during the first attach.
                            on_attach = function(client, bufnr)
                                if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                                end
                            end,
                            capabilities = require("cmp_nvim_lsp").default_capabilities(),
                            settings = settings,
                        })
                    end,
                },
            })
        end,
    },
}
