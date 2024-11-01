local config = {
    cmd = {'jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = require('dax.on_attach')('java'),
}
require('jdtls').start_or_attach(config)

