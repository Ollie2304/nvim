return {
	"ellisonleao/gruvbox.nvim",
	name = "gruvbox",
	priority = 1000,

	config = function()
		vim.cmd.colorscheme("gruvbox")
		vim.opt.background = "dark"
	end,
}
