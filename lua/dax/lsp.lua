local toggle_lsp_lines = (function()
    local lsp_lines_enabled = true
    return function()
        lsp_lines_enabled = not lsp_lines_enabled
        vim.diagnostic.config({
            virtual_lines = lsp_lines_enabled,
            virtual_text = not lsp_lines_enabled
        })
    end
end)()
toggle_lsp_lines()
vim.keymap.set('n', '<C-x>', toggle_lsp_lines, { noremap = true })

local cmp = require('cmp')

vim.cmd('set completeopt=menu,menuone,noselect')
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

local lsps = {
    rust_analyzer = {
        language = 'rust',
        cmd = { 'rust-analyzer' },
        settings = {
            ['rust-analyzer'] = {
                procMacro = {
                    enable = true
                },
            }
        },
    },
    ts_ls = { language = 'typescript' },
    purescriptls = {
        language = 'purescript',
        root_markers = { 'spago.yaml' },
        settings = {
            purescript = {
                addSpagoSources = true,
                censorWarnings = {
                    'ShadowedName',
                    'MissingTypeDeclaration'
                }
            },
            formatter = 'purs-tidy'
        },
        flags = { debounce_text_changes = 150 },
        more_setup = function()
            vim.cmd("let g:neoformat_enabled_purescript = ['purstidy']")
        end
    },
    hls = {
        language = 'haskell',
        filetypes = { 'haskell', 'cabal' },
        settings = {
            plugin = {
                stan = {
                    globalOn = false
                }
            },
            haskell = { formattingProvider = 'fourmolu' },
        }
    },
    eslint = { language = 'typescript' },
    ocamllsp = { language = 'ocaml' },
    wgsl_analyzer = {
        language = 'wgsl',
        more_setup = function()
            vim.cmd('au BufNewFile,BufRead *.wgsl set filetype=wgsl')
        end
    },
    clangd = { language = 'c' },
    pyright = { language = 'python' },
}

local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = require('dax.on_attach')

for name, config in pairs(lsps) do
    config.capabilities = config.capabilities or capabilities
    config.on_attach = config.on_attach or on_attach(config.language)
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
    if config.more_setup then config.more_setup() end
end

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'rust', 'lua', 'tsx', 'python', 'typescript', 'haskell', 'scheme' },
    highlight = {
        enable = true,
    }
}

-- vim.lsp.config('purescript_analyzer', {
--     cmd = { '/home/jasper/clones/purescript-analyzer/target/debug/purescript-analyzer' },
--     filetypes = { 'purescript' },
--     root_markers = { 'output', 'spago.lock' },
--     on_attach = on_attach('purescript')
-- })
-- vim.lsp.enable('purescript_analyzer')

