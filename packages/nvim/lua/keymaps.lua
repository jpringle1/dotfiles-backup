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

vim.keymap.set('n', '<leader>s', function()
  local reg = vim.fn.nr2char(vim.fn.getchar())
  vim.fn.setreg(reg, vim.fn.getreg('"'))
  vim.notify('Saved to register ' .. reg)
end)
