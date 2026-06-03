-- Text editing  ==============================================================

-- mini.ai - Extend and create a/i textobjects
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

-- mini.align - Align text interactively
require("mini.align").setup()

-- mini.comment - Comment lines
require("mini.comment").setup()

-- mini.completion - Completion and signature help
require("mini.completion").setup({
    lsp_completion = {
        auto_setup = true,
    },
})

-- mini.keymap - Special key mappings
require("mini.keymap").setup()
local MiniKeymap = require("mini.keymap")
-- mini.completion navigation with <Tab> / <S-Tab>
MiniKeymap.map_multistep("i", "<Tab>", { "pmenu_next" })
MiniKeymap.map_multistep("i", "<S-Tab>", { "pmenu_prev" })
-- on <CR> try to accept current completion item
MiniKeymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
-- on <BS> try to account for pairs from mini.pairs
MiniKeymap.map_multistep("i", "<BS>", { "minipairs_bs" })

-- mini.move - Move any slection in any direction
require("mini.move").setup()

-- mini.operators - Text edit operators
require("mini.operators").setup()

-- mini.pairs - Autopairs
require("mini.pairs").setup({
    modes = {
        command = true,
    },
})

-- mini.snippets - Manage and expand snippets
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
MiniSnippets.start_lsp_server({ match = false }) -- expose snippets to mini completion

-- mini.splitjoin - Split and join arguments
require("mini.splitjoin").setup()

-- mini.surround - Surround actions
require("mini.surround").setup()

-- General  ===================================================================

-- mini.basics - Common configuration presets
require("mini.basics").setup({
    options = { basic = false },
    mappings = {
        basics = true,
        window = true,
        move_with_alt = true,
    },
})

-- mini.bracketed - Go forward/backward with square brackets
require("mini.bracketed").setup()

-- mini.bufremove - Remove buffers
require("mini.bufremove").setup()

-- mini.clue - Show next key clues
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
        { mode = "n", keys = "<Leader>m", desc = "+Map" },
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

-- mini.cmdline - Command line tweaks
require("mini.cmdline").setup()

-- mini.Diff - Work with diff unks
require("mini.diff").setup()

-- Extra
MiniExtra.setup()

-- Files
require("mini.files").setup({
    windows = {
        preview = true,
    },
})

-- Git
require("mini.git").setup()

-- Jump
require("mini.jump").setup()

-- Jump2D
require("mini.jump2d").setup()

-- Misc
local MiniMisc = require("mini.misc")
MiniMisc.setup()
-- change cwd based on current file path
MiniMisc.setup_auto_root()
-- restore cursor to last position
MiniMisc.setup_restore_cursor()
-- sync term bg with nvims bg
MiniMisc.setup_termbg_sync()

-- Pick
require("mini.pick").setup()

-- Sessions
require("mini.sessions").setup()

-- Visits
require("mini.visits").setup()

-- Appearance  ================================================================

-- Animate
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

-- mini.cursorword - Autohighlight word under cursor
require("mini.cursorword").setup({
    delay = 0,
})

-- mini.hipatterns - Highlight patterns in text
local HiPatterns = require("mini.hipatterns")
HiPatterns.setup({
    highlighters = {
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        hex_color = HiPatterns.gen_highlighter.hex_color(),
    },
})

-- mini.icons - Icon provider
local MiniIcons = require("mini.icons")
MiniIcons.setup()
-- enable icons for autocomplete
MiniMisc.safely("later", function()
    MiniIcons.tweak_lsp_kind()
end)

-- mini.identscope - Visualize and work with indent scope
require("mini.indentscope").setup({
    draw = {
        delay = 0,
    },
})

-- mini.notify - Show notifications
require("mini.notify").setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

-- mini.starter Start screen
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

-- mini.statusline - Statusline
require("mini.statusline").setup()

-- mini.tabline Tabline
require("mini.tabline").setup()

-- mini.trailspace - Trailspace (highlight and remove)
require("mini.trailspace").setup()
