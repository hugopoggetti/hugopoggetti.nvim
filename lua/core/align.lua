local M = {}

M.get_lines = function(opts)
  if opts then
    return vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  else
    local row = vim.api.nvim_win_get_cursor(0)[1]
    return vim.api.nvim_buf_get_lines(0, row - 1, row, false)
  end
end

M.max_pattern_index = function(lines, pattern)
  local max = 0
  for _, line in ipairs(lines) do
    local idx = line:find(pattern)
    if idx and idx > max then
      max = idx
    end
  end
  return max
end

M.align_to_index = function(lines, pattern, index)
  local result = {}
  for _, line in ipairs(lines) do
    local idx = line:find(pattern, 1, true)
    if idx then
      local before = line:sub(1, idx - 1)
      local after = line:sub(idx)
      local spaces = string.rep(" ", index - idx)
      table.insert(result, before .. spaces .. after)
    else
      table.insert(result, line)
    end
  end
  return result
end

M.align_pattern = function(pattern, opts, forced_index)
  local lines = M.get_lines(opts)
  local mpi = forced_index or M.max_pattern_index(lines, pattern)
  local aligned_lines = M.align_to_index(lines, pattern, mpi)
  local start_line = opts and opts.line1 or vim.api.nvim_win_get_cursor(0)[1]
  local end_line = opts and opts.line2 or start_line

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, aligned_lines)
end

vim.api.nvim_create_user_command("AlignPattern", function(opts)
  local args = vim.split(opts.args, " ")
  local pattern = args[1]
  local forced_index = tonumber(args[2])
  M.align_pattern(pattern, opts, forced_index)
end, { nargs = "+", range = true })

return M
