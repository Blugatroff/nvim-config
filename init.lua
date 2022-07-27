require('plugins')
require('dax')


function reload()
    for name, _ in pairs(package.loaded) do 
        if name:match('^dax') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
end

