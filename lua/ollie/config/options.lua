-- stylua: ignore start
-- General ====================================================================
local home = os.getenv("HOME") or os.getenv("USERPROFILE") -- home directory


vim.o.mouse = "a" -- enable mouse

vim.o.backup      = false -- disable backups
vim.o.swapfile    = false -- disable swapfile
vim.o.undofile    = true  -- persistent undo
vim.o.undodir     = home .. "/.vim/undodir" -- undo directory


vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- limit shada file

vim.o.updatetime  = 50  -- swapfile write delay
vim.o.timeoutlen  = 1000 -- mapped sequence timeout
vim.o.ttimeoutlen = 0  -- key code timeout

vim.o.switchbuf  = "usetab" -- use open buffers on switching

-- enable all filetype plugins and syntax
vim.cmd("filetype plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then vim.cmd("syntax enable") end

-- UI =========================================================================
vim.o.termguicolors  = true  -- true color support
vim.o.guicursor = ""

vim.o.number         = true  -- line numbers
vim.o.relativenumber = true  -- relative numbers
vim.o.scrolloff      = 10    -- lines above/below cursor
vim.o.sidescrolloff  = 10    -- columns left/right of cursor
vim.o.ruler          = false -- hide cursor ruler
vim.o.colorcolumn    = "80"    -- color column marker
vim.o.signcolumn     = "yes" -- always show sign column
vim.o.showmode       = true  -- hide mode indicator
vim.o.cmdheight      = 0     -- hide cmd line
vim.o.laststatus     = 3     -- only show 1 status line
vim.o.cursorline     = true  -- highlight cursor line
vim.o.cursorlineopt  = "screenline,number" -- cursor line per screen line

vim.o.wrap           = false     -- disable line wrap
vim.olinebreak       = true      -- wrap lines at breakat
vim.o.breakindent    = true      -- indent wrapped lines
vim.o.breakindentopt = "list:-1" -- add paddings to lists

vim.o.shortmess = "CFOSWaco"     -- built-in completion messages
vim.o.fillchars = "eob: ,fold:╌" -- eob & fold chars
vim.o.list      = true           -- show whitespace and tabs
vim.o.listchars = "extends:…,nbsp:␣,precedes:…,tab:> " -- list chars

vim.o.pumborder   = "single" -- popup menu border
vim.o.pumheight   = 10       -- popup menu height
vim.o.pummaxwidth = 100      -- popup menu max width
vim.o.pumblend    = 10       -- popup transparency
vim.o.winborder   = "single" -- floating window border
vim.o.splitbelow  = true     -- horizontal splits below
vim.o.splitright  = true     -- vertical splits right
vim.o.splitkeep   = "screen" -- reduce scroll

vim.o.foldlevel   = 10     -- start with folds open
vim.o.foldnestmax = 10     -- max number of nested folds
vim.o.foldtext    = ""     -- show text under fold
vim.o.foldmethod  = "expr" -- fold method
vim.o.foldexpr    = "v:lua.vim.treesitter.foldexpr()" -- treesitter folding

vim.g.netrw_banner = 0

-- Editor =====================================================================
vim.o.tabstop     = 4    -- tab width
vim.o.shiftwidth  = 4    -- indent width
vim.o.softtabstop = 4    -- soft tab stops 
vim.o.expandtab   = true -- use spaces instead of tabs
vim.o.smartindent = true -- smart autoindent 
vim.o.autoindent  = true -- copy indent on new line

vim.o.ignorecase = true    -- case-insensitive search
vim.o.smartcase  = true    -- case-sensitive if uppercase
vim.o.infercase  = true    -- infer case
vim.o.hlsearch   = true    -- highlight search matches
vim.o.incsearch  = true    -- incremental search
vim.o.inccommand = "split" -- split window incremental

vim.o.spelloptions  = "camel"  -- camelCase words as separate words
vim.o.formatoptions = "rqnl1j" -- comment editing
vim.o.virtualedit   = "block"  -- allow going past eol in blockwise mode

vim.o.iskeyword = "@,48-57,_,192-255,-" -- treat - as word textobject part

-- start of numbered list
-- at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- built-in completion
vim.o.complete        = ".,w,b,kspell"                  -- use less sources
vim.o.completeopt     = "menuone,noselect,fuzzy,nosort" -- completion menu
vim.o.completetimeout = 100                             -- limit sources delay
vim.opt.shortmess:append("c")                           -- hide completion messages from CL

-- stylua: ignore end
