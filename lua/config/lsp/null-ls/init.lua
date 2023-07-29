local M = {}

local nls = require 'null-ls'
local nls_utils = require 'null-ls.utils'

local sources = {
  nls.builtins.formatting.prettierd.with {
    disabled_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json' },
  },
  nls.builtins.formatting.fixjson,
  nls.builtins.formatting.stylua.with {
    extra_args = {
      '--indent-type',
      'Spaces',
      '--indent-width',
      '2',
      '--quote-style',
      'AutoPreferSingle',
      '--call-parentheses',
      'None',
    },
  },
}

function M.setup(opts)
  nls.setup {
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern '.git',
  }
end

return M
