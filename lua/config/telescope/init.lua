local M = {}

function M.setup()
  local telescope = require 'telescope'
  local trouble = require 'trouble.providers.telescope'
  local actions = require 'config.telescope.actions'
  local preview_maker = require 'config.telescope.preview_maker'

  telescope.setup {
    defaults = {
      buffer_previewer_maker = preview_maker,
      mappings = {
        n = {
          ['<c-q>'] = trouble.open_with_trouble,
        },
        i = {
          ['<c-q>'] = trouble.open_with_trouble,
        },
      },
    },

    pickers = {
      find_files = {
        mappings = {
          n = {
            ['y'] = actions.file_path,
          },
          i = {
            ['<C-y>'] = actions.file_path,
          },
        },
      },
    },
  }

  telescope.load_extension 'fzf'
  telescope.load_extension 'project'
  telescope.load_extension 'repo'
  telescope.load_extension 'file_browser'
  telescope.load_extension 'projects'
end

return M
