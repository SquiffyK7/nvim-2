local M = {}

function M.setup()
  require('scrollbar').setup {
    set_highlights = false,

    marks = {
      Cursor = {
        text = '•',
      },

      Search = {
        text = { '▬', '▐' },
      },

      Error = {
        text = { '▬', '▐' },
      },

      Warn = {
        text = { '▬', '▐' },
      },

      Info = {
        text = { '▬', '▐' },
      },

      Hint = {
        text = { '▬', '▐' },
      },

      Misc = {
        text = { '?', '?' },
      },

      GitAdd = {
        text = '▌',
      },

      GitChange = {
        text = '▌',
      },
      GitDelete = {
        text = '▌',
      },
    },
  }

  require('config.gitsigns').setup()
  require('scrollbar.handlers.gitsigns').setup()
  require('scrollbar.handlers.search').setup {
    -- hlslens config overrides
  }
end

return M
