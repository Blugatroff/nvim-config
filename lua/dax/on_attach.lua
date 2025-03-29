return function(language) return function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
    local telescope_builtins = require('telescope.builtin')
    vim.keymap.set('n', 'gr', function() telescope_builtins.lsp_references() end, bufopts)
    local format = function() vim.lsp.buf.format({async = true }) end
    if language == 'lua' or language == 'purescript' then
        format = function() vim.cmd('Neoformat') end
    end
    vim.keymap.set('n', '<leader>f', format, require('dax.util').merge(bufopts, { noremap = true }))
    vim.keymap.set('n', '<leader>l', vim.lsp.codelens.refresh, bufopts)
    vim.keymap.set('n', '<leader>k', vim.lsp.codelens.run, bufopts)

    vim.g.diagnostics_active = true
    local toggle_diagnostics = function()
        if vim.g.diagnostics_active then
            vim.g.diagnostics_active = false
            vim.diagnostic.reset()
            vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
        else
            vim.g.diagnostics_active = true
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                { virtual_text = true
                , signs = true
                , underline = true
                , update_in_insert = false
                }
            )
        end
    end
    vim.keymap.set('n', '<leader>c', toggle_diagnostics,  {noremap = true, silent = true})
end end

