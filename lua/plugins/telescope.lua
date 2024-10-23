return { 
  "nvim-telescope/telescope.nvim", tag = "0.1.8", 
  dependencies = { "nvim-lua/plenary.nvim" }, 
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>b", builtin.find_files, {})
    -- Make sure that ripgrep is installed!
    -- https://github.com/BurntSushi/ripgrep
    vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
  end

}

