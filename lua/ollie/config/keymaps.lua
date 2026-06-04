-- map <Space> to <Leader>
vim.g.mapleader = " "

-- Helpers ====================================================================
local nmap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local vmap = function(lhs, rhs, desc)
    vim.keymap.set("v", lhs, rhs, { desc = desc })
end
local xmap = function(lhs, rhs, desc)
    vim.keymap.set("x", lhs, rhs, { desc = desc })
end

local nmap_leader = function(suffix, rhs, desc)
    vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
    vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end

local MiniExtra = require("mini.extra")

-- stylua: ignore start
-- General  ===================================================================
-- keep cursor still when using "J"
nmap("J", "mzJ`z`")

-- keep centered when half page jumping
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

-- keep centered when moving through search terms
nmap("n", "nzzzv")
nmap("N", "Nzzzv")

-- clear search highligh on <Esc>
nmap("<Esc>", ":nohlsearch<CR>")

-- paste linewise before/after current line
nmap("[p", '<Cmd>exe "iput! " . v:register<CR>', "Paste Above")
nmap("]p", '<Cmd>exe "iput "  . v:register<CR>', "Paste Below")

-- native undotree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Undotree" })

-- mappings for swapping adjacent arguments
vim.keymap.set("n", "(", "gxiagxila", { remap = true, desc = "Swap arg left" })
vim.keymap.set("n", ")", "gxiagxina", { remap = true, desc = "Swap arg right" })

-- Buffer  ====================================================================
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

nmap_leader("ba", "<Cmd>b#<CR>",                                 "Alternate")
nmap_leader("bd", "<Cmd>lua MiniBufremove.delete()<CR>",         "Delete")
nmap_leader("bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>",  "Delete!")
nmap_leader("bs", new_scratch_buffer,                            "Scratch")
nmap_leader("bw", "<Cmd>lua MiniBufremove.wipeout()<CR>",        "Wipeout")
nmap_leader("bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", "Wipeout!")

-- Explore  ===================================================================
local explore_dir = "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>"
local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and "cclose" or "copen")
end
local explore_locations = function()
  vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and "lclose" or "lopen")
end

nmap_leader("ee", "<Cmd>lua MiniFiles.open()<CR>","Explorer")
nmap_leader("ed", explore_dir, "Directory")
nmap_leader("en", "<Cmd>lua MiniNotify.show_history()<CR>", "Notifications")
nmap_leader("eq", explore_quickfix, "Quickfix list")
nmap_leader("eQ", explore_locations, "Location list")

-- Fuzzy Find  ================================================================
local pick_added_hunks_buf = "<Cmd>Pick git_hunks path='%' scope='staged'<CR>"
local pick_workspace_symbols_live = "<Cmd>Pick lsp scope='workspace_symbol_live'<CR>"

nmap_leader("f/", "<Cmd>Pick history scope='/'<CR>",            "'/' history")
nmap_leader("f:", "<Cmd>Pick history scope=':'<CR>",            "':' history")
nmap_leader("fa", "<Cmd>Pick git_hunks scope='staged'<CR>",     "Added hunks (all)")
nmap_leader("fA", pick_added_hunks_buf,                         "Added hunks (buf)")
nmap_leader("fb", "<Cmd>Pick buffers<CR>",                      "Buffers")
nmap_leader("fc", "<Cmd>Pick git_commits<CR>",                  "Commits (all)")
nmap_leader("fC", "<Cmd>Pick git_commits path='%'<CR>",         "Commits (buf)")
nmap_leader("fd", "<Cmd>Pick diagnostic scope='all'<CR>",       "Diagnostic workspace")
nmap_leader("fD", "<Cmd>Pick diagnostic scope='current'<CR>",   "Diagnostic buffer")
nmap_leader("ff", "<Cmd>Pick files<CR>",                        "Files")
nmap_leader("fg", "<Cmd>Pick grep_live<CR>",                    "Grep live")
nmap_leader("fG", "<Cmd>Pick grep pattern='<cword>'<CR>",       "Grep current word")
nmap_leader("fh", "<Cmd>Pick help<CR>",                         "Help tags")
nmap_leader("fH", "<Cmd>Pick hl_groups<CR>",                    "Highlight groups")
nmap_leader("fl", "<Cmd>Pick buf_lines scope='all'<CR>",        "Lines (all)")
nmap_leader("fL", "<Cmd>Pick buf_lines scope='current'<CR>",    "Lines (buf)")
nmap_leader("fm", "<Cmd>Pick git_hunks<CR>",                    "Modified hunks (all)")
nmap_leader("fM", "<Cmd>Pick git_hunks path='%'<CR>",           "Modified hunks (buf)")
nmap_leader("fr", "<Cmd>Pick resume<CR>",                       "Resume")
nmap_leader("fR", "<Cmd>Pick lsp scope='references'<CR>",       "References (LSP)")
nmap_leader("fs", pick_workspace_symbols_live,                  "Symbols workspace (live)")
nmap_leader("fS", "<Cmd>Pick lsp scope='document_symbol'<CR>",  "Symbols document")
nmap_leader("fv", "<Cmd>Pick visit_paths cwd=''<CR>",           "Visit paths (all)")
nmap_leader("fV", "<Cmd>Pick visit_paths<CR>",                  "Visit paths (cwd)")
nmap_leader("fk", "<Cmd>Pick keymaps<CR>",                      "Keymaps")
nmap_leader("ft", "<Cmd> Pick hipatterns<CR>",                  "Todo list")
nmap_leader("fT", function()
  MiniExtra.pickers.hipatterns({ scope = "current" })
end,                                                            "Todo list (buffer)")
-- Git ========================================================================
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. " --follow -- %"

nmap_leader("ga", "<Cmd>Git diff --cached<CR>",             "Added diff")
nmap_leader("gA", "<Cmd>Git diff --cached -- %<CR>",        "Added diff buffer")
nmap_leader("gc", "<Cmd>Git commit<CR>",                    "Commit")
nmap_leader("gC", "<Cmd>Git commit --amend<CR>",            "Commit amend")
nmap_leader("gd", "<Cmd>Git diff<CR>",                      "Diff")
nmap_leader("gD", "<Cmd>Git diff -- %<CR>",                 "Diff buffer")
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',         'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>',     'Log buffer')
nmap_leader("go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle overlay")
nmap_leader("gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>",  "Show at cursor")

xmap_leader("gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at selection")

-- Language  ==================================================================
nmap_leader("la", "<Cmd>lua vim.lsp.buf.code_action()<CR>",     "Actions")
nmap_leader("ld", "<Cmd>lua vim.diagnostic.open_float()<CR>",   "Diagnostic popup")
nmap_leader("lf", "<Cmd>lua require('conform').format()<CR>",   "Format")
nmap_leader("li", "<Cmd>lua vim.lsp.buf.implementation()<CR>",  "Implementation")
nmap_leader("lh", "<Cmd>lua vim.lsp.buf.hover()<CR>",           "Hover")
nmap_leader("ll", "<Cmd>lua vim.lsp.codelens.run()<CR>",        "Lens")
nmap_leader("lr", "<Cmd>lua vim.lsp.buf.rename()<CR>",          "Rename")
nmap_leader("lR", "<Cmd>lua vim.lsp.buf.references()<CR>",      "References")
nmap_leader("ls", "<Cmd>lua vim.lsp.buf.definition()<CR>",      "Source definition")
nmap_leader("lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")
nmap_leader("lH", "<Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", "Inlay Hints")

xmap_leader("lf", "<Cmd>lua require('conform').format()<CR>", "Format selection")

-- Other  =====================================================================
nmap_leader("or", "<Cmd>lua MiniMisc.resize_window()<CR>", "Resize to default width")
nmap_leader("ot", "<Cmd>lua MiniTrailspace.trim()<CR>",    "Trim trailspace")
nmap_leader("oz", "<Cmd>lua MiniMisc.zoom()<CR>",          "Zoom toggle")

-- Session  ===================================================================
local session_new = "vim.ui.input({ prompt = 'Session name: ' }, MiniSessions.write)"

nmap_leader("sd", "<Cmd>lua MiniSessions.select('delete')<CR>", "Delete")
nmap_leader("sn", "<Cmd>lua " .. session_new .. "<CR>",         "New")
nmap_leader("sr", "<Cmd>lua MiniSessions.select('read')<CR>",   "Read")
nmap_leader("sR", "<Cmd>lua MiniSessions.restart()<CR>",        "Restart")
nmap_leader("sw", "<Cmd>lua MiniSessions.write()<CR>",          "Write current")

-- Terminal  ==================================================================
nmap_leader("tT", "<Cmd>horizontal term<CR>", "Terminal (horizontal)")
nmap_leader("tt", "<Cmd>vertical term<CR>",   "Terminal (vertical)")

-- Visits  ====================================================================
local MiniVisits = require("mini.visits")
local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = "core", sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end

nmap_leader("vc", make_pick_core("",  "Core visits (all)"),       "Core visits (all)")
nmap_leader("vC", make_pick_core(nil, "Core visits (cwd)"),       "Core visits (cwd)")
nmap_leader("vv", "<Cmd>lua MiniVisits.add_label('core')<CR>",    "Add 'core' label")
nmap_leader("vV", "<Cmd>lua MiniVisits.remove_label('core')<CR>", "Remove 'core' label")
nmap_leader("vl", "<Cmd>lua MiniVisits.add_label()<CR>",          "Add label")
nmap_leader("vL", "<Cmd>lua MiniVisits.remove_label()<CR>",       "Remove label")

local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })

local map_iterate_core = function(lhs, direction, desc)
  local opts = { filter = "core", sort = sort_latest, wrap = true }
  local rhs = function()
    MiniVisits.iterate_paths(direction, vim.fn.getcwd(), opts)
  end
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

map_iterate_core("[[", "forward",  "Core label (earlier)")
map_iterate_core("]]", "backward", "Core label (later)")
map_iterate_core("[{", "last",     "Core label (earliest)")
map_iterate_core("]}", "first",    "Core label (latest)")
-- stylua: ignore end
