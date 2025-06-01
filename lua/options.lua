vim.opt.relativenumber = true
vim.opt.number = true

--tab settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

vim.opt.showtabline = 2
--settings from kickstart
--Time settings
-- Decrease update time
vim.o.updatetime = 250
-- Decrease mapped sequence wait time
vim.o.timeoutlen = 500
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.clipboard='unnamedplus'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.cmd('colorscheme industry')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

