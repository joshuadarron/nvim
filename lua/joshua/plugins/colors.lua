local TRANSPARENT = {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"WinSeparator",
	"StatusLine",
	"StatusLineNC",
	"Pmenu",
	"PmenuSel",
	"PmenuSbar",
	"PmenuThumb",
	"SignColumn",
	"FoldColumn",
	"VertSplit",
	"NvimTreeNormal",
	"NvimTreeNormalNC",
	"NvimTreeCursorLine",
}

-- Global on purpose: called interactively to switch themes.
function ColorMyPencils(color)
	vim.cmd.colorscheme(color or "dracula")
	for _, group in ipairs(TRANSPARENT) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
end

return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			ColorMyPencils()
		end,
	},
	{
		-- ibl.setup() used to live inside ColorMyPencils, which forced indent-blankline
		-- to load at startup. It re-derives its highlights on ColorScheme anyway.
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},
}
