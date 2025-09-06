local api = vim.api;

local M = {}

function M.map(modes, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  for i = 1, string.len(modes) do
    vim.keymap.set(string.sub(modes, i, i), lhs, rhs, options)
  end
end

return M
