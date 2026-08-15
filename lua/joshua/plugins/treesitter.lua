return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- Load-bearing: upstream's default branch is now `main`, an incompatible
		-- rewrite with no nvim-treesitter.configs module. Without this pin a fresh
		-- clone breaks highlighting outright. The exact revision is pinned in
		-- lazy-lock.json, so this only has to keep `main` out.
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdate", "TSInstall", "TSInstallInfo", "TSUpdateSync", "TSModuleInfo" },
		main = "nvim-treesitter.configs",
		opts = {
			-- c/lua/markdown are also bundled with Nvim 0.12, but nvim-treesitter
			-- ships queries/{c,lua,markdown}/ and its directory precedes $VIMRUNTIME
			-- on the runtimepath, so the plugin's queries win either way. Keeping the
			-- plugin's parsers for those languages is the self-consistent pairing;
			-- dropping them would pair plugin queries with bundled parsers.
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"gitcommit",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			sync_install = false,

			-- Was true. It was not failing -- zig is on PATH and is in
			-- nvim-treesitter's compiler list, which is how gitignore and requirements
			-- parsers appeared without ever being declared. That is the problem:
			-- opening an unfamiliar filetype kicked off a git clone plus a C compile
			-- in the background. Everything used is declared above instead.
			auto_install = false,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function(_, buf)
					local name = vim.api.nvim_buf_get_name(buf)
					local ok, stats = pcall((vim.uv or vim.loop).fs_stat, name)
					if ok and stats and stats.size > 200 * 1024 then
						return true
					end
					return vim.api.nvim_buf_line_count(buf) > 20000
				end,
			},
		},
	},
}
