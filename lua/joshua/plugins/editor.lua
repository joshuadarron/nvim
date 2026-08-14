return {
	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeFocus" },
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undotree" },
		},
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gedit", "GBrowse", "Gclog" },
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
		},
	},
}
