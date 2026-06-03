local gh = function(x)
    return "https://github.com/" .. x
end
local add = vim.pack.add

add({
    gh("nyoom-engineering/oxocarbon.nvim"),
    gh("nvim-mini/mini.nvim"),
    gh("rafamadriz/friendly-snippets"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("nvim-treesitter/nvim-treesitter-textobjects"),
    gh("neovim/nvim-lspconfig"),
    gh("mason-org/mason.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("stevearc/conform.nvim"),
})

require("ollie.plugins.mini")
require("ollie.plugins.lsp")
