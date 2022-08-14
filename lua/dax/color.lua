require('gruvbox').setup()

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd('colorscheme kanagawa')

vim.cmd('autocmd BufRead,BufNewFile *.watim set filetype=watim')

