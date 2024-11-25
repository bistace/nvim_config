return {
    "nuvic/flexoki-nvim",
    name = "flexoki",
    config = function()
        require("flexoki").setup({
            variant = "dawn", -- auto, moon, or dawn
        })
    end
}
