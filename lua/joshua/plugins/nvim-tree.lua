return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = {
			"NvimTreeToggle",
			"NvimTreeFindFile",
			"NvimTreeOpen",
			"NvimTreeClose",
			"NvimTreeFocus",
			"NvimTreeRefresh",
		},
		keys = {
			{ "<leader>pv", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
			{ "<leader>pt", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal file in tree" },
		},
		-- Runs inside lazy.setup() and does NOT load the plugin. The require() in
		-- joshua.tree is what triggers the load, at VimEnter -- lazy intercepts it,
		-- runs opts/config, then returns the module.
		init = function()
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function(data)
					-- headless / pager: leave the UI alone
					if #vim.api.nvim_list_uis() == 0 then
						return
					end

					-- multiple file args: respect the user's layout
					if vim.fn.argc() > 1 then
						return
					end

					require("joshua.tree").open_startup_tree(data.file)
				end,
			})
		end,
		opts = {
			filters = {
				dotfiles = false, -- Show dotfiles (e.g. .git, .env)
				git_ignored = false, -- Show files ignored by git
			},
			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
				ignore_dirs = {
					"%.venv",
					"node_modules",
					"%.git",
					"__pycache__",
					"%.dist%-info", -- catches orphaned ~ip-*.dist-info too
					"build",
					"dist",
				},
			},
		},
	},
}
