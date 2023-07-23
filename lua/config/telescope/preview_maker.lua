-- Custom previewer - Skip binary files and text files larger than 500kb.
local previewers = require 'telescope.previewers'
local Job = require 'plenary.job'

local preview_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]

      if mime_type == 'text' then
        -- Check file size
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then
            return
          end
          if stat.size > 500000 then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      else
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY FILE' })
        end)
      end
    end,
  }):sync()
end

return preview_maker
