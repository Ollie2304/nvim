-- enable relative/line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- set split direction
vim.opt.splitbelow = true
vim.opt.splitright = true

-- set line wrapping
vim.opt.wrap = false

-- set the number of spaces a tab equals
vim.opt.tabstop = 4
-- set the number of spaces inserted when pressing tab
vim.opt.softtabstop = 4
-- set the number of spaces used for autoindentation
vim.opt.shiftwidth = 4
-- insert spaces instead of tabs
vim.opt.expandtab = true

-- auto indent when starting new line
vim.opt.smartindent = true

-- sync clipboard with system clipboard
-- vim.opt.clipboard = "unnamedplus"

-- centre cursor when scrolling
vim.opt.scrolloff = 999

-- allow the cursor to be placed where there are no characters
vim.opt.virtualedit = "block"

-- show text replacement in split window
vim.opt.inccommand = "split"

-- show where the search pattern, as it was so far matches
vim.opt.incsearch = true

-- ignore case when typing commands
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- enable 24-bit colour support
vim.opt.termguicolors = true

-- always show sign column
vim.opt.signcolumn = "yes"

-- millisconds if nothing is typed till swap is written to disk
vim.opt.updatetime = 50

-- set nerd font
vim.g.have_nerd_font = true

-- every wrapped line will continue visually indented
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- decrease mapped sequence wait time / which-key popup
vim.opt.timeoutlen = 300

-- display certain whitespace chars
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- set highlight line cursor is on
vim.opt.cursorline = true

-- don't show mode
vim.opt.showmode = false

-- highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20"
