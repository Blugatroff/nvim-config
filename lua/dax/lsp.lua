local lsp_lines_enabled = falselsp
local function toggle_lsp_lines()
    lsp_lines_enabled = not lsp_lines_enabled
    vim.diagnostic.config({
        virtual_lines = lsp_lines_enabled,
        virtual_text = not lsp_lines_enabled
    })
end
toggle_lsp_lines()
vim.keymap.set('n', '<C-x>', toggle_lsp_lines, { noremap = true })

local cmp = require('cmp')

vim.cmd("set completeopt=menu,menuone,noselect")
local luasnip = require('luasnip')
local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            return vim_item
        end
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

on_attach = require('dax.on_attach')

local lsp = require('lspconfig')
lsp.rust_analyzer.setup({
    cmd = { "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            }
        }
    },
    on_attach = on_attach(),
    capabilities = capabilities,
})

lsp.ts_ls.setup({
    on_attach = on_attach('typescript'),
    capabilities = capabilities,
})

vim.cmd("let g:neoformat_enabled_purescript = ['purstidy']")
lsp.purescriptls.setup {
    -- cmd = { "nc", "localhost", "3000" },
    on_attach = on_attach('purescript'),
    root_dir = lsp.util.root_pattern("spago.yaml"),
    settings = {
        purescript = {
            addSpagoSources = true,
            censorWarnings = {
                "ShadowedName",
                "MissingTypeDeclaration"
            }
        },
        formatter = "purs-tidy"
    },
    flags = {
        debounce_text_changes = 150,
    }
}

lsp.hls.setup {
    on_attach = on_attach('haskell'),
    filetypes = { 'haskell', 'cabal' },
    settings = {
        plugin = {
            stan = {
                globalOn = false
            }
        },
        haskell = {
            formattingProvider = "fourmolu",
        },
    }
}

lsp.eslint.setup {
    on_attach = on_attach('eslint')
}

lsp.ocamllsp.setup {
    on_attach = on_attach('ocaml')
}

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'rust', 'lua', 'tsx', 'python', 'typescript', 'haskell', 'scheme' },
    highlight = {
        enable = true,
        -- disable = { 'tsx' }
    }
}

lsp.wgsl_analyzer.setup {
    on_attach = on_attach('wgsl')
}
vim.cmd("au BufNewFile,BufRead *.wgsl set filetype=wgsl")

lsp.clangd.setup {
    on_attach = on_attach('c')
}

vim.tbl_deep_extend('keep', lsp, {
    roc_language_server = {
        filetypes = 'roc',
        cmd = { "roc_language_server" },
    }
})

require('lspconfig.configs').roc_language_server = {
  default_config = {
    cmd = { "roc_language_server" },
    filetypes = { 'roc' },
    root_dir = lsp.util.root_pattern("flake.nix"),
    settings = {},
  };
}
vim.cmd("au BufNewFile,BufRead *.roc set filetype=roc")
lsp.roc_language_server.setup {
    on_attach = on_attach('roc')
}

lsp.pyright.setup {}

