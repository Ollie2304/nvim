local now, now_if_args, later = Config.now, Config.now_if_args, Config.later
-- Text editing  ==============================================================

-- Extra
later(function()
    require("mini.extra").setup()
end)

-- mini.ai - Extend and create a/i textobjects
later(function()
    local MiniAi = require("mini.ai")
    local MiniExtra = require("mini.extra")
    MiniAi.setup({
        custom_textobjects = {
            -- aB / iB - arround/inside whole buffer
            B = MiniExtra.gen_ai_spec.buffer(),
            -- tree-sitter - around/inside func definition
            F = MiniAi.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        },
        -- only try to search covering textobject
        search_method = "cover",
    })
end)

-- mini.align - Align text interactively
later(function()
    require("mini.align").setup()
end)

-- mini.comment - Comment lines
later(function()
    require("mini.comment").setup()
end)

-- mini.completion - Completion and signature help
now_if_args(function()
    local MiniCompletion = require("mini.completion")
    -- don't show text suggestions & show snippets last
    local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
    local process_items = function(items, base)
        return MiniCompletion.default_process_items(items, base, process_items_opts)
    end
    MiniCompletion.setup({
        lsp_completion = {
            source_func = "omnifunc",
            auto_setup = false,
            process_items = process_items,
        },
    })
    -- set omnifunc for completion when needed
    local on_attach = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = on_attach,
        desc = "Set 'omnifunc'",
    })

    -- advertise mini.completion to lsp servers
    vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

-- mini.keymap - Special key mappings
later(function()
    require("mini.keymap").setup()
    local MiniKeymap = require("mini.keymap")
    -- mini.completion navigation with <Tab> / <S-Tab>
    MiniKeymap.map_multistep("i", "<Tab>", { "pmenu_next" })
    MiniKeymap.map_multistep("i", "<S-Tab>", { "pmenu_prev" })
    -- on <CR> try to accept current completion item
    MiniKeymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
    -- on <BS> try to account for pairs from mini.pairs
    MiniKeymap.map_multistep("i", "<BS>", { "minipairs_bs" })
end)

-- mini.move - Move any slection in any direction
later(function()
    require("mini.move").setup()
end)

-- mini.operators - Text edit operators
later(function()
    require("mini.operators").setup()
end)

-- mini.pairs - Autopairs
later(function()
    require("mini.pairs").setup({
        modes = {
            command = true,
        },
    })
end)

-- mini.snippets - Manage and expand snippets
later(function()
    -- def language patterns for friendly-snippets
    local latex_patterns = { "latex/**/*.json", "**/latex.json" }
    local lang_patterns = {
        tex = latex_patterns,
        plaintex = latex_patterns,
        -- recognize special injected lang of markdown tree-sitter parser
        markdown_inline = { "markdown.json" },
    }
    local MiniSnippets = require("mini.snippets")
    local config_path = vim.fn.stdpath("config")
    MiniSnippets.setup({
        snippets = {
            -- load snippets/global.json
            MiniSnippets.gen_loader.from_file(config_path .. "/snippets/global.json"),
            -- load from snippets/ directory
            MiniSnippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
        },
    })
    -- expose snippets to mini completion
    MiniSnippets.start_lsp_server({ match = false })
end)

-- mini.splitjoin - Split and join arguments
later(function()
    require("mini.splitjoin").setup()
end)

-- mini.surround - Surround actions
later(function()
    require("mini.surround").setup()
end)

-- General  ===================================================================

-- mini.basics - Common configuration presets
now(function()
    require("mini.basics").setup({
        options = { basic = false },
        mappings = {
            basics = true,
            window = true,
            move_with_alt = true,
        },
    })
end)

-- mini.bracketed - Go forward/backward with square brackets
later(function()
    require("mini.bracketed").setup()
end)

-- mini.bufremove - Remove buffers
later(function()
    require("mini.bufremove").setup()
end)

-- mini.clue - Show next key clues
later(function()
    local MiniClue = require("mini.clue")
    MiniClue.setup({
        window = {
            delay = 0,
        },
        clues = {
            { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
            { mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
            { mode = "n", keys = "<Leader>f", desc = "+Find" },
            { mode = "n", keys = "<Leader>g", desc = "+Git" },
            { mode = "n", keys = "<Leader>l", desc = "+Language" },
            { mode = "n", keys = "<Leader>o", desc = "+Other" },
            { mode = "n", keys = "<Leader>s", desc = "+Session" },
            { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
            { mode = "n", keys = "<Leader>v", desc = "+Visits" },

            { mode = "x", keys = "<Leader>g", desc = "+Git" },
            { mode = "x", keys = "<Leader>l", desc = "+Language" },

            MiniClue.gen_clues.square_brackets(),
            MiniClue.gen_clues.builtin_completion(),
            MiniClue.gen_clues.g(),
            MiniClue.gen_clues.marks(),
            MiniClue.gen_clues.registers(),
            MiniClue.gen_clues.windows({ submode_resize = true }),
            MiniClue.gen_clues.z(),
        },

        triggers = {
            { mode = { "n", "x" }, keys = "<Leader>" }, -- Leader
            { mode = "n", keys = "\\" }, -- mini.basics
            { mode = "n", keys = "[" }, -- mini.bracketed
            { mode = "n", keys = "]" },
            { mode = "i", keys = "<C-x>" }, -- Built-in completion
            { mode = { "n", "x" }, keys = "g" }, -- g
            { mode = { "n", "x" }, keys = "'" }, -- Marks
            { mode = { "n", "x" }, keys = "`" },
            { mode = { "n", "x" }, keys = '"' }, -- Registers
            { mode = { "i", "c" }, keys = "<C-r>" },
            { mode = "n", keys = "<C-w>" }, -- Window
            { mode = { "n", "x" }, keys = "z" }, -- z
            { mode = { "n", "x" }, keys = "s" }, -- s (mini.surround)
        },
    })
end)

-- mini.cmdline - Command line tweaks
later(function()
    require("mini.cmdline").setup()
end)

-- mini.Diff - Work with diff unks
later(function()
    require("mini.diff").setup()
end)

-- Files
now_if_args(function()
    require("mini.files").setup({
        windows = {
            preview = true,
        },
    })
end)

-- Git
later(function()
    require("mini.git").setup()
end)

-- Jump
later(function()
    require("mini.jump").setup()
end)

-- Jump2D
later(function()
    require("mini.jump2d").setup()
end)

-- Misc
now_if_args(function()
    local MiniMisc = require("mini.misc")
    MiniMisc.setup()
    -- change cwd based on current file path
    MiniMisc.setup_auto_root()
    -- restore cursor to last position
    MiniMisc.setup_restore_cursor()
    -- sync term bg with nvims bg
    MiniMisc.setup_termbg_sync()
end)

-- Pick
later(function()
    require("mini.pick").setup()
end)

-- Sessions
now(function()
    require("mini.sessions").setup()
end)

-- Visits
later(function()
    require("mini.visits").setup()
end)

-- Input
now_if_args(function()
    require("mini.input").setup()
end)

-- Appearance  ================================================================

-- Animate
later(function()
    local MiniAnimate = require("mini.animate")
    MiniAnimate.setup({
        cursor = {
            enable = true,
            timing = MiniAnimate.gen_timing.linear({ duration = 15, unit = "total" }),
            path = MiniAnimate.gen_path.line({
                predicate = function()
                    return true
                end,
                max_output_steps = 4000,
            }),
        },
        scroll = {
            enable = false,
        },
        resize = {
            enable = false,
        },
        open = {
            enable = false,
        },
        close = {
            enable = false,
        },
    })
end)

-- mini.cursorword - Autohighlight word under cursor
later(function()
    require("mini.cursorword").setup({
        delay = 0,
    })
end)

-- mini.hipatterns - Highlight patterns in text
later(function()
    local HiPatterns = require("mini.hipatterns")
    local MiniExtra = require("mini.extra")
    local HiWords = MiniExtra.gen_highlighter.words
    HiPatterns.setup({
        highlighters = {
            fixme = HiWords({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
            hack = HiWords({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
            todo = HiWords({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
            note = HiWords({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

            hex_color = HiPatterns.gen_highlighter.hex_color(),
        },
    })
end)

-- mini.icons - Icon provider
now(function()
    local MiniIcons = require("mini.icons")
    MiniIcons.setup()
    -- enable icons for autocomplete
    later(MiniIcons.tweak_lsp_kind)
    -- for plugins without mini.icons support
    later(MiniIcons.mock_nvim_web_devicons)
end)

-- mini.identscope - Visualize and work with indent scope
later(function()
    require("mini.indentscope").setup({
        draw = {
            delay = 0,
        },
    })
end)

-- mini.notify - Show notifications
now(function()
    require("mini.notify").setup({
        content = {
            format = function(notif)
                return notif.msg
            end,
        },
    })
end)

-- mini.starter Start screen
now(function()
    local MiniStarter = require("mini.starter")
    MiniStarter.setup({
        evalutate_single = true,
        items = {
            MiniStarter.sections.pick(),
            MiniStarter.sections.builtin_actions(),
            MiniStarter.sections.sessions(5, true),
            MiniStarter.sections.recent_files(3, false),
            MiniStarter.sections.recent_files(3, true),
        },
    })
end)

-- mini.statusline - Statusline
now(function()
    require("mini.statusline").setup()
end)

-- mini.statuscolumn - Statuscolumn
now_if_args(function()
    require("mini.statuscolumn").setup()
end)

-- mini.trailspace - Trailspace (highlight and remove)
later(function()
    require("mini.trailspace").setup()
end)
