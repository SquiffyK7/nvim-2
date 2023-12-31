local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ' '

opt.termguicolors = true      -- Enable colors in terminal
opt.hlsearch = true           -- Set highlight on search
opt.incsearch = true          -- Show search matches while typing search query
opt.number = true             -- Make line numbers default
opt.relativenumber = true     -- Make relative number default
opt.mouse = 'a'               -- Enable mouse mode
opt.breakindent = true        -- Enable break indent
opt.undofile = true           -- Save undo history
opt.ignorecase = true         -- Case insensitive searching unless /C or capital in search
opt.smartcase = true          -- Smart case
opt.updatetime = 250          -- Decrease update time
opt.signcolumn = 'yes'        -- Always show sign column
opt.clipboard = 'unnamedplus' -- Access system clipboard
opt.timeoutlen = 300          -- Time in milliseconds to wait for a mapped sequence to complete.
opt.laststatus = 3            -- show shared statusline accross windows
opt.path:remove '/usr/include'
opt.path:append '**'
opt.wildignorecase = true
opt.wildignore:append '**/node_modules/*'
opt.fillchars:append 'diff:╱'
opt.expandtab = true -- Insert space characters on <tab>
opt.tabstop = 2      -- Set tab space to 2
opt.shiftwidth = 2   -- Set tab space to 2
opt.background = 'light'

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
