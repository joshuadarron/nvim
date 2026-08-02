-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"
	use {
		"nvim-telescope/telescope.nvim", tag = "0.1.8",
		-- or                            , branch = "0.1.x",
		requires = { {"nvim-lua/plenary.nvim"} }
	}

	use("nvim-treesitter/nvim-treesitter", {branch = "master", run = ":TSUpdate"})
	use("nvim-treesitter/playground")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")

    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"saadparwaiz1/cmp_luasnip"},
            {"hrsh7th/cmp-nvim-lua"},

            -- Snippets
            {"L3MON4D3/LuaSnip"},
            {"rafamadriz/friendly-snippets"},
        }
    }

    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional
        },
    }

    -- Faster directory search
    use {
        "cljoly/telescope-repo.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    -- Indent Style
    use "lukas-reineke/indent-blankline.nvim"

    use "Mofiqul/dracula.nvim"

    use {
        "stevearc/conform.nvim",
    }

    use {
      "mfussenegger/nvim-dap",
      requires = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
      },
      config = function()
        require("config.dap") -- we'll create this file next
      end
    }
end)
