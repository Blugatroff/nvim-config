require("dax.set")
require("dax.remap")
require("dax.lsp")
require("dax.color")
require("dax.line")

require('fidget').setup()

require('bufferline').setup({})
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

