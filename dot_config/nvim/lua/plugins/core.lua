return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
    {
        "fei6409/log-highlight.nvim",
        config = function()
            require("log-highlight").setup({})
        end,
    },
}
