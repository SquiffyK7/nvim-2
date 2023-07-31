local M = {}

function M.diffview_open()
  local windows = vim.api.nvim_list_wins()

  for _, window in ipairs(windows) do
    local buffer = vim.api.nvim_win_get_buf(window)

    if string.match(vim.api.nvim_buf_get_name(buffer), 'DiffviewFilePanel') then
      local tabpage = vim.api.nvim_win_get_tabpage(window)
      vim.api.nvim_set_current_tabpage(tabpage)
      return
    end
  end

  vim.cmd 'DiffviewOpen'
end

function M.diffview_branch_history()
  local windows = vim.api.nvim_list_wins()

  for _, window in ipairs(windows) do
    local buffer = vim.api.nvim_win_get_buf(window)

    if string.match(vim.api.nvim_buf_get_name(buffer), 'DiffviewFileHistoryPanel') then
      local tabpage = vim.api.nvim_win_get_tabpage(window)
      vim.api.nvim_set_current_tabpage(tabpage)
      return
    end
  end

  vim.cmd 'DiffviewFileHistory'
end

function M.diffview_file_history()
  local windows = vim.api.nvim_list_wins()

  for _, window in ipairs(windows) do
    local buffer = vim.api.nvim_win_get_buf(window)

    if string.match(vim.api.nvim_buf_get_name(buffer), 'DiffviewFileHistoryPanel') then
      local tabpage = vim.api.nvim_win_get_tabpage(window)
      vim.api.nvim_set_current_tabpage(tabpage)
      return
    end
  end

  vim.cmd 'DiffviewFileHistory %'
end

return M
