-- Startup file-tree logic, kept in a module so it can be exercised directly
-- (the autocmd in after/plugin/nvim-tree.lua is UI-guarded and never fires headless).
local M = {}

local function tree_is_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NvimTree" then
      return true
    end
  end
  return false
end

---Open the file tree for however nvim was launched. Idempotent: never closes an
---already-open tree (nvim-tree's own directory hijack may have opened one first).
---@param file string|nil the startup argument, "" when nvim was launched bare
function M.open_startup_tree(file)
  local ok, api = pcall(require, "nvim-tree.api")
  if not ok then
    return
  end

  file = file or ""

  -- `nvim <dir>`: cd there so the tree is rooted where you expect
  if file ~= "" and vim.fn.isdirectory(file) == 1 then
    vim.cmd.cd(file)
    if not tree_is_open() then
      api.tree.open()
    end
    return
  end

  if tree_is_open() then
    return
  end

  -- `nvim <file>` or bare `nvim`: open the tree beside it, keep focus where it was
  local prev = vim.api.nvim_get_current_win()
  api.tree.open({ find_file = file ~= "" })
  if vim.api.nvim_win_is_valid(prev) then
    vim.api.nvim_set_current_win(prev)
  end
end

return M
