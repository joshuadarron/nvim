return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- cmd so :Mason is reachable from a cold start, not only once
			-- nvim-lspconfig has pulled it in on BufReadPre.
			{
				"mason-org/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
				opts = {},
			},
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		-- Registered during lazy.setup(), so the keymaps exist regardless of when
		-- nvim-lspconfig itself loads.
		init = function()
			local group = vim.api.nvim_create_augroup("joshua_lsp", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = group,
				callback = function(event)
					local function opts(desc)
						return { buffer = event.buf, remap = false, desc = desc }
					end

					-- Nvim 0.12 already binds, unconditionally: grn rename, gra code
					-- action, grr references, gri implementation, grt type definition,
					-- gO document symbol, <C-S> signature help, [d/]d diagnostic jump,
					-- <C-W>d float. On attach it also sets tagfunc, omnifunc, and
					-- K -> hover when K is unmapped in normal mode (it is here).
					-- Only what those don't cover, plus the <leader>v* muscle memory:
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Goto definition"))
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Goto declaration"))

					vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts("Workspace symbol"))
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts("Line diagnostics"))
					vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts("Code action"))
					vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts("References"))
					vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts("Rename"))
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("Signature help"))
				end,
			})
		end,
		config = function()
			vim.opt.signcolumn = "yes"

			-- The cmp delta only. Nvim 0.12's make_client_capabilities() already
			-- reports snippetSupport, insertReplaceSupport, labelDetailsSupport and
			-- resolveSupport, and client.lua deep-merges this over it.
			--
			-- '*' is the lowest-precedence layer and resolves lazily (invalidated on
			-- write), so this is order-independent with respect to mason-lspconfig's
			-- automatic_enable. The old code mutated
			-- require('lspconfig').util.default_config instead, which only feeds the
			-- lspconfig[x].setup() path that v2 no longer takes - it never reached a
			-- single server.
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			require("joshua.lsp.servers")

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vtsls",
					"eslint",
					"jsonls",
					"rust_analyzer",
				},
				-- v2's blessed path: vim.lsp.config() + vim.lsp.enable() per installed
				-- server. The `handlers = {...}` table this config used to pass is not
				-- a recognised key in v2 and was silently swallowed.
				automatic_enable = true,
			})

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = true },
			})
		end,
	},
}
