vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Default is 1000ms. Anything shorter than a deliberate multi-key sequence
-- keeps <leader>-prefixed mappings from feeling stuck.
vim.opt.timeoutlen = 300

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
