return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'akinsho/bufferline.nvim', tag = "v4.*", requires = 'nvim-tree/nvim-web-devicons'}
    use 'famiu/bufdelete.nvim'
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })
    use { 'j-hui/fidget.nvim', tag = 'legacy' }
    use 'rebelot/kanagawa.nvim'
    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }
    use 'purescript-contrib/purescript-vim'
    use 'sbdchd/neoformat'

    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    use 'chrisbra/unicode.vim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'VidocqH/lsp-lens.nvim'
    use 'rhysd/vim-wasm'

    use 'lervag/vimtex'

    use 'ChrisWellsWood/roc.vim'
    use 'DingDean/wgsl.vim'

    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    -- use 'Olical/conjure'
    use 'perillo/qbe.vim'
    use { "catppuccin/nvim", as = "catppuccin" }

    use 'mfussenegger/nvim-jdtls'
end)

