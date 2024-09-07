describe("project-run", function()
	before_each(function()
		require("project-run")._clear()
	end)

	it("can be required", function()
		require("project-run")
	end)

	it("can can get the project path from git", function()
		local pr = require("project-run")
		local path = pr._get_project_path()
	end)

	it("can add a command to state", function()
		local pr = require("project-run")
		local cmd = "echo 'test'"
		pr.add_cmd(cmd)
		local state = pr.get_cmds()
		assert.are.same({ cmd }, state)
	end)

	it("can add multiple commands to state", function()
		local pr = require("project-run")
		local cmd1 = "echo 'test'"
		local cmd2 = "echo 'last'"
		local cmd3 = "echo 'cmd'"
		pr.add_cmd(cmd1)
		pr.add_cmd(cmd2)
		pr.add_cmd(cmd3)
		local state = pr.get_cmds()
		assert.are.same({ cmd1, cmd2, cmd3 }, state)
	end)

	it("does not store duplicate commands", function()
		local pr = require("project-run")
		local cmd = "echo 'test'"
		pr.add_cmd(cmd)
		pr.add_cmd(cmd)
		pr.add_cmd(cmd)
		local state = pr.get_cmds()
		assert(vim.inspect(state) == vim.inspect({ cmd }))
	end)

	it("can retrieve the last ran command", function()
		local pr = require("project-run")
		local cmd1 = "echo 'test'"
		local cmd2 = "echo 'last'"
		local cmd3 = "echo 'cmd'"
		pr.add_cmd(cmd1)
		pr.add_cmd(cmd2)
		pr.add_cmd(cmd3)
		local last_cmd = pr.get_last_cmd()
		assert(last_cmd == cmd3)
	end)
end)
