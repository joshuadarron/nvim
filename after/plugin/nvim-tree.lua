require("nvim-tree").setup({
  filters = {
    dotfiles = false,         -- Show dotfiles (e.g. .git, .env)
    git_ignored = false       -- Show files ignored by git
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {
      "%.venv",
      "node_modules",
      "%.git",
      "__pycache__",
      "%.dist%-info",  -- catches orphaned ~ip-*.dist-info too
      "build",
      "dist",
    },
  }
})

-- Always end up with a file tree on startup, whatever nvim was launched with.
-- There is no session restore in this config (auto-session was removed because it
-- kept writing window-less sessions that restored to a blank buffer), so this
-- autocmd is the only thing that decides what you see at startup.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    -- headless / pager: leave the UI alone
    if #vim.api.nvim_list_uis() == 0 then
      return
    end

    -- multiple file args: respect the user's layout
    if vim.fn.argc() > 1 then
      return
    end

    require("joshua.tree").open_startup_tree(data.file)
  end,
})
