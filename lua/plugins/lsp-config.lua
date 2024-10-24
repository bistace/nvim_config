return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls"
        }
      })
    end
  },
  -- Ada
  "TamaMcGlinn/nvim-lsp-gpr-selector",
  "TamaMcGlinn/nvim-lspconfig-ada",
  -- Global LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})

      lspconfig.als.setup({
        on_init = require("gpr_selector").als_on_init,
      })
    end
  },
}
