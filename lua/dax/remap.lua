vim.keymap.set('n', '<leader><leader>', function()
    vim.cmd(vim.api.nvim_replace_termcodes('normal <c-^>', true, true, true))
end, { noremap = true })

-- vim.keymap.set('n', '<C-p>', function()
    -- vim.cmd("Files")
-- end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
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
vim.keymap.set('n', '<C-n>', function() vim.cmd(':vsplit') end)
vim.keymap.set('n', '<C-m>', function() vim.cmd(':split') end)

vim.keymap.set('n', '<C-h>', function() vim.cmd(':bp') end)
vim.keymap.set('n', '<C-l>', function() vim.cmd(':bn') end)

vim.keymap.set('n', '<leader>w', function() vim.cmd(':bn | bd#') end)
vim.keymap.set('n', '<leader>q', function() vim.cmd(':tabclose') end)
vim.keymap.set('n', '<leader>z', function() require("buffer_manager.ui").toggle_quick_menu() end)

vim.keymap.set('n', '<F4>', ':update<C-M>:make<Up><C-M>')

vim.opt.timeoutlen = 200

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
vim.cmd('map <leader>a :bp<bar>sp<bar>bn<bar>bd<CR>')

vim.keymap.set('n', 'gm', '%')
vim.keymap.set('n', '0', '^')
vim.keymap.set('n', '^', '0')

vim.keymap.set('n', '<F4>', ':make<UP><ENTER>')

vim.g["conjure#mapping#doc_word"] = "gk"

local ranger_nvim = require('ranger-nvim')
ranger_nvim.setup({ replace_netrw = truk })
vim.api.nvim_create_user_command('Ranger',
  function(opts) ranger_nvim.open(true) end,
  { nargs = 0 })

