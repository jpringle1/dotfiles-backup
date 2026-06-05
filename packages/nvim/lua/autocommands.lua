-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ User commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })

-- [[restore session on directory change]]
-- specifcally for projects.nvim, when i change dir to a project it reopens previous session in that dir
vim.api.nvim_create_autocmd("DirChangedPre", {
  callback = function()
    require("persistence").save()
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    require("persistence").save()
  end,
})

vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    if vim.v.vim_did_enter == 1 then
      vim.cmd("%bd")
    end
    local ok = pcall(require("persistence").load)
    if ok then
      vim.defer_fn(function()
        vim.cmd("bufdo edit")
      end, 100)
    end
  end,
})
