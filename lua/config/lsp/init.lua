local M = {}

-- available servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
          -- Disabble popup: https://github.com/LuaLS/lua-language-server/discussions/1688#discussioncomment-4185003
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  tsserver = {},
  eslint = {
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'EslintFixAll',
      })
    end,
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },
}

function M.setup()
  -- Setup LSP handlers
  require('config.lsp.handlers').setup()

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local opts = {
    capabilities = capabilities,
  }

  require('config.lsp.null-ls').setup(opts)
  require('config.lsp.installer').setup(servers, opts)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),

    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- Enable completion triggered by <C-X><C-O>
      -- See `:help omnifunc` and `:help ins-completion` for more information.
      -- Remove this once using cmp instead
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Use LSP as the handler for formatexpr.
      -- See `:help formatexpr` for more information.
      vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'

      require('config.lsp.keymaps').setup(client, bufnr)

      -- Configure formatting
      require('config.lsp.null-ls.formatters').setup(client, bufnr)
    end,
  })
end

return M
