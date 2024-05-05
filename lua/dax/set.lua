vim.opt.relativenumber = true

vim.cmd("set list")
vim.cmd("set listchars=tab:!·,trail:·")
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'

vim.opt.wrap = false

vim.cmd('syntax on')
vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')

vim.keymap.set('n', '<space>rm', function() vim.cmd([[call delete(expand('%')) | bdelete!]]) end)

vim.cmd([[
let g:neovide_scale_factor=1.0
function! ChangeScaleFactor(delta)
    let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
endfunction
nnoremap <expr><C-=> ChangeScaleFactor(1.25)
nnoremap <expr><C--> ChangeScaleFactor(1/1.25)
]])

