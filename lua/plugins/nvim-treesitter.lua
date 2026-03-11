return {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    lazy = false,
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()
        local languages = { 'c', 'rust', 'lua', 'tsx', 'python', 'typescript', 'haskell', 'scheme', 'html' }
        treesitter.install(languages)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = languages,
            callback = function()
                vim.treesitter.start()
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo.foldmethod = 'expr'
                -- vim.bo.indentation = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        })
    end,
}
