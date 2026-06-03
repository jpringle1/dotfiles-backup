vim.loader.enable() -- mysterious fast loading plugin magic
vim.g.mapleader = ' ' -- Set leader key. Keep before loading Plugins. See `:help mapleader`

require('packages')
require('options')
require('keymaps')
require('autocommands')

require('plugins.ui')
require('plugins.editor')
require('plugins.telescope')
require('plugins.lsp')
require('plugins.completions')
require('plugins.dap')
require('plugins.markdown')

-- END
-- vim.treesitter.language.register("hcl", "terraform")
-- vim.treesitter.language.register("hcl", "tf")
--
-- vim.filetype.add({
--   extension = {
--     tf = "hcl",
--     tfvars = "hcl",
--   },
-- })
-- TODO: find way to define installed TreeSitter languages in-config
--
-- Keymap (outside setup)
-- vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", {
--   desc = "Toggle Outline",
-- })

-- Outline config
-- require("nvim-navbuddy").setup({})
