vim.g.mapleader = ' '
vim.g.maplocalleader = vim.g.mapleader

vim.keymap.set('n', '<leader><leader>', function()
    vim.cmd(vim.api.nvim_replace_termcodes('normal <c-^>', true, true, true))
end, { noremap = true })

-- vim.keymap.set('n', '<C-p>', function()
    -- vim.cmd("Files")
-- end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>f', builtin.buffers, {})
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            }
        }
    }
}

vim.cmd(':nnoremap <Leader>b :buffers<CR>:buffer<Space>')

vim.keymap.set('n', '<up>', function() end)
vim.keymap.set('n', '<down>', function() end)

vim.keymap.set('i', '<up>', function() end)
vim.keymap.set('i', '<down>', function() end)
vim.keymap.set('i', '<left>', function() end)
vim.keymap.set('i', '<right>', function() end)

vim.keymap.set('n', '<C-t>', function() vim.cmd(':tabnew') end)
vim.keymap.set('n', '<C-k>', function() vim.cmd(':tabprevious') end)
vim.keymap.set('n', '<C-j>', function() vim.cmd(':tabnext') end)

vim.cmd('set splitright')
vim.cmd('set splitbelow')
vim.keymap.set('n', '<C-n>', function() vim.cmd(':vnew') end)
vim.keymap.set('n', '<C-m>', function() vim.cmd(':new') end)

vim.keymap.set('n', '<C-h>', function() vim.cmd(':bp') end)
vim.keymap.set('n', '<C-l>', function() vim.cmd(':bn') end)

vim.keymap.set('n', '<leader>w', function() vim.cmd(':BufDel') end)
vim.keymap.set('n', '<leader>q', function() vim.cmd(':tabclose') end)

vim.opt.timeoutlen = 200
vim.cmd("tnoremap jjj <C-\\><C-N>")

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
vim.cmd('map <leader>a :bp<bar>sp<bar>bn<bar>bd<CR>')

vim.keymap.set('n', 'gm', '%')
vim.keymap.set('n', '0', '^')
vim.keymap.set('n', '^', '0')

