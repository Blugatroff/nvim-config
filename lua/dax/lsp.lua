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

local on_attach = function(language) return function(_, bufnr)
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
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
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

require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

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
    settings = {
        plugin = {
            stan = {
                globalOn = false
            }
        }
    }
}
lsp.pyright.setup {
    on_attach = on_attach('python')
}

lsp.eslint.setup {
    on_attach = on_attach('eslint')
}

lsp.ocamllsp.setup {
    on_attach = on_attach('ocaml')
}

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'rust', 'lua', 'tsx', 'python', 'typescript', 'haskell' },
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

