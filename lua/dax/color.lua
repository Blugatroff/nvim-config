-- require('gruvbox').setup()

vim.opt.termguicolors = true
vim.opt.background = "dark"
-- vim.cmd('colorscheme kanagawa')

vim.cmd('autocmd BufRead,BufNewFile *.watim set filetype=watim')

require('onedark').setup({
    style = 'warmer'
})
require('onedark').load()

