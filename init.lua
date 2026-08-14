-- Must precede lazy.setup(): `keys = { "<leader>..." }` specs are expanded there.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options before lazy: set.lua disables netrw (nvim-tree needs that to happen
-- first) and sets the provider g: vars that suppress Nvim 0.12's python3 probe.
require("joshua.set")
require("joshua.remap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { { import = "joshua.plugins" } },
	install = { colorscheme = { "dracula", "habamax" } },
	checker = { enabled = false },
	change_detection = { notify = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"zipPlugin",
				"tohtml",
				"tutor",
				"netrwPlugin",
			},
		},
	},
})
