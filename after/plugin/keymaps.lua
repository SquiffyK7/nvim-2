local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap('i', 'jk', '<ESC>', default_opts)
keymap('t', 'jk', '<C-\\><C-n>', default_opts)

-- Center search results
keymap('n', 'n', 'nzz', default_opts)
keymap('n', 'N', 'Nzz', default_opts)

-- Visual line wraps
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap('v', '<', '<gv', default_opts)
keymap('v', '>', '>gv', default_opts)

-- Paste over currently selected text without yanking it
keymap('v', 'p', '"_dP', default_opts)

-- Switch buffer
keymap('n', '<S-h>', '<cmd>bprevious<cr>', default_opts)
keymap('n', '<S-l>', '<cmd>bnext<cr>', default_opts)

-- Cancel search highlighting with ESC
keymap('n', '<ESC>', '<cmd>nohlsearch<Bar>:echo<cr>', default_opts)

-- Move selected line / block of text in visual mode
keymap('x', 'K', "<cmd>move '<-2<cr>gv-gv", default_opts)
keymap('x', 'J', "<cmd>move '>+1<cr>gv-gv", default_opts)

-- Resizing panes
keymap('n', '<Left>', '<cmd>vertical resize +1<cr>', default_opts)
keymap('n', '<Right>', '<cmd>vertical resize -1<cr>', default_opts)
keymap('n', '<Up>', '<cmd>resize -1<cr>', default_opts)
keymap('n', '<Down>', '<cmd>resize +1<cr>', default_opts)
