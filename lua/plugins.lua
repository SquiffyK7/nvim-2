local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'
  end

  -- Plugins
  local function plugins(use)
    use { 'wbthomason/packer.nvim' }

    -- Notification
    use {
      'rcarriga/nvim-notify',
      event = 'VimEnter',
      config = function()
        vim.notify = require 'notify'
      end,
    }

    -- Colorscheme
    use {
      'sainnhe/everforest',
      config = function()
        -- vim.cmd 'colorscheme everforest'
      end,
    }
    use {
      'navarasu/onedark.nvim',
      config = function()
        require('config.onedark').setup()
      end,
    }

    -- Startup screen
    use {
      'goolord/alpha-nvim',
      config = function()
        require('config.alpha').setup()
      end,
    }

    -- Git
    use {
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('config.neogit').setup()
      end,
    }
    use {
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
      config = function()
        require('config.diffview').setup()
      end,
    }

    use {
      'petertriho/nvim-scrollbar',
      config = function()
        require('config.nvimscrollbar').setup()
      end,
      requires = {
        'nvim-lua/plenary.nvim',
        'lewis6991/gitsigns.nvim',
        'kevinhwang91/nvim-hlslens',
      },
    }

    -- WhichKey
    use {
      'folke/which-key.nvim',
      config = function()
        require('config.whichkey').setup()
      end,
    }

    -- Load only when require
    use { 'nvim-lua/plenary.nvim', module = 'plenary' }

    -- Better icons
    use {
      'kyazdani42/nvim-web-devicons',
      module = 'nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup { default = true }
      end,
    }

    -- Better Comment
    use {
      'numToStr/Comment.nvim',
      keys = { 'gc', 'gcc', 'gbc' },
      config = function()
        require('Comment').setup {
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
      end,
    }

    -- Markdown
    use {
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
      ft = 'markdown',
      cmd = { 'MarkdownPreview' },
    }

    -- Lualine
    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = function()
        require('config.lualine').setup()
      end,
      requires = { 'nvim-web-devicons' },
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      event = 'BufRead',
      run = ':TSUpdate',
      config = function()
        require('config.treesitter').setup()
      end,
    }

    use {
      'ibhagwan/fzf-lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('config.nvimtree').setup()
      end,
    }

    -- User interface
    use {
      'stevearc/dressing.nvim',
      event = 'BufEnter',
      config = function()
        require('dressing').setup {
          select = {
            backend = { 'telescope', 'fzf', 'builtin' },
          },
        }
      end,
    }

    use {
      'nvim-telescope/telescope.nvim',
      module = 'telescope',
      cmd = { 'Telescope' },
      config = function()
        require('config.telescope').setup()
      end,
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        'nvim-telescope/telescope-project.nvim',
        'cljoly/telescope-repo.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        {
          'ahmedkhalf/project.nvim',
          config = function()
            require('project_nvim').setup {}
          end,
        },
      },
    }

    -- Buffer line
    use {
      'akinsho/nvim-bufferline.lua',
      event = 'BufReadPre',
      config = function()
        require('config.bufferline').setup()
      end,
    }

    use 'famiu/bufdelete.nvim'

    -- Motion
    use {
      'unblevable/quick-scope',
      config = function()
        vim.cmd [[
					let g:qs_filetype_blacklist = ['qf', 'Trouble']
				]]
      end,
    }
    use 'tpope/vim-surround'

    use {
      'gbprod/cutlass.nvim',
      config = function()
        require('cutlass').setup { cut_key = 'm' }
      end,
    }

    -- Auto pairs
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup {
          map_cr = true,
          check_ts = true,
        }
      end,
    }

    -- Auto tag
    use {
      'windwp/nvim-ts-autotag',
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
    }

    -- End wise
    use {
      'RRethy/nvim-treesitter-endwise',
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
    }

    use {
      'JoosepAlviste/nvim-ts-context-commentstring',
      requires = 'nvim-treesitter/nvim-treesitter',
      after = 'nvim-treesitter',
    }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      event = 'BufReadPre',
      config = function()
        require('config.lsp').setup()
      end,
      requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'folke/neodev.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        {
          'j-hui/fidget.nvim',
          config = function()
            require('fidget').setup {}
          end,
        },
        'b0o/schemastore.nvim',
        'jose-elias-alvarez/typescript.nvim',
      },
    }

    -- Completion
    use {
      'hrsh7th/nvim-cmp',
      config = function()
        require('config.cmp').setup()
      end,
      requires = {
        {
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-nvim-lua',
          'ray-x/cmp-treesitter',
          'hrsh7th/cmp-cmdline',
          'saadparwaiz1/cmp_luasnip',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lsp-signature-help',
          'L3MON4D3/LuaSnip',
          wants = 'friendly-snippets',
          config = function()
            require('config.luasnip').setup()
          end,
        },
        'rafamadriz/friendly-snippets',
      },
    }

    -- trouble.nvim
    use {
      'folke/trouble.nvim',
      event = 'BufReadPre',
      cmd = { 'TroubleToggle', 'Trouble' },
      module = 'trouble',
      config = function()
        require('trouble').setup {
          use_diagnostic_signs = true,
          action_keys = {
            jump = '<tab>',
            jump_close = '<cr>',
          },
        }
      end,
      requires = 'nvim-tree/nvim-web-devicons',
    }

    -- lspsaga.nvim
    use {
      'tami5/lspsaga.nvim',
      event = 'VimEnter',
      cmd = { 'Lspsaga' },
      config = function()
        require('lspsaga').setup {}
      end,
    }

    -- Debugging
    use {
      'mfussenegger/nvim-dap',
      event = 'BufReadPre',
      module = { 'dap' },
      requires = {
        'theHamsta/nvim-dap-virtual-text',                       -- UI extension for nvim-dap
        'rcarriga/nvim-dap-ui',                                  -- UI extension for nvim-dap
        'nvim-telescope/telescope-dap.nvim',                     -- UI extension for nvim-dap
        { 'jbyuki/one-small-step-for-vimkind', module = 'osv' }, -- debug adapter for debugging luacode
      },
      config = function()
        require('config.dap').setup()
      end,
    }

    if packer_bootstrap then
      print 'Restart Neovim required after installation!'
      require('packer').sync()
    end
  end

  packer_init()

  local packer = require 'packer'
  packer.init(conf)
  packer.startup(plugins)
end

return M
