vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.fn.matchadd("errorMsg", [[\s\+$]])

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

 vim.cmd([[colorscheme modus]]) -- modus_operandi, modus_vivendi
-- vim.cmd([[colorscheme nope-g]])
-- vim.cmd([[colorscheme everforest]])
-- vim.cmd([[colorscheme cyberdream]])
-- vim.cmd([[colorscheme flexoki]])
