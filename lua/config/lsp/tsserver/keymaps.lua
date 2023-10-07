local M = {}

function M.setup(bufnr)
  local whichkey = require 'which-key'
  local typescript = require 'typescript'

  local keymap_l = {
    l = {
      name = 'Code',
      R = { '<cmd>TypescriptRenameFile<cr>', 'Rename File' },
      o = { typescript.actions.organizeImports, 'Organise Imports' },
    },
  }
  local keymap_g = {
    name = 'Goto',
    D = { '<cmd>TypescriptGoToSourceDefinition<cr>', 'Source Definition' },
  }

  whichkey.register(keymap_l, { buffer = bufnr, prefix = '<leader>' })
  whichkey.register(keymap_g, { buffer = bufnr, prefix = 'g' })
end

return M
