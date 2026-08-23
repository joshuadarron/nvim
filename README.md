# 🧠 Joshua's Neovim Config

A modern Neovim setup built with Lua and lazy.nvim, designed for power users and minimalist developers alike. This configuration includes intelligent autocompletion, LSP integration, fuzzy finding, debugging tools, and beautiful visuals—all optimized for a smooth and efficient development experience.

## ✨ Description

This Neovim configuration automates the installation and management of a full-featured development environment. On startup, it:

- Bootstraps and installs plugins using **lazy.nvim**, loading each one only when it is needed
- Provides blazing-fast navigation and fuzzy search with **Telescope**
- Enables rich syntax highlighting and structure awareness via **Treesitter**
- Offers **LSP support** through **mason** and **nvim-lspconfig**, with autocompletion and snippets via **nvim-cmp** and **LuaSnip**
- Adds UI enhancements like a **file explorer**, **indent guides**, and a slick **Dracula theme**
- Powers up your workflow with **undo history** and **Git integration**
- Supports full **debugging capabilities** with **nvim-dap** and **dap-ui**

Perfect for anyone seeking a fast, clean, and highly extendable Neovim setup.

## ⚙️ Setup

Requires Neovim **0.11+** (developed against 0.12). `git` is required; `fd` and `ripgrep` are
strongly recommended — Telescope uses them for file finding and grep.

1. **Clone this repository into Neovim's config directory:**

```bash
# Linux / macOS
git clone git@github.com:JoshuaDarron/nvim.git ~/.config/nvim

# Windows
git clone git@github.com:JoshuaDarron/nvim.git ~/AppData/Local/nvim
```

2. **Launch Neovim:**

```bash
nvim
```

That's it. `init.lua` clones lazy.nvim on first run and installs every plugin at the revisions
pinned in `lazy-lock.json`; mason then installs the language servers listed in
`lua/joshua/plugins/lsp.lua`. The first launch takes a moment while Treesitter parsers compile — a C
compiler (`cc`, `clang`, `zig`, …) needs to be on `PATH` for that.

Afterwards, `:Lazy` opens the plugin manager UI (`:Lazy sync` to update and re-pin, `:Lazy profile`
for startup timings) and `:Mason` manages language servers.

## 🚀 Usage

Once installed, enjoy features like:

- `:Telescope find_files` — Quickly search and open files
- `:NvimTreeToggle` — Toggle file tree explorer
- `:UndotreeToggle` — Visualize undo history
- LSP: Go to definition, hover docs, and diagnostics out of the box
- Debugging with `nvim-dap` and `dap-ui`

Generic debug adapters live in `lua/joshua/dap/init.lua`. Configurations specific to a machine or a
private project — workspace paths, node names, credentials — belong in `lua/joshua/dap/local.lua`,
which is gitignored; copy `lua/joshua/dap/local.example.lua` to get started. Configurations that
belong to a project are better kept in that project's own `.vscode/launch.json`, which nvim-dap
reads on demand.

## 👤 Authors

[Joshua Phillips](https://github.com/JoshuaDarron)
