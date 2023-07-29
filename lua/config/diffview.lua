local M = {}

function M.setup()
  local actions = require 'diffview.actions'
  require('diffview').setup {
    keymaps = {
      view = {
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
      },
      file_panel = {
        { 'n', '<c-u>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
        { 'n', '<c-d>', actions.scroll_view(0.25),  { desc = 'Scroll the view down' } },
        { 'n', 'q',     '<cmd>DiffviewClose<cr>',   { desc = 'Close diffview' } },
      },
      file_history_panel = {
        { 'n', '<c-u>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
        { 'n', '<c-d>', actions.scroll_view(0.25),  { desc = 'Scroll the view down' } },
        { 'n', 'q',     '<cmd>DiffviewClose<cr>',   { desc = 'Close diffview' } },
      },
    },
  }
end

return M
