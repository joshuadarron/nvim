return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
			},
			format_on_save = function(bufnr)
				-- Disable format-on-save if no config file is found for the formatter
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname == "" then
					return
				end

				-- Only format if the formatter has a project config file present
				local config_patterns = {
					prettier = {
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.js",
						".prettierrc.cjs",
						".prettierrc.toml",
						"prettier.config.js",
						"prettier.config.cjs",
					},
					prettierd = {
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.js",
						".prettierrc.cjs",
						".prettierrc.toml",
						"prettier.config.js",
						"prettier.config.cjs",
					},
					stylua = { "stylua.toml", ".stylua.toml" },
					black = { "pyproject.toml", ".black", "setup.cfg" },
					rustfmt = { "rustfmt.toml", ".rustfmt.toml" },
				}

				local formatters = require("conform").list_formatters(bufnr)
				for _, formatter in ipairs(formatters) do
					local patterns = config_patterns[formatter.name]
					if patterns then
						local found = vim.fs.find(patterns, {
							upward = true,
							path = vim.fs.dirname(bufname),
							stop = vim.env.HOME or vim.fn.expand("~"),
						})
						if #found > 0 then
							return { timeout_ms = 2000, lsp_fallback = true }
						end
					else
						-- No config check defined for this formatter, allow it (e.g. rustfmt works without config)
						return { timeout_ms = 2000, lsp_fallback = true }
					end
				end

				-- No formatter config found — skip formatting on save
				return nil
			end,
		},
	},
}
