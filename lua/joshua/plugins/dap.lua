return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		cmd = { "DapContinue", "DapToggleBreakpoint", "DapNew", "DapStepOver", "DapStepInto", "DapStepOut" },
		-- Explicit function rhs: config.dap no longer sets these itself, so these
		-- callbacks ARE the mappings. <F6>/<F7> rather than <leader>du/<leader>dr
		-- so <leader>d (black-hole delete) never waits out 'timeoutlen'.
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP: continue",
			},
			{
				"<F6>",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP: toggle UI",
			},
			{
				"<F7>",
				function()
					require("dap").repl.toggle()
				end,
				desc = "DAP: toggle REPL",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP: step over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP: step into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP: step out",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP: toggle breakpoint",
			},
			{
				"<leader>B",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "DAP: conditional breakpoint",
			},
		},
		config = function()
			require("config.dap")
		end,
	},
}
