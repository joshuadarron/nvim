return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				-- No `build`: install_jsregexp needs make, which isn't on this box.
				-- LuaSnip works without it (no regex transforms in these snippets).
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				performance = {
					debounce = 60,
					throttle = 30,
					fetching_timeout = 200,
					max_view_entries = 40,
				},
				-- cmp.config.sources(g1, g2) is what produces real group semantics:
				-- group 2 is only consulted when group 1 yields nothing. A flat list
				-- with group_index keys set by hand is not equivalent.
				--
				-- max_item_count matters most for nvim_lsp: rust_analyzer and vtsls
				-- routinely return 1000+ items for a bare `.`, and max_view_entries
				-- caps only what is drawn, not what is filtered and sorted per
				-- keystroke.
				--
				-- cmp-buffer's default get_bufnrs is already current-buffer-only.
				-- Do not widen it.
				sources = cmp.config.sources({
					{ name = "nvim_lsp", max_item_count = 30 },
					{ name = "luasnip", keyword_length = 2, max_item_count = 5 },
					{ name = "path", max_item_count = 10 },
				}, {
					{ name = "buffer", keyword_length = 3, max_item_count = 5 },
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
			})
		end,
	},
}
