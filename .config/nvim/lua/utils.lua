M = {}

M.Map = function(tbl, f)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

M.Foreach = function(tbl, f)
    for k, v in pairs(tbl) do
        f(k, v)
    end
end

M.Contains = function(tbl, elem)
    return tbl[elem] ~= nil
end

return M
