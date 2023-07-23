local M = {}

function M.find_files()
  require('telescope.builtin').find_files {
    find_command = { 'fd', '--hidden' },
    file_ignore_patterns = { '.git/' },
  }
end

-- Find dotfiles
function M.find_dotfiles()
  require('telescope.builtin').git_files {
    prompt_title = '<Dotfiles>',
    cwd = '$DOTFILES/',
  }
end

-- not sure if we still need this?
-- Custom find buffers function.
function M.find_buffers()
  local results = {}
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      local filename = vim.api.nvim_buf_get_name(buffer)
      table.insert(results, filename)
    end
  end

  vim.ui.select(results, { prompt = 'Find buffer:' }, function(selected)
    if selected then
      vim.api.nvim_command('buffer ' .. selected)
    end
  end)
end

return M
