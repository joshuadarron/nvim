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
		},
		config = function()
			require("telescope").setup({})
			pcall(require("telescope").load_extension, "repo")
		end,
	},
}
