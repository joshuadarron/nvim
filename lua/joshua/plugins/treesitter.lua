return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- Load-bearing: upstream's default branch is now `main`, an incompatible
		-- rewrite with no nvim-treesitter.configs module. Without this pin a fresh
		-- clone breaks highlighting outright.
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdate", "TSInstall", "TSInstallInfo", "TSUpdateSync", "TSModuleInfo" },
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = { "javascript", "typescript", "c", "lua", "rust", "python" },
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
	},
}
