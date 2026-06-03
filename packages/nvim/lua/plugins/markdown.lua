
require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
    pipe_table = { preset = 'round' },
})


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
