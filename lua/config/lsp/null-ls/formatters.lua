local M = {}

local utils = require 'utils'
local nls_utils = require 'config.lsp.null-ls.utils'
local nls_sources = require 'null-ls.sources'

local method = require('null-ls').methods.FORMATTING

M.autoformat = true

function M.toggle()
	M.autoformat = not M.autoformat
	if M.autoformat then
		utils.info('Enabled format on save', 'Formatting')
	else
		utils.warn('Disabled format on save', 'Formatting')
	end
end

function M.format()
	if M.autoformat then
		vim.lsp.buf.format()
	end
end

function M.setup(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')

	local enable = false
	if M.has_formatter(filetype) then
		enable = client.name == 'null-ls'
	else
		enable = not (client.name == 'null-ls' or client.name == 'tsserver')

	end

	if not enable then
		return
	end

	client.server_capabilities.document_formatting = enable
	client.server_capabilities.document_range_formatting = enable
	if client.server_capabilities.documentFormattingProvider then
		local lsp_format_grp = vim.api.nvim_create_augroup('LspFormat', { clear = true })
		vim.api.nvim_create_autocmd('BufWritePre', {
			callback = function()
				M.format()
			end,
			group = lsp_format_grp,
			buffer = bufnr,
		})
	end
end

function M.has_formatter(filetype)
	local available = nls_sources.get_available(filetype, method)
	return #available > 0
end

function M.list_registered(filetype)
	local registered_providers = nls_utils.list_registered_providers_names(filetype)
	return registered_providers[method] or {}
end

function M.list_supported(filetype)
	local supported_formatters = nls_sources.get_supported(filetype, 'formatting')
	table.sort(supported_formatters)
	return supported_formatters
end

return M
