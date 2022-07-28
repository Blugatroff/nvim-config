local M = {}
M.merge = function(...)
    local res = {}
    print(select)
    for i = 1, select('#', ...) do
        local table = select(1, ...)
        if type(table) == "table" then
            for k, v in pairs(table) do
                res[k] = v
            end
        end
    end
    return res
end
return M
