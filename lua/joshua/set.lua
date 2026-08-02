-- No "globals": it persisted NvimTreeSetup/NvimTreeRequired into session files.
-- "blank" is required or :mksession silently drops unnamed / buftype=nofile
-- windows, producing a session that restores to an empty buffer.
vim.opt.sessionoptions = {
	"blank",        -- unnamed / nofile windows
	"buffers",      -- open buffers
	"curdir",       -- current dir
	"tabpages",     -- tabs
	"winsize",      -- window size
	"help",         -- help windows
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

-- Disable unused remote-plugin providers. This is a pure-Lua config (LSP +
-- treesitter + nvim-dap), so none of these are needed. On Nvim 0.12 probing an
-- unconfigured python3 provider (pyenv shim, no pynvim) THROWS on has('python3'),
-- which the runtime python ftplugin calls on every .py open -> error wall / blank
-- screen. Disabling makes has('python3') return 0 cleanly.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
