return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "[G]it" })
		vim.keymap.set("n", "<leader>gs", function()
			vim.cmd("Git status")
		end, { desc = "[Git] [S]tatus" })
		vim.keymap.set("n", "<leader>ga", function()
			vim.cmd("Git add .")
		end, { desc = "[G]it [A]dd" })
		vim.keymap.set("n", "<leader>gC", function()
			vim.cmd("Git commit")
		end, { desc = "[G]it [C]ommit" })
		vim.keymap.set("n", "<leader>gP", function()
			vim.cmd("Git push")
		end, { desc = "[Git] [P]ush" })
		vim.keymap.set("n", "<leader>gp", function()
			vim.cmd("Git pull")
		end, { desc = "[Git] [p]ull" })
	end,
}
