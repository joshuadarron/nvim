vim.opt.sessionoptions = {
	"buffers",      -- open buffers
	"curdir",       -- current dir
	"tabpages",     -- tabs
	"winsize",      -- window size
	"help",         -- help windows
	"globals",      -- global vars
	"localoptions", -- local settings (folds etc.)
}

vim.opt.guicursor = ""

-- Force shell environment init so Telescope can find rg/fd
vim.fn.system('rg --version')

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true


vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("nvim-tree").setup({
  filters = {
    dotfiles = false,         -- Show dotfiles (e.g. .git, .env)
    git_ignored = false       -- Show files ignored by git
  }
})
