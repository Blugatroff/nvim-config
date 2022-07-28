return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use { 'ibhagwan/fzf-lua',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use 'nvim-lua/plenary.nvim'
    if vim.fn.has('macunix') ~= 0 then
        use 'gfanto/fzf-lsp.nvim'
    else
        use 'junegunn/fzf'
        use 'junegunn/fzf.vim'
    end
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use({
        "Maan2003/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })
    use 'famiu/bufdelete.nvim'
    use 'j-hui/fidget.nvim'
    use 'rebelot/kanagawa.nvim'
    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }
    use 'petertriho/nvim-scrollbar'
end)
