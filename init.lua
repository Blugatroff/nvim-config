require('plugins')
require('dax')

require('lsp_lines').setup()
require('lsp-lens').setup({})
require('gitsigns').setup({})

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end
require('lualine').setup({
  sections = {
    lualine_b = { {'diff', source = diff_source}, },
  }
})

