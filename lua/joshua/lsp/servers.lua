-- Per-server overrides, merged on top of nvim-lspconfig's own lsp/<name>.lua.
-- Only what differs from the shipped defaults belongs here.

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
			diagnostics = { globals = { "vim", "ColorMyPencils" } },
			telemetry = { enable = false },
			-- conform runs stylua; two formatters on one buffer fight each other.
			format = { enable = false },
		},
	},
})

vim.lsp.config("vtsls", {
	settings = {
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			inlayHints = {
				parameterNames = { enabled = "literals" },
				variableTypes = { enabled = false },
			},
		},
		javascript = {
			updateImportsOnFileMove = { enabled = "always" },
		},
		vtsls = {
			autoUseWorkspaceTsdk = true, -- respect the repo's own TypeScript version
			experimental = { completion = { enableServerSideFuzzyMatch = true } },
		},
	},
})

vim.lsp.config("jsonls", {
	settings = { json = { validate = { enable = true } } },
})
