vim.g.mapleader = ' '

vim.keymap.set('n', '<leader><leader>', function()
    vim.cmd(vim.api.nvim_replace_termcodes('normal <c-^>', true, true, true))
end, { noremap = true })

vim.keymap.set('n', '<C-p>', function()
    vim.cmd("FzfLua files")
end)

vim.keymap.set('n', '<up>', function() end)
vim.keymap.set('n', '<down>', function() end)

vim.keymap.set('i', '<up>', function() end)
vim.keymap.set('i', '<down>', function() end)
vim.keymap.set('i', '<left>', function() end)
vim.keymap.set('i', '<right>', function() end)

vim.keymap.set('n', '<C-t>', function() vim.cmd(':tabnew') end)
vim.keymap.set('n', '<C-k>', function() vim.cmd(':tabprevious') end)
vim.keymap.set('n', '<C-j>', function() vim.cmd(':tabnext') end)

vim.keymap.set('n', '<C-n>', function() vim.cmd(':vnew') end)
vim.keymap.set('n', '<C-m>', function() vim.cmd(':new') end)

vim.opt.timeoutlen = 200
vim.cmd("tnoremap jjj <C-\\><C-N>")

vim.keymap.set('n', '<C-h>', function() vim.cmd(':bp') end)
vim.keymap.set('n', '<C-l>', function() vim.cmd(':bn') end)
vim.keymap.set('n', '<C-q>', function() require('bufdelete').bufdelete(0, false) end)

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

