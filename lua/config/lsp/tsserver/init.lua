local M = {}

function M.setup()
  require('typescript').setup {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false,            -- enable debug logging for commands
    go_to_source_definition = {
      fallback = false,       -- fall back to standard LSP definition on failure
    },
    server = {                -- pass options to lspconfig's setup method
      on_attach = function(bufnr)
        require('config.lsp.tsserver.keymaps').setup(bufnr)
      end,
    },
  }
end

return M
