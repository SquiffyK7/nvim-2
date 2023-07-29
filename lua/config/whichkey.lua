local M = {}

function M.setup()
  local whichkey = require 'which-key'

  local conf = {
    window = {
      border = 'single', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
    },
  }

  local opts = {
    mode = 'n', -- Normal mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ['w'] = { '<cmd>update!<CR>', 'Save' },
    ['q'] = { '<cmd>q!<CR>', 'Quit' },

    b = {
      name = 'Buffer',
      c = { '<Cmd>bd!<Cr>', 'Close current buffer' },
      D = { '<Cmd>%bd|e#|bd#<Cr>', 'Delete all buffers' },
    },

    z = {
      name = 'Packer',
      c = { '<cmd>PackerCompile<cr>', 'Compile' },
      i = { '<cmd>PackerInstall<cr>', 'Install' },
      S = { '<cmd>PackerSync<cr>', 'Sync' },
      s = { '<cmd>PackerStatus<cr>', 'Status' },
      u = { '<cmd>PackerUpdate<cr>', 'Update' },
    },

    g = {
      name = 'Git',
      s = { '<cmd>Neogit<CR>', 'Status' },
      d = { '<cmd>DiffviewOpen<cr>', 'Diff View Open' },
      L = { '<cmd>DiffviewFileHistory<cr>', 'Branch History' },
      l = { '<cmd>DiffviewFileHistory %<cr>', 'File History' },
    },

    f = {
      name = 'Find',
      f = { require('utils.finder').find_files, 'Files' },
      d = { require('utils.finder').find_dotfiles, 'Dotfiles' },
      b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
      o = { '<cmd>Telescope oldfiles<cr>', 'Old Files' },
      g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
      c = { '<cmd>Telescope commands<cr>', 'Commands' },
      r = { '<cmd>Telescope file_browser<cr>', 'Browser' },
      w = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Current Buffer' },
      e = { '<cmd>NvimTreeToggle<cr>', 'Explorer' },
    },

    p = {
      name = 'Project',
      p = {
        function()
          require('telescope').extensions.project.project {}
        end,
        'List',
      },
      s = { '<cmd>Telescope repo list<cr>', 'Search' },
    },

    v = {
      name = 'Vim',
      p = { ':lua print(vim.inspect())<Left><Left>', 'Pretty print' },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
