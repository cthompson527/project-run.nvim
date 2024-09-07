local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local __state = {}
local __all_cmds = {}

M._clear = function()
	__state = {}
	__all_cmds = {}
end

M._execute = function(cmd)
	vim.cmd("edit term://" .. cmd)
end

M.add_cmd = function(cmd)
	if not __all_cmds[cmd] then
		table.insert(__state, cmd)
		__all_cmds[cmd] = true
	end
end

M.get_cmds = function()
	return __state
end

M.run_last_cmd = function()
	M._execute(__state[#__state])
end

M.show_cmds = function(opts)
	opts = opts or require("telescope.themes").get_dropdown({})
	pickers
		.new(opts, {
			prompt_title = "Run",
			finder = finders.new_table({
				results = M.get_cmds(),
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local selection = action_state.get_selected_entry()
					M._execute(selection[1])
				end)
				return true
			end,
		})
		:find()
end

return M
