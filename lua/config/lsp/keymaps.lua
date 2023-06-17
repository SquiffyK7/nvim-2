local M = {}

local whichkey = require 'which-key'

local function keymappings(client, bufnr)
  local opts = { buffer = bufnr }

  -- Key mappings
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

  -- Whichkey
  local keymap_l = {
    d = { vim.diagnostic.open_float, 'Line Diagnostics' },
    l = {
      name = 'Code',
      r = { vim.lsp.buf.rename, 'Rename' },
      a = { vim.lsp.buf.code_action, 'Code Action' },
      i = { '<cmd>LspInfo<CR>', 'Lsp Info' },
    },
  }
  if client.server_capabilities.documentFormattingProvider then
    keymap_l.l.f = { vim.lsp.buf.formatting, 'Format Document' }
  end

  local keymap_g = {
    name = 'Goto',
    d = { require('telescope.builtin').lsp_definitions, 'Definition' },
    D = { vim.lsp.buf.declaration, 'Declaration' },
    s = { vim.lsp.buf.signature_help, 'Signature Help' },
    I = { vim.lsp.buf.implementation, 'Goto Implementation' },
    t = { vim.lsp.buf.type_definition, 'Goto Type Definition' },
    r = { require('telescope.builtin').lsp_references, 'Goto References' },
  }
  whichkey.register(keymap_l, { buffer = bufnr, prefix = '<leader>' })
  whichkey.register(keymap_g, { buffer = bufnr, prefix = 'g' })
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
end

return M