-- Tree-sitter  ===============================================================
local treesitter = require("nvim-treesitter")

local ensure_installed = {
    "lua",
    "vimdoc",
    "markdown",
    "python",
    "c",
    "json",
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
            return
        end

        local ok_add = pcall(vim.treesitter.language.add, lang)
        if not ok_add then
            return
        end

        pcall(vim.treesitter.start, buf, lang)
    end,
})
-- Language servers  ==========================================================
vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})
vim.lsp.enable({
    "vimls",
    "lua_ls",
    "stylua",
    "pyrefly",
    "ruff",
    "marksman",
    "mdformat",
    "markdownlint",
    "biome",
    "json-lsp",
})

-- Formatting  ================================================================
require("conform").setup({
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        markdown = { "mdformat", "markdownlint"  },
        json = { "biome" },
    },
})

-- Mason  =====================================================================
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "vimls",
        "lua_ls",
        "stylua",
        "clangd",
        "pyrefly",
        "ruff",
        "marksman",
        "biome",
        "jsonls",
    }
})
