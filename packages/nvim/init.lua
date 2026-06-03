vim.loader.enable() -- mysterious fast loading plugin magic
vim.g.mapleader = ' ' -- Set leader key. Keep before loading Plugins. See `:help mapleader`

-- disable netrw (so i can replace with yazi)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
-- See `:h vim.o`
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
vim.o.number = true -- Show line numbers
vim.opt.wrap = true -- wrap text
vim.opt.linebreak = true -- wrap text by words (not chars)
vim.o.relativenumber = true -- relative line numbers
vim.o.cursorline = true -- Highlight the line where the cursor is on
vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces
vim.o.confirm = true -- prompt to save before discarding changes to buffer

vim.o.ignorecase = true -- Case-insensitive searching
vim.o.smartcase = true -- UNLESS \C or one or more capital letters in the search term

-- Sync OS clipboard. 
-- Schedule the setting after `UiEnter` (for startup-time)
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- [[ Set up keymaps ]] 
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`
vim.opt.langmap = "hjkl\\;;\\;hjkl"

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- Invert completion arrow keys so up/down navigates up/down, and left/right enters and exits directories
-- TODO: FIX this, it works, but it also inverts in-editor tab completions. Makes them very unintuitive.
vim.keymap.set('c', '<Left>', '<Up>', { noremap = true })
vim.keymap.set('c', '<Right>', '<Down>', { noremap = true })
vim.keymap.set('c', '<Up>', '<Left>', { noremap = true })
vim.keymap.set('c', '<Down>', '<Right>', { noremap = true })

-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.opt.undofile = true -- Enable undo file (persistant undo)
vim.opt.undodir = vim.fn.expand("~/.vim/undo") -- Set undo file path

-- [[ User commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })

-- [[ Optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by default.
-- You can enable any of them by using the `:packadd` command.
-- The below must be invoked. Nothing happens passively
vim.cmd('packadd! nohlsearch') -- auto turn off search highlights after 'updatetime' and when entering insert mode

-- [[ Install packages ]]
vim.pack.add({
  { src = "https://github.com/junegunn/vim-peekaboo" }, -- Show registers
  { src = "https://github.com/tpope/vim-fugitive" }, -- Git tools
  { src = "https://github.com/simnalamburt/vim-mundo" }, -- Undo tree
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, -- Render markdown
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" }, -- Colourscheme
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- Syntax highlighting
  { src = "https://github.com/nvim-mini/mini.icons" }, -- Icon library (dependency)
  { src = "https://github.com/folke/which-key.nvim" }, -- Key binding hints
  { src = "https://github.com/hiphish/rainbow-delimiters.nvim" }, -- Rainbow brackets
  { src = "https://github.com/kylechui/nvim-surround" }, -- Keybinds to surround text with brackets/quotes
  { src = "https://github.com/mikavilpas/yazi.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  --- CMP (completions)
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  --- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" }, -- Lsp suggestions
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"},
  --- DAP
  { src = "https://github.com/mfussenegger/nvim-dap"},
  { src = "https://github.com/nvim-neotest/nvim-nio"},
  { src = "https://github.com/rcarriga/nvim-dap-ui"},
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text"},
  { src = "https://github.com/sphamba/smear-cursor.nvim"},

  ---
	-- { src = 'https://github.com/lambdalisue/vim-suda' }
  -- { src = "https://github.com/hedyhli/outline.nvim" }, -- Document symbol windows. TODO: not working, fix or use navbuddy
  -- { src = "https://github.com/SmiteshP/nvim-navbuddy" }, -- Document symbol windows. TODO: not finished setup. setup or figure out outline
})

require('smear_cursor').setup({
  -- Your options
})

vim.opt.termguicolors = true

require("nvim-dap-virtual-text").setup({
  enabled = true,

  enabled_commands = true,

  highlight_changed_variables = true,
  highlight_new_as_changed = true,

  show_stop_reason = true,

  commented = false,

  only_first_definition = false,
})
-- [[LSP/Mason setup]]
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {"lua_ls", "bashls", "shellcheck", "csharp_ls", "gopls"}
})

vim.diagnostic.config({
	virtual_text=true,
	signs=false,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gr", vim.lsp.buf.references, "Go to references")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("K", vim.lsp.buf.hover, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
  end,
})

vim.lsp.config("gopls", {})
vim.lsp.enable("gopls")
-- [[LSP setup end]]

-- [[DAP setup]]
local dap = require 'dap'
local dapui = require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end



dap.adapters.bashdb = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
  name = "bashdb",
}

dap.configurations.sh = {
  {
    type = "bashdb",
    request = "launch",
    name = "Launch Bash script",
    program = "${file}",
    cwd = "${workspaceFolder}",
    pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
    pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
    pathBash = "bash",
    pathCat = "cat",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    args = {},
    env = {},
    terminalKind = "integrated",
  },
}

dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return "python3"
    end,
  },
}-- [[DAP setup end]]

-- [[CMP setup]]
local cmp = require("cmp")

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
    pipe_table = { preset = 'round' },
})
-- [[CMP setup end]]


require("yazi").setup({
  open_for_directories = true,
})

vim.keymap.set("n", "<leader>e", function()
  require("yazi").yazi()
end, { desc = "Open Yazi file manager" })

require('mini.icons').setup()

vim.cmd('packadd! catppuccin')
vim.cmd.colorscheme("catppuccin-frappe")
require("bufferline").setup{
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

-- [[ Markdown files ]]
-- Underline rendering
vim.api.nvim_set_hl(0, "MarkdownUnderline", {
  underline = true,
})

-- Hide underline symbols (++)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- underline only the inner text
    vim.fn.matchadd("MarkdownUnderline", [[++\zs[^+]\+\ze++]])

    -- conceal the opening ++
    vim.fn.matchadd("Conceal", [[\(\s\|^\)\zs++]], 10, -1, { conceal = "" })

    -- conceal the closing ++
    vim.fn.matchadd("Conceal", [[++\ze\(\s\|$\)]], 10, -1, { conceal = "" })
  end,
})

-- Open local markdown files in current vim buffer
vim.g.netrw_browsex_viewer = "nvim"
vim.keymap.set("n", "gx", function()
  local file = vim.fn.expand("<cfile>")
  vim.cmd("edit " .. file)
end, { silent = true })
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

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

vim.keymap.set('n', 'gb', '<cmd>BufferLinePick<CR>')

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

-- telescope setup
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
-- vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = 'Telescope spell suggest' })
