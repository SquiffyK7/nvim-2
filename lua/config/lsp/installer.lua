local M = {}

-- taken from https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451
function M.setup(servers, options)
  -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
  require('neodev').setup {}

  local lspconfig = require 'lspconfig'

  require('mason').setup {
    -- ui = {
    --   icons = {
    --     package_installed = icons.server_installed,
    --     package_pending = icons.server_pending,
    --     package_uninstalled = icons.server_uninstalled,
    --   },
    -- },
  }

  require('mason-tool-installer').setup {
    ensure_installed = {},
    -- ensure_installed = { "codelldb", "stylua", "shfmt", "shellcheck", "black", "isort", "prettierd" },
    auto_update = false,
    run_on_start = true,
  }

  require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
  }

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      local opts = vim.tbl_deep_extend('force', options, servers[server_name] or {})
      lspconfig[server_name].setup(opts)
    end,
  }
end

return M
