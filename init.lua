_G.Config = {}

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local misc = require("mini.misc")
Config.now = function(f) misc.safely("now", f) end
Config.later = function(f) misc.safely("later", f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f) misc.safely("event:" .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

require("vim._core.ui2").enable({})

require("ollie.pack")
require("ollie.config")
require("colorscheme")

