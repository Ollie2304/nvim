return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = "Update", group = "@property", action = "Lazy update", key = "u" },
						{ desc = "Sync", group = "@property", action = "Lazy sync", key = "s" },
						{ desc = "Files", group = "Label", action = "Telescope find_files", key = "sf" },
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
