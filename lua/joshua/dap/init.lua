-- Generic, machine-independent debug adapters. Anything project-specific -- paths
-- inside a particular repo, node names, credentials -- belongs in
-- lua/joshua/dap/local.lua (gitignored, required at the bottom of this file) or in
-- that project's own .vscode/launch.json, which nvim-dap reads on demand.

local dap = require("dap")
local dapui = require("dapui")

local mason = vim.fn.stdpath("data") .. "/mason"
local is_win = (vim.uv or vim.loop).os_uname().sysname:find("Windows") ~= nil

local function mason_bin(name)
	local found = vim.fn.exepath(name)
	if found ~= "" then
		return found
	end
	return mason .. "/bin/" .. name .. (is_win and ".cmd" or "")
end

dapui.setup()
require("nvim-dap-virtual-text").setup()

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Keymaps live in lua/joshua/plugins/dap.lua's `keys` spec, so nvim-dap stays
-- lazy until one of them is pressed.

-- ╭────────────────────────────────────────────╮
-- │ JavaScript / TypeScript via js-debug-adapter │
-- ╰────────────────────────────────────────────╯
-- Replaces vscode-node-debug2, which Microsoft archived years ago and which
-- pointed at a stdpath("data")/dap_adapters directory that does not exist.
dap.adapters["pwa-node"] = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = mason_bin("js-debug-adapter"),
		args = { "${port}" },
	},
}

-- Built per-filetype rather than aliased, so a table.insert from local.lua or a
-- launch.json cannot silently land in two filetypes at once.
for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	dap.configurations[ft] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to process",
			processId = function()
				return require("dap.utils").pick_process()
			end,
			cwd = "${workspaceFolder}",
		},
	}
end

-- ╭──────────────────────────────╮
-- │ Python via mason's debugpy   │
-- ╰──────────────────────────────╯
-- The bare `python` on PATH has no debugpy module; mason ships its own venv.
local debugpy = mason .. (is_win and "/packages/debugpy/venv/Scripts/python.exe" or "/packages/debugpy/venv/bin/python")
dap.adapters.python = {
	type = "executable",
	command = debugpy,
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}

-- ╭────────────────────────────────╮
-- │ C / C++ / Rust via codelldb    │
-- ╰────────────────────────────────╯
-- Replaces cpptools, which was reached through
-- os.getenv("USERPROFILE") .. "\\dap_adapters\\..." -- a hard
-- "concatenate a nil value" error at load time on any non-Windows host, pointing
-- at a directory that does not exist on this one either.
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = mason_bin("codelldb"),
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch executable",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- ╭──────────────────────────────────────────────╮
-- │ Project-specific configurations              │
-- ╰──────────────────────────────────────────────╯
-- Machine-local and gitignored. The other home for project configs is the
-- project's own .vscode/launch.json, which this nvim-dap reads on demand with no
-- wiring needed here (dap.ext.vscode.load_launchjs is deprecated for exactly
-- that reason -- see :help dap-providers).
pcall(require, "joshua.dap.local")
