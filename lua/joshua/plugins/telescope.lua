-- Mirrors the ignore set in lua/joshua/plugins/nvim-tree.lua's filesystem_watchers
-- -- keep the two in sync. NOTE: these are Lua patterns matched against the full
-- path, not globs, hence the explicit [/\\] for Windows separators. Writing them
-- as globs is the usual reason this setting silently does nothing.
local IGNORE = {
	"^%.git[/\\]",
	"[/\\]%.git[/\\]",
	"node_modules[/\\]",
	"%.venv[/\\]",
	"__pycache__[/\\]",
	"[/\\]dist[/\\]",
	"[/\\]build[/\\]",
	"%.dist%-info[/\\]",
	"%.lock$",
	"%.png$",
	"%.jpg$",
	"%.jpeg$",
	"%.gif$",
	"%.pdf$",
	"%.zip$",
}

return {
	{
		"nvim-telescope/telescope.nvim",
		-- Unpinned from tag 0.1.8 (2024-05): it predates Nvim 0.11 and its LSP
		-- pickers call vim.lsp.util.jump_to_location, deprecated with a 0.12
		-- removal target.
		version = false,
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"cljoly/telescope-repo.nvim",
		},
		keys = {
			{
				"<leader>pf",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope: find files",
			},
			{
				"<C-p>",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Telescope: git files",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Telescope: grep string",
			},
			{
				-- The repo extension is registered in `config` below, so this is only
				-- valid once telescope has loaded -- which pressing the key guarantees.
				"<leader>pr",
				function()
					require("telescope").extensions.repo.list()
				end,
				desc = "Telescope: repos",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = IGNORE,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob",
						"!**/.git/*",
					},
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					layout_config = { prompt_position = "top" },
				},
				pickers = {
					-- fd filters before Telescope's patterns get a look in, and is
					-- markedly faster than the fallback probe order.
					find_files = {
						find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git" },
					},
					buffers = { sort_lastused = true, sort_mru = true },
				},
			})
			pcall(require("telescope").load_extension, "repo")
		end,
	},
}
