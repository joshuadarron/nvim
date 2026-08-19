-- Copy to lua/joshua/dap/local.lua (gitignored) and edit.
--
-- Prefer the project's own .vscode/launch.json over this file: joshua/dap/init.lua
-- already loads it and re-loads on DirChanged, so configs that belong to a repo
-- can live in that repo. Use this file only for entries that must not go in the
-- project repo either.
--
-- Never hardcode a secret here, even though the file is gitignored -- read it
-- from the environment so rotating it is a shell change, not an edit:
--   local pw = assert(os.getenv("MYAPP_DB_PASSWORD"), "MYAPP_DB_PASSWORD unset")

local dap = require("dap")

table.insert(dap.configurations.typescript, {
	name = "Example:Server - Debug",
	type = "pwa-node",
	request = "launch",
	program = "${workspaceFolder}/app/server/webserver.ts",
	cwd = "${workspaceFolder}/build/debug/app",
	args = {
		"--moduleType=platform",
		"--debug=init",
		"--config.database.dialect=mysql",
		"--config.database.user=" .. (os.getenv("MYAPP_DB_USER") or "root"),
		"--config.database.password=" .. (os.getenv("MYAPP_DB_PASSWORD") or ""),
	},
	outFiles = { "${workspaceFolder}/build/debug/app/**/*.js" },
	console = "integratedTerminal",
	skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
})
