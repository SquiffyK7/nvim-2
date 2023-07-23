local M = {}

local nls = require 'null-ls'
local nls_utils = require 'null-ls.utils'

local with_diagnostics_code = function(builtin)
	return builtin.with {
		diagnostics_format = '#{m} [#{c}]',
	}
end

local with_root_file = function(builtin, file)
	return builtin.with {

		condition = function(utils)
			return utils.root_has_file(file)
		end,
	}
end

local sources = {
	-- formatting
	-- nls.builtins.formatting.fixjson,
	nls.builtins.formatting.stylua.with {
		extra_args = {
			'--indent-type',
			'Spaces',
			'--indent-width',
			'2',
			'--quote-style',
			'AutoPreferSingle',
			'--call-parentheses',
			'None',
		},
	},

	-- -- diagnostics
	-- nls.builtins.diagnostics.write_good,
	-- -- b.diagnostics.markdownlint,
	-- -- b.diagnostics.eslint_d,
	-- nls.builtins.diagnostics.tsc,
	-- with_root_file(nls.builtins.diagnostics.selene, 'selene.toml'),
	-- with_diagnostics_code(nls.builtins.diagnostics.shellcheck),
	--
	-- -- code actions
	-- nls.builtins.code_actions.gitsigns,
	-- nls.builtins.code_actions.gitrebase,
	--
	-- -- hover
	-- nls.builtins.hover.dictionary,
}

function M.setup(opts)
	nls.setup {
		-- debug = true,
		debounce = 150,
		save_after_format = false,
		sources = sources,
		on_attach = opts.on_attach,
		root_dir = nls_utils.root_pattern '.git',
	}
end

return M
