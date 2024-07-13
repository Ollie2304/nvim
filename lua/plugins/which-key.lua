return {
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>c", desc = "[C]ode" },
				{ "<leader>d", desc = "[D]ebug" },
				{ "<leader>dt", desc = "[T]rouble" },
				{ "<leader>r", desc = "[R]ename" },
				{ "<leader>s", desc = "[S]earch" },
				{ "<leader>st", desc = "[S]earch [T]odo" },
				{ "<leader>w", desc = "[W]orkspace" },
				{ "<leader>t", desc = "[T]oggle" },
				{ "<leader>gh", desc = "[G]it [H]unk" },
				{ "<leader>g", desc = "[G]it" },
				{ "<leader>h", desc = "[H]arpoon" },
			})
		end,
	},
}
