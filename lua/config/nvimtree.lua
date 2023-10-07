local M = {}

local function get_closest_dir(node)
  local closest_dir

  local is_root = not node.parent
  if is_root then
    return vim.fn.getcwd()
  end

  if node.type ~= 'directory' then
    closest_dir = require('nvim-tree.utils').get_parent_of_group(node).parent
  else
    closest_dir = node
  end

  return closest_dir.absolute_path
end

local function find_files_under_cursor()
  local node = require('nvim-tree.lib').get_node_at_cursor()

  if node then
    require('utils.finder').find_files { cwd = get_closest_dir(node) }
  end
end

local function live_grep_under_cursor()
  local node = require('nvim-tree.lib').get_node_at_cursor()

  if node then
    require('telescope.builtin').live_grep { cwd = get_closest_dir(node) }
  end
end

function M.setup()
  require('nvim-tree').setup {
    view = {
      number = true,
      relativenumber = true,
      adaptive_size = true,
    },
    filters = {
      git_ignored = false,
      custom = { '^.git$' },
    },
    update_focused_file = {
      enable = true,
    },

    on_attach = function(bufnr)
      local nvim_tree = require 'nvim-tree.api'

      -- default mappings
      nvim_tree.config.mappings.default_on_attach(bufnr)

      local whichkey = require 'which-key'

      local keymap_l = {
        f = {
          name = 'Find',
          f = { find_files_under_cursor, 'Find file under cursor' },
          g = { live_grep_under_cursor, 'Live grep under cursor' },
        },
      }

      whichkey.register(keymap_l, { buffer = bufnr, prefix = '<leader>' })
    end,
  }
end

return M
