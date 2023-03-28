return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use 'nvim-lua/plenary.nvim'
    -- use 'junegunn/fzf'
    -- use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use 'chentoast/marks.nvim'
    use 'ojroques/nvim-bufdel'
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
    use 'j-hui/fidget.nvim'
    use 'rebelot/kanagawa.nvim'
    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    }
    use 'purescript-contrib/purescript-vim'
    use 'sbdchd/neoformat'
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use 'chrisbra/unicode.vim'
    use 'navarasu/onedark.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end)

