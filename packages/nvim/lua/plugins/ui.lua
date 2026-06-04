require('mini.icons').setup()

vim.cmd('packadd! catppuccin')
vim.cmd.colorscheme("catppuccin-frappe")

require('colorizer').setup()
require('lualine').setup {
  sections = {
    lualine_b = {
      {
        'branch',
        fmt = function(str)
          -- get branch for current buffer's directory
          local buf_dir = vim.fn.expand('%:p:h')
          local branch = vim.fn.systemlist('git -C ' .. buf_dir .. ' branch --show-current')[1]
          return branch or str
        end
      },
      'diff', 'diagnostics'
    },
  }
}

require("bufferline").setup {
	options = {
		separator_style = "slant",
		show_close_icon = false,
		-- numbers = "buffer_id",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
		  local s = " "
		  for e, n in pairs(diagnostics_dict) do
		    local sym = e == "error" and " "
		      or (e == "warning" and " " or " ")
		    s = s .. n .. sym
		  end
		  return s
		end,
		custom_areas = {
		    left = function()
			local result = {}
			local seve = vim.diagnostic.severity
			local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
			local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
			local info = #vim.diagnostic.get(0, {severity = seve.INFO})
			local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

			if error ~= 0 then
			    table.insert(result, {text = "  " .. error, link = "DiagnosticError"})
			end

			if warning ~= 0 then
			    table.insert(result, {text = "  " .. warning, link = "DiagnosticWarn"})
			end

			if hint ~= 0 then
			    table.insert(result, {text = "  " .. hint, link = "DiagnosticHint"})
			end

			if info ~= 0 then
			    table.insert(result, {text = "  " .. info, link = "DiagnosticInfo"})
			end
			return result
		    end,
		    }
	},
} --must be after colorscheme


vim.keymap.set('n', 'gb', '<cmd>BufferLinePick<CR>')

