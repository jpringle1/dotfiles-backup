-- lua/options.lua


-- See `:h vim.o`
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
--
-- Disable netrw in favour of yazi
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_browsex_viewer = "nvim" -- Open local markdown files in current vim buffer

-- Display
vim.o.number         = true
vim.o.relativenumber = true
vim.o.cursorline     = true
vim.o.scrolloff      = 10
vim.o.list           = true   -- show tabs and trailing spaces
vim.o.termguicolors  = true

-- Wrapping
vim.opt.wrap      = true
vim.opt.linebreak = true   -- wrap at word boundaries, not characters

-- Search
vim.o.ignorecase = true
vim.o.smartcase  = true   -- override ignorecase when query has capitals

-- Editing
vim.o.confirm = true   -- prompt to save instead of erroring on unsaved changes

-- Undo (persistant)
vim.opt.undofile = true
vim.opt.undodir  = vim.fn.expand("~/.vim/undo")

-- Clipboard: sync with OS after UI is ready (avoids startup slowdown)
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- [[ Optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by default.
-- You can enable any of them by using the `:packadd` command.
-- The below must be invoked. Nothing happens passively
vim.cmd('packadd! nohlsearch') -- auto turn off search highlights after 'updatetime' and when entering insert mode

-- Open local markdown files in current vim buffer
vim.keymap.set("n", "gx", function()
  local file = vim.fn.expand("<cfile>")
  vim.cmd("edit " .. file)
end, { silent = true })
