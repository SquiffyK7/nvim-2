local M = {}

function M.setup()
  local cmp = require "cmp"

  cmp.setup {
    window = {
      -- completion = cmp.config.window.bordered(),
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
			},
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
      { name = "nvim_lsp" },
      -- { name = "treesitter" }, found out what this is
    },
  }

	-- To insert `(` after select function or method item
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	cmp.event:on(
		'confirm_done',
		cmp_autopairs.on_confirm_done()
	)
end

return M
