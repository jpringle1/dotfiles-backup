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

-- vim.api.nvim_set_hl(0, "TabLineSelLeft",  { fg = vim.api.nvim_get_hl(0, { name = "TabLineSel" }).bg,  bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
-- vim.api.nvim_set_hl(0, "TabLineSelRight", { fg = vim.api.nvim_get_hl(0, { name = "TabLineSel" }).bg,  bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
-- vim.api.nvim_set_hl(0, "TabLineLeft",     { fg = vim.api.nvim_get_hl(0, { name = "TabLine" }).bg,     bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
-- vim.api.nvim_set_hl(0, "TabLineRight",    { fg = vim.api.nvim_get_hl(0, { name = "TabLine" }).bg,     bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "TabLineSelLeft",  { fg = vim.api.nvim_get_hl(0, { name = "TabLineSel" }).bg,  bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
--     vim.api.nvim_set_hl(0, "TabLineSelRight", { fg = vim.api.nvim_get_hl(0, { name = "TabLineSel" }).bg,  bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
--     vim.api.nvim_set_hl(0, "TabLineLeft",     { fg = vim.api.nvim_get_hl(0, { name = "TabLine" }).bg,     bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
--     vim.api.nvim_set_hl(0, "TabLineRight",    { fg = vim.api.nvim_get_hl(0, { name = "TabLine" }).bg,     bg = vim.api.nvim_get_hl(0, { name = "TabLineFill" }).bg })
--   end,
-- })
--
-- function MyTabLine()
--   local s = ""
--   for i = 1, vim.fn.tabpagenr("$") do
--     local is_sel = i == vim.fn.tabpagenr()
--     local hl       = is_sel and "%#TabLineSel#"      or "%#TabLine#"
--     local hl_left  = is_sel and "%#TabLineSelLeft#"  or "%#TabLineLeft#"
--     local hl_right = is_sel and "%#TabLineSelRight#" or "%#TabLineRight#"
--
--     local buflist = vim.fn.tabpagebuflist(i)
--     local winnr   = vim.fn.tabpagewinnr(i)
--     local bufname = vim.fn.fnamemodify(vim.fn.bufname(buflist[winnr]), ":t")
--     if bufname == "" then bufname = "[No Name]" end
--
--     local modified = ""
--     for _, buf in ipairs(buflist) do
--       if vim.fn.getbufvar(buf, "&modified") == 1 then
--         modified = " ●"
--         break
--       end
--     end
--
--     s = s .. hl_left  .. "\u{E0B2}"
--     s = s .. hl       .. "%" .. i .. "T"
--     s = s .. " " .. bufname .. modified .. " "
--     s = s .. hl_right .. "\u{E0B0}"
--     s = s .. "%#TabLineFill#"
--   end
--
--   s = s .. "%#TabLineFill#%T"
--   return s
-- end
--
-- vim.opt.tabline = "%!v:lua.MyTabLine()"
