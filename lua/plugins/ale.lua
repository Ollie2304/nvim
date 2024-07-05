return {
	"dense-analysis/ale",
	config = function()
		-- TODO: Setup Ale
		local g = vim.g

		g.ale_ruby_rubocop_auto_correct_all = 1
		g.ale_fix_on_save = 1

		g.ale_fixers = {
			c = { "clang-format" },
		}

		g.ale_linters = {
			lua = { "lua_language_server" },
			c = { "gcc", "clang", "clangd" },
		}
	end,
}
