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
    for _, v in pairs(tbl) do
        if v == elem then
            return true
        end
    end
    return false
end

M.Filter = function(tbl, pred)
    local t = {}
    for k, v in pairs(tbl) do
        if pred(v) then
            t[k] = v
        end
    end
    return t
end

M.Concat = function(tbl1, tbl2)
    local t = {}
    for k, v in pairs(tbl1) do
        t[k] = v
    end
    for k, v in pairs(tbl2) do
        t[k] = v
    end
    return t
end

return M
