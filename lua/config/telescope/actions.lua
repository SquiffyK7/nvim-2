local M = {}

M.file_path = function(prompt_bufnr)
  -- Get selected entry and the file full path
  local content = require('telescope.actions.state').get_selected_entry()
  local full_path = content.cwd .. require('plenary.path').path.sep .. content.value

  -- Yank the path to * register
  vim.fn.setreg('*', full_path)

  -- Close the popup
  require('utils').info 'File path is yanked '
  require('telescope.actions').close(prompt_bufnr)
end

return require('telescope.actions.mt').transform_mod(M)
