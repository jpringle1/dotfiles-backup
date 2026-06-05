-- telescope setup
require('telescope').setup({
  defaults = {
    layout_strategy = "flex",
    sorting_strategy = "ascending",  -- top level in defaults, not in layout_config
    layout_config = {
      prompt_position = "top",
      flex = {
        flip_columns = 125,
      },
      horizontal = {
        preview_width = 0.55,
      },
      vertical = {
        preview_height = 0.4,
	mirror = true
      },
    },
  },
})

-- [[normalise backslash to forwardslash (for windows)]]

local make_entry = require("telescope.make_entry")
local original = make_entry.gen_from_file

make_entry.gen_from_file = function(opts)
  local entry_maker = original(opts)
  return function(line)
    local entry = entry_maker(line)
    if entry then
      entry.ordinal = entry.ordinal:gsub("\\", "/")
      local original_display = entry.display
      if type(original_display) == "function" then
        entry.display = function(e)
          local display_str, highlights = original_display(e)
          return display_str:gsub("\\", "/"), highlights
        end
      elseif type(original_display) == "string" then
        entry.display = original_display:gsub("\\", "/")
      end
    end
    return entry
  end
end
-- [[ end backslash normalisation ]]

require('telescope').load_extension('projects')

vim.api.nvim_create_autocmd("User", { -- enable word wrap in previewer
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.wrap = true
  end,
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>f#', builtin.grep_string, { desc = 'Telescope grep string' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old files' })
vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Telescope quickfix' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Telescope registers' })
vim.keymap.set('n', '<leader>f.', builtin.resume, { desc = 'Telescope resume' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
vim.keymap.set('n', '<leader>flr', builtin.lsp_references, { desc = 'Telescope references' })
vim.keymap.set('n', '<leader>fli', builtin.lsp_implementations, { desc = 'Telescope implementations' })
vim.keymap.set('n', '<leader>flci', builtin.lsp_incoming_calls, { desc = 'Telescope incoming calls' })
vim.keymap.set('n', '<leader>flco', builtin.lsp_outgoing_calls, { desc = 'Telescope outgoing calls' })
vim.keymap.set('n', '<leader>fls', builtin.lsp_document_symbols, { desc = 'Telescope symbols' })
vim.keymap.set('n', '<leader>fltd', builtin.lsp_type_definitions, { desc = 'Telescope type definitions' })
vim.keymap.set('n', '<leader>fp',  "<cmd>Telescope projects<cr>", { desc = 'Telescope projects' })
-- vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = 'Telescope spell suggest' })
