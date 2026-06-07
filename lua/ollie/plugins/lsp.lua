local now_if_args, later = Config.now_if_args, Config.later
-- Tree-sitter  ===============================================================
now_if_args(function()
    local treesitter = require("nvim-treesitter")

    local ensure_installed = {
        "lua",
        "vimdoc",
        "python",
        "c",
        "markdown",
        "json",
        "yaml",
        "toml",
        "xml",
        "javascript",
        "typescript",
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
end)
-- Mason  =====================================================================
now_if_args(function()
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
            "lemminx",
            "tombi",
            "yamlls",
        },
    })
end)

now_if_args(function()
    require("mason-tool-installer").setup({
        ensure_installed = {
            "vimls",
            "lua_ls",
            "luacheck",
            "stylua",
            "markdownlint",
            "marksman",
            "mdformat",
            "json-lsp",
            "yamlls",
            "tombi",
            "lemminx",
            "xmlformatter",
            "ruff",
            "pyrefly",
            "biome",
            "prettier",
            "clangd",
            "clang-format",
        },
        auto_update = false,
        run_on_start = false,
    })
end)

-- Language servers  ==========================================================
now_if_args(function()
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
    -- vim.lsp.enable({
    --     see mason
    -- })
end)
-- Formatting  ================================================================
later(function()
    require("conform").setup({
        default_format_opts = {
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            markdown = { "mdformat", "markdownlint" },
            json = { "biome-check" },
            yaml = { "prettier" },
            toml = { "tombi" },
            xml = { "xmlformatter" },
            html = { "prettier" },
            css = { "biome-check" },
            javascript = { "biome-check" },
            typescript = { "biome-check" },
            c = { "clang-format" },
        },
    })
end)
