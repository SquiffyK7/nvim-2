local M = {}

function M.setup()
  local scrollbbar_bg = '$bg0'
  local scrollbar_handle_bg = '$bg3'

  require('onedark').setup {
    style = 'light',
    highlights = {
      ['NvimTreeNormal'] = { bg = 'bg0' },
      ['NvimTreeEndOfBuffer'] = { bg = 'bg0' },

      ['ScrollbarHandle'] = { bg = scrollbar_handle_bg },
      ['ScrollbarCursorHandle'] = { bg = scrollbar_handle_bg, fg = '$fg' },
      ['ScrollbarCursor'] = { bg = scrollbbar_bg, fg = '$fg' },

      ['ScrollbarSearchHandle'] = { bg = scrollbar_handle_bg, fg = '$bg_yellow' },
      ['ScrollbarSearch'] = { bg = scrollbbar_bg, fg = '$bg_yellow' },

      ['ScrollbarErrorHandle'] = { bg = scrollbar_handle_bg, fg = '$red' },
      ['ScrollbarError'] = { bg = scrollbbar_bg, fg = '$red' },

      ['ScrollbarWarnHandle'] = { bg = scrollbar_handle_bg, fg = '$dark_yellow' },
      ['ScrollbarWarn'] = { bg = scrollbbar_bg, fg = '$dark_yellow' },

      ['ScrollbarInfoHandle'] = { bg = scrollbar_handle_bg, fg = '$dark_cyan' },
      ['ScrollbarInfo'] = { bg = scrollbbar_bg, fg = '$dark_cyan' },

      ['ScrollbarHintHandle'] = { bg = scrollbar_handle_bg, fg = '$dark_purple' },
      ['ScrollbarHint'] = { bg = scrollbbar_bg, fg = '$dark_purple' },

      ['ScrollbarMiscHandle'] = { bg = scrollbar_handle_bg, fg = '$red' },
      ['ScrollbarMisc'] = { bg = scrollbbar_bg, fg = '$red' },

      ['ScrollbarGitAdd'] = { bg = scrollbbar_bg, fg = '$green' },
      ['ScrollbarGitAddHandle'] = { bg = scrollbar_handle_bg, fg = '$green' },
      ['ScrollbarGitChange'] = { bg = scrollbbar_bg, fg = '$blue' },
      ['ScrollbarGitChangeHandle'] = { bg = scrollbar_handle_bg, fg = '$blue' },
      ['ScrollbarGitDelete'] = { bg = scrollbbar_bg, fg = '$red' },
      ['ScrollbarGitDeleteHandle'] = { bg = scrollbar_handle_bg, fg = '$red' },
    },
  }
  require('onedark').load()

  -- Set Podfile syntax highlighting for ruby
  vim.cmd 'autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby'
end

return M
